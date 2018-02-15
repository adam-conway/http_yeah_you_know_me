require 'pry'

class Game
  attr_reader :num, :guesses
  def initialize
    @num = rand(0..100)
    @guesses = []
  end

  def start
    "Good luck!"
  end

  def make_a_guess(guess)
    @guesses << guess
  end

  def evaluate_guess
    if @guesses.last < @num
      "Toooooo low"
    elsif @guesses.last > @num
      "Wayyyyy tooooo high"
    else
      "Nice, you're correct."
    end
  end

  def number_of_guesses
    "You have guessed #{@guesses.length} times"
  end
end
