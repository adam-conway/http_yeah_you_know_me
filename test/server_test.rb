require_relative 'test_helper'
require './lib/server'
require 'pry'

class ServerTest < MiniTest::Test
  def test_server_increments_hello_world
    Faraday.get "http://127.0.0.1:9292"
    response = Faraday.get "http://127.0.0.1:9292"
    expected = "<html><head></head><body>Hello World!(2)</body></html>"

    assert_equal expected, response.body
  end
end
