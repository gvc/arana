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
        headlines = doc.css('h2.t-xl a')
        
        links = []
        headlines.each do |anchor|
          links << Link.new(anchor[:title], "#{url}#{anchor[:href]}?print=1")
        end
        
        links
      end
    end
  end
end