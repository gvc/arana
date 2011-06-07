# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'active_record'

require_relative 'arana/crawler'
require_relative 'arana/link'
require_relative 'arana/word'

module Arana
  
  def self.crawl
    configure!
    puts 'Crawling for news on elpais.com'
    links = Arana::Crawler.new.links.select { |l| Arana::Link.find_by_title(l.title).nil? }
    
    if links.empty?
      puts 'Nothing new on Spain!'
    else
      puts "-" * links.size
    end
    
    links.each do |link|
      link.visit
      link.save!

      print "+"
    end
    
    puts '' if links.any?
  end
  
  private
  
  def self.configure!
    db_file = File.expand_path(File.join(File.path(__FILE__), '..', '..', 'db', 'arana.sqlite3'))
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_file)
  end
end

Arana.crawl