require './test/test_helper'
require './lib/controller'
require './lib/server'

class ControllerTest < MiniTest::Test
  def test_it_exists
    skip
    controller = Controller.new("Hello")

    assert_instance_of Controller, controller
  end

  def test_root
    skip
    response = Faraday.get "http://127.0.0.1:9292/"
    substring = 'Host: Faraday'

    assert response.body.include?(substring)
  end

  def test_hello
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert_equal '<html>Hello World!(1)</html>', response.body

    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert_equal '<html>Hello World!(2)</html>', response.body
  end

  def test_datetime
    skip
    response = Faraday.get 'http://127.0.0.1:9292/datetime'
    expected = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')

    assert response.body.include?(expected)
  end

  def test_shutdown
    skip
    response = Faraday.get 'http://127.0.0.1:9292/shutdown'
    expected = "Total Requests: #{requests}"

    assert_equal expected, response
  end

  def test_word_search
    skip
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=help'
    expected = "<html>help is a known word</html>"

    assert_equal expected, response.body
  end

  def test_game
    response = Faraday.get 'http://127.0.0.1:9292/game'
  end

  def test_
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
  end

  # def teardown
  #   Shutdown.new.close_server(@server.tcp_server, @server.total_requests)
  # end
end
