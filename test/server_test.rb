require './test/test_helper'
require './lib/server'
require 'pry'

class ServerTest < MiniTest::Test
  def test_server_initializes_with_different_ports
    skip
    server = Server.new(2001)

    assert_instance_of Server, server
    assert_instance_of TCPServer, server.tcp_server
  end

  def test_server_increments_hello_world
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expected = 'Hello World!(1)'

    assert response.body.start_with?(expected)

    response = Faraday.get 'http://127.0.0.1:9292/hello'
    expected = 'Hello World!(2)'

    assert response.body.start_with?(expected)
  end

  def test_path_method
    server = Server.new(2002)
    time = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
    @response = Response.new(["Accept:1","2"])

    assert_equal "1,2", server.path('/')
    assert_equal "Hello World!(1)", server.path('/hello')
    assert_equal time, server.path('/datetime')
    assert_equal '404', server.path('help')
  end
end
