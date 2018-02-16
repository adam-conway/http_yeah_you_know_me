require 'pry'
require './lib/paths/game'
require './lib/paths/hello'
require './lib/paths/word_search'
require './lib/paths/shutdown'
require './lib/paths/datetime'
require './lib/response'

class Controller
  def initialize(server)
    @server = server
    @hello = Hello.new
    @game = nil
    @status = "200 ok"
    @redirect_path = nil
  end

  def begin_loop
    @response = Response.new(@server.request)
    @verb = @response.verb
    @path = @response.path
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

    @pathing = "<html><head></head><body>#{route}</body></html>"
    header = @response.headers(@pathing.length, @status, @redirect_path)

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
    when '/game' then @game.compiler
    end
  end

  def post(path)
    case path
    when '/start_game' then start_game
    when '/game' then post_game
    end
  end

  def start_game
    @game = Game.new
    @game.start
  end

  def post_game
    @game.make_a_guess(get_post_data)

    header = @response.headers(5, "302", "/game")

    @server.listener.puts header
    @game.compiler
  end

  def get_post_data
    @post_data = @server.listener.read(@response.content_length.to_i)
    @post_data.split[-2].to_i
  end
end
