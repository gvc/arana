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
    count = 0
    Arana::Crawler.new.links.each do |link|
      unless Arana::Link.find_by_title(link.title)
        link.visit
        link.save!
        count += 1
        exit(0) if count == 2
      end
    end
  end
  
  private
  
  def self.configure!
    db_file = File.expand_path(File.join(File.path(__FILE__), '..', '..', 'db', 'arana.sqlite3'))
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: db_file)
  end
end

Arana.crawl