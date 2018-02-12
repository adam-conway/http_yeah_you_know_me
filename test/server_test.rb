require_relative 'test_helper'
require './lib/server'
require 'pry'

class ServerTest < MiniTest::Test
  def test_server_increments_hello_world
    response = Faraday.get 'http://127.0.0.1:9292'
    expected = 'Hello World!'
    first_num = response.body[13].to_i

    assert response.body.start_with?(expected)

    response = Faraday.get 'http://127.0.0.1:9292'
    second_num = response.body[13].to_i
    
    assert_equal first_num + 1, second_num
  end

  def test_response_method
    Faraday.get 'http://127.0.0.1:9292'

  end
end
