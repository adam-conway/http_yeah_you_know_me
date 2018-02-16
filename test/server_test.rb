require './test/test_helper'
require './lib/server'
require 'pry'

class ServerTest < MiniTest::Test
  def test_server_initializes_with_different_ports
    server = Server.new(2001)

    assert_instance_of Server, server
    assert_instance_of TCPServer, server.tcp_server
  end
end
