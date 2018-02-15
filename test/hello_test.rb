require './test/test_helper'
require './lib/hello'

class HelloTest < Minitest::Test
  def setup
    @hello = Hello.new
  end

  def test_it_exists
    assert_instance_of Hello, @hello
  end

  def test_it_initializes
    assert_equal 0, @hello.count
  end

  def test_calling_hello
    assert_equal "Hello World!(1)", @hello.call
    assert_equal 1, @hello.count
  end
end
