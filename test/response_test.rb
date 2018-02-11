require_relative 'test_helper'
require './lib/response'
require 'pry'

class ResponseTest < MiniTest::Test
  def setup
    @response_info = ["GET / HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: no-cache",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36",
                     "Postman-Token: 4883113e-0f45-62a8-d833-d6851d70c2ff",
                     "Accept: */*",
                     "Accept-Encoding: gzip, deflate, br",
                     "Accept-Language: en-US,en;q=0.9"]
  end
  def test_response_class_exists
    response = Response.new(@response_info)

    assert_instance_of Response, response
  end

  def test_response_saves_info
    response = Response.new(@response_info)

    assert_equal "GET", response.verb
    assert_equal "/", response.path
    assert_equal "HTTP/1.1", response.protocol
    assert_equal "127.0.0.1", response.host
    assert_equal "9292", response.port
    assert_equal "127.0.0.1", response.origin
    assert_equal "*/*", response.accept
  end
end
