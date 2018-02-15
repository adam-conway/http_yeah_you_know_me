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

  def post_path(path)
    case path
    when '/start_game' then
    when '/game' then
  end

end
