# encoding: utf-8

class Link
  
  attr_reader :target, :title
  
  def initialize(title, target)
    @title = title
    @target = target
  end
end