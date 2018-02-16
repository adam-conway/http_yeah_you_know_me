require './test/test_helper'
require './lib/paths/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_initializes
    assert @game.num >= 0 && @game.num <= 100
    assert_equal [], @game.guesses
  end

  def test_start
    assert_equal "Good luck!", @game.start
  end

  def test_make_a_guess
    @game.make_a_guess("Taco")

    assert_equal ["Taco"], @game.guesses
  end

  def test_evaluate_guess
    @game.make_a_guess(101)

    assert_equal "Wayyyyy tooooo high", @game.evaluate_guess

    @game.make_a_guess(0)

    assert_equal "Toooooo low", @game.evaluate_guess

    @game.make_a_guess(@game.num)

    assert_equal "Nice, you're correct.", @game.evaluate_guess
  end

  def test_number_of_guesses
    @game.make_a_guess(101)

    assert_equal "You have guessed 1 times", @game.number_of_guesses
  end

  def test_compiler
    @game.make_a_guess(@game.num)

    assert_equal "You have guessed 1 times\nNice, you're correct.", @game.compiler
  end
end
