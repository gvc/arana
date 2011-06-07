# encoding: utf-8

module Arana
  class Word < ActiveRecord::Base
    
    def self.create_or_update_word(term, count)
      word = Arana::Word.find_by_term(term) || Arana::Word.new(term: term, count: 0)
      
      word.count += count
      word.save!
    end
  end
end