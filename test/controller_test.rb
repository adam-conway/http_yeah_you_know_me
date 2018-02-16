require './test/test_helper'
require './lib/controller'
require './lib/server'

class ControllerTest < MiniTest::Test
  def test_it_exists
    controller = Controller.new("Hello")

    assert_instance_of Controller, controller
  end

  def test_redirect_301
    controller = Controller.new("hi")
    controller.redirect_301

    assert_equal controller.status, '301 Moved Permanently'
    assert_nil controller.redirect_path
  end

  def test_redirect_302
    controller = Controller.new("hi")
    controller.redirect_302

    assert_equal '302', controller.status
    assert_equal '/game', controller.redirect_path
  end

  def test_redirect_403
    controller = Controller.new("hi")
    controller.redirect_403

    assert_equal '403 Forbidden', controller.status
    assert_nil controller.redirect_path
  end

  def test_redirect_404
    controller = Controller.new("hi")
    controller.redirect_404

    assert_equal '404 Not Found', controller.status
    assert_nil controller.redirect_path
  end

  def test_redirect_500
    controller = Controller.new("hi")
    controller.redirect_500

    assert_equal '500 Internal Server Error', controller.status
    assert_equal '/game', controller.redirect_path
  end

  def test_root
    response = Faraday.get "http://127.0.0.1:9292/"
    substring = 'Host: Faraday'

    assert response.body.include?(substring)
  end

  def test_hello
    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert response.body.include?('Hello World!(1)')

    response = Faraday.get 'http://127.0.0.1:9292/hello'

    assert response.body.include?('Hello World!(2)')
  end

  def test_datetime
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
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=help'
    expected = "<html><head></head><body>help is a known word</body></html>"

    assert_equal expected, response.body
  end
end
