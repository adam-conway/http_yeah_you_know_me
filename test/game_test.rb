require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_starts_with_rand_num
    game = Game.new

    assert game.num >= 0 && game.num <= 100
  end
end
