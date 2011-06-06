# encoding: utf-8

require 'nokogiri'
require 'open-uri'

require_relative 'arana/crawler'
require_relative 'arana/link'

module Arana
  
  def self.crawl
    Arana::Crawler.new.links.each do |link|
      puts "#{link.title} - #{link.target}"
    end
  end
end

Arana.crawl