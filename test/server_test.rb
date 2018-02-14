require_relative 'test_helper'
require './lib/server'
require './lib/response'
require 'pry'

class ServerTest < MiniTest::Test
  def setup
    # @response_info = ["GET / HTTP/1.1",
    #                  "Host: 127.0.0.1:9292",
    #                  "Connection: keep-alive",
    #                  "Cache-Control: no-cache",
    #                  "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36",
    #                  "Postman-Token: 4883113e-0f45-62a8-d833-d6851d70c2ff",
    #                  "Accept: */*",
    #                  "Accept-Encoding: gzip, deflate, br",
    #                  "Accept-Language: en-US,en;q=0.9"]
    # @server = Server.new(9292)
  end

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
    skip
    server = Server.new(2002)
    time = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
    # @response = Response.new(@response_info) Can't figure out how to get this test to run

    # Test shutdown
    # assert_equal @response.diagnostics, server.path('/') Can't figure out how to get this test to run
    assert_equal "Hello World!(1)", server.path('/hello')
    assert_equal time, server.path('/datetime')
    assert_equal '404', server.path('help')
  end

  def test_hello
    skip
    server = Server.new(2003)
    @count = 0

    assert_equal "Hello World!(1)", server.hello
  end

  def test_datetime
    skip
    server = Server.new(2004)
    time = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')

    assert_equal time, server.datetime
  end

  def test_shutdown
    assert_equal "Total Requests: 0", Server.new(1543).shutdown
  end
end
