require_relative 'test_helper'
require './lib/server'

class ServerTest < MiniTest::Test

  def test_server_increments_hello_world
    Faraday.get "http://127.0.0.1:9292"
    response = Faraday.get "http://127.0.0.1:9292"
    expected = "Hello World!(2)"

    assert_equal expected, response.body
  end
end
