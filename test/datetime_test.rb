require './test/test_helper'
require './lib/paths/datetime'

class DatetimeTest < MiniTest::Test
  def test_class_exists
    datetime = Datetime.new

    assert_instance_of Datetime, datetime
  end

  def test_current_time
    datetime = Datetime.new
    expected = Time.now.strftime('%I:%M%p on %A, %B %d, %Y')

    assert_equal expected, datetime.current_time
  end
end
