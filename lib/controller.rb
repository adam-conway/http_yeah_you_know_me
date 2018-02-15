require 'pry'
require './lib/paths/game'
require './lib/paths/hello'
require './lib/paths/word_search'
require './lib/paths/shutdown'
require './lib/paths/datetime'

class Controller
  def initialize(verb, path)
    @verb = verb
    @path = path
  end

  def get_path(path)
    case path
    when '/' then [@verb, path]
    when '/hello' then [@verb, path]
    when '/datetime' then [@verb, path]
    when '/shutdown' then [@verb, path]
    when '/word_search' then [@verb, path]
    when '/game' then [@verb, path]
    end
  end

  # def path(path, verb)
  #   if verb == 'GET'
  #     get_path(path)
  #     # if path == '/'
  #     #   @response.diagnostics
  #     # elsif path == '/hello'
  #     #   @hello.call
  #     # elsif path == '/datetime'
  #     #   datetime
  #     # elsif path == '/shutdown'
  #     #   shutdown
  #     # elsif path == '/word_search'
  #     #   @word_search.check_dictionary(@response.parameter)
  #     # elsif path == '/game'
  #     #   @game.number_of_guesses
  #     #   @game.evaluate_guess
  #     # else
  #     #   '404'
  #     # end
  #   else
  #     post_path()
  #     if path == '/start_game'
  #       @game = Game.new
  #       @game.start
  #     elsif path == '/game'
  #       @game.make_a_guess(@guess)
  #       "Testing stuff"
  #       path('/game', 'GET')
  #     else
  #       '404'
  #     end
  #   end
  # end

  def get_path(path)
    case path
    when '/' then [@verb, path]
    when '/hello' then [@verb, path]
    when '/datetime' then [@verb, path]
    when '/shutdown' then [@verb, path]
    when '/word_search' then [@verb, path]
    when '/game' then [@verb, path]
    end
  end

  # def post_path(path)
  #   case path
  #   when '/start_game' then
  #   when '/game' then
  # end

end
