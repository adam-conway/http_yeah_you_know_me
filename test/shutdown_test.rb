require './test/test_helper'
require './lib/paths/shutdown'
require './lib/server'

class ShutdownTest < MiniTest::Test
  def setup
    @shutdown = Shutdown.new
  end

  def test_class_exists
    assert_instance_of Shutdown, @shutdown
  end

  def test_server_closes
    server = Server.new(3030)
    requests = 1
    assert_equal 'Total Requests: 1', @shutdown.close_server(server.tcp_server, requests)
  end
end
