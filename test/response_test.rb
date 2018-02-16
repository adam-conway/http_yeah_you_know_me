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
    assert_nil response.parameter
  end

  def test_diagnostics_method_outputs_data
    response = Response.new(@response_info)

    expectation = "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: */*"

    assert_equal expectation, response.diagnostics
  end

  def test_headers_method
    response = Response.new(@response_info)
    output = "help"
    status = '200 ok'
    redirect_path = nil
    expected = ["http/1.1 #{status}",
                "Location: #{redirect_path}",
                "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                "server: ruby",
                "content-type: text/html; charset=iso-8859-1",
                "content-length: #{output.length}\r\n\r\n"].compact.join("\r\n")

    assert_equal expected, response.headers(output.length, status, redirect_path)
  end
end
