class Game
  attr_reader :num
  def initialize
    @num = rand(0..100)
  end
end
