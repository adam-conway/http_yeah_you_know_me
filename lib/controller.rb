require 'pry'
require './lib/paths/game'
require './lib/paths/hello'
require './lib/paths/word_search'
require './lib/paths/shutdown'
require './lib/paths/datetime'
require './lib/server'
require './lib/response'

class Controller
  def initialize(server)
    @server = server
    @response = Response.new(@server.request)
    @hello = Hello.new
    @game = Game.new
    @verb = @response.verb
    @path = @response.path
  end

  def begin
    inspect_incoming_request
    response_to_client
    finish_loop
  end

  def inspect_incoming_request
    puts "Got this request:"
    puts @server.request.inspect
  end

  def response_to_client
    puts "Sending Response."
    @pathing = route
    header = @response.headers(@pathing.length)

    @server.listener.puts header
    @server.listener.puts @pathing
  end

  def finish_loop
    puts ["Wrote this response:", @pathing].join("\n")
    puts "\nResponse complete : Exiting."
  end

  def route
    if @verb == 'GET'
      get(@path)
    else
      post(@path)
    end
  end

  def get(path)
    case path
    when '/' then  @response.diagnostics
    when '/hello' then @hello.call
    when '/datetime' then Datetime.new.current_time
    when '/shutdown' then Shutdown.new.close_server(@server.tcp_server, @server.total_requests)
    when '/word_search' then WordSearch.new.check_dictionary(@response.parameter)
    # when '/game' then '/game' #[@verb, path]
    end
  end

  # def post(path)
  #   case path
  #   when '/start_game' then
  #   when '/game' then
  #   end
  # end

end
