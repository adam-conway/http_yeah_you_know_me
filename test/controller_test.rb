require './test/test_helper'
require './lib/controller'

class ControllerTest < MiniTest::Test
  def setup
    @controller = Controller.new('GET', '/')
  end

  def test_class_exists
    assert_instance_of Controller, @controller
  end
end
