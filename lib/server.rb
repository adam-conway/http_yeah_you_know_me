require 'pry'
require 'socket'
require './lib/game'
require_relative 'response'

class Server
  attr_reader :tcp_server, :count
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @tcp_server.listen(1)
    @hello_count = 0
    @total_count = 0
  end

  def start
    loop do
      puts "Ready for a request"
      @request = []
      @listener = @tcp_server.accept
      @total_count += 1
      while line = @listener.gets and !line.chomp.empty?
        @request << line.chomp
      end

      puts "Got this request:"
      puts @request.inspect

      puts "Sending Response."
      @response = Response.new(@request)
      @post_data = @listener.read(@response.content_length.to_i)
      @guess = @post_data.split[-2].to_i

      path_response = path(@response.path, @response.verb)

      header = @response.headers(path_response.length)

      @listener.puts header
      @listener.puts path_response
      puts ["Wrote this response:", path_response].join("\n")
      puts "\nResponse complete : Exiting."
    end
    @listener.close
  end

  def path(path, verb)
    if verb == 'GET'
      if path == '/'
        root
      elsif path == '/hello'
        hello
      elsif path == '/datetime'
        datetime
      elsif path == '/shutdown'
        shutdown
      elsif path == '/word_search'
        word_search
      elsif path == '/game'
        @game.number_of_guesses
        @game.evaluate_guess
        #go and get info from game
      else
        '404'
      end
    else
      if path == '/start_game'
        @game = Game.new
        @game.start
        #start the game
      elsif path == '/game'
        @game.make_a_guess(@guess)
        path('/game', 'GET')
        #user makes guess, store guess, and redirect to GET /game
      else
        '404'
      end
    end
  end

  def root
    @response.diagnostics
  end

  def hello
    @hello_count += 1
    "Hello World!(#{@hello_count})"
  end

  def datetime
    Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
  end

  def shutdown
    @tcp_server.close
    "Total Requests: #{@total_count}"
  end

  def word_search
    dictionary = File.read("/usr/share/dict/words").split
    if dictionary.include?(@response.parameter)
      "#{@response.parameter} is a known word"
    else
      "#{@response.parameter} is not a known word"
    end
  end
end
