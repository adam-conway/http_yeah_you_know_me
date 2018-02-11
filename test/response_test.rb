require_relative 'test_helper'
require './lib/response'
require 'pry'

class ResponseTest < MiniTest::Test
  def test_response_class_exists
    response = Response.new

    assert_instance_of Response, response
  end
end
