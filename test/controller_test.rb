require './test/test_helper'
require './lib/controller'
require './lib/server'

class ControllerTest < MiniTest::Test
  def setup
    server = Server.new
    @controller = Controller.new('GET', '/', server)
  end

  def test_class_exists
    assert_instance_of Controller, @controller
  end

  def test_get_method
    skip
    assert_equal '/', @controller.get('/')
    assert_equal '/hello', @controller.get('/hello')
    assert_equal '/datetime', @controller.get('/datetime')
    assert_equal '/shutdown', @controller.get('/shutdown')
    assert_equal '/word_search', @controller.get('/word_search')
    assert_equal '/game', @controller.get('/game')
  end

  def test_post_method
  end
end
