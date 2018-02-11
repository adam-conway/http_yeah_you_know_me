require_relative 'test_helper'
require './lib/server'

class ServerTest < MiniTest::Test

  def setup
    @server = Server.new
  end

  def test_server_class_exists
    assert_instance_of Server, @server
  end
end
