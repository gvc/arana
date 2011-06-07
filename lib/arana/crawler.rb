# encoding: utf-8

module Arana
  class Crawler
    
    attr_reader :url, :links
    
    def initialize
      @url = 'http://www.elpais.com'
      @links = obtain_links
    end
    
    private
    
    def obtain_links
      open("#{url}/global") do |f|
        doc = Nokogiri::XML(f)
        headlines = doc.css('h2.t-xl a, h2.t-l a')
        
        links = []
        headlines.each do |anchor|
          target = anchor[:href].starts_with?('/') ? "#{url}#{anchor[:href]}?print=1" : "#{anchor[:href]}?print=1"
          links << Arana::Link.new(title: anchor[:title], target: target)
        end
        
        links
      end
    end
  end
end