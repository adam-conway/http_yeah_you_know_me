require_relative 'test_helper'
require './lib/server'
require 'pry'

class ServerTest < MiniTest::Test
  def test_server_initializes_with_different_ports
    server = Server.new(2001)

    assert_instance_of Server, server
    assert_instance_of TCPServer, server.tcp_server
  end

  def test_server_increments_hello_world
    response = Faraday.get 'http://127.0.0.1:9292'
    expected = 'Hello World!(1)'

    assert response.body.start_with?(expected)

    response = Faraday.get 'http://127.0.0.1:9292'
    expected = 'Hello World!(2)'

    assert response.body.start_with?(expected)
  end
end
