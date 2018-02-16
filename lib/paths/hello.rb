require './lib/response'
require 'pry'

class Hello < Response
  attr_reader :count
  def initialize
    @count = 0
  end

  def call
    @count += 1
    "Hello World!(#{@count})"
  end
end
