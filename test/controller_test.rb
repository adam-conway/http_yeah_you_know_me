require './test/test_helper'
require './lib/controller'
require './lib/server'

class ControllerTest < MiniTest::Test
  def test_root
    response = Faraday.get 'http://127.0.0.1:9292/'

    assert_equal '', response
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end
end
