# encoding: utf-8

require 'digest/md5'

module Arana
  class Link < ActiveRecord::Base
    
    def initialize(args)
      super(args)
      self.title = Digest::MD5.hexdigest(args[:title])
    end
        
    def visit
      open(self.target) do |f|
        doc = Nokogiri::XML(f)
        words = treat_text(doc.css('p').map { |a| a.content })
        p words
        words.each_pair do |term, count|
          Arana::Word.create_or_update_word(term, count)
        end
      end
    end
    
    private
    
    def treat_text(content)
      frequency = {}
      content[1..-1].map { |c| c.encode!('UTF-8', 'ISO-8859-1').downcase.delete(':.?\\"()\-%/') }.select { |c| c.size > 30 }.join(' ').split(/\s/).each do |word|
        begin
          Integer(word)
        rescue ArgumentError
          frequency[word] ||= 0
          frequency[word] += 1          
        end
      end
      
      frequency
    end
  end
end