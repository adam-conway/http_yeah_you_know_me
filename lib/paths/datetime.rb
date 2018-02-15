class Datetime
  def current_time
    Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
  end
end
