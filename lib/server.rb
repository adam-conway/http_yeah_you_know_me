require 'pry'
require 'socket'
# require './lib/paths/game'
# require './lib/paths/hello'
# require './lib/paths/word_search'
# require './lib/paths/shutdown'
# require './lib/paths/datetime'
# require './lib/response'
require './lib/controller'

class Server
  attr_reader :tcp_server, :request, :listener, :total_requests
  def initialize(port = 9292)
    @tcp_server = TCPServer.new(port)
    @tcp_server.listen(1)
    @total_requests = 0
    # @controller = Controller.new
    # @hello = Hello.new
    # @word_search = WordSearch.new
    # @shutdown = Shutdown.new
    # @datetime = Datetime.new
    # @total_count = 0
  end

  def start
    loop do
      @total_requests += 1
      puts "Ready for a request"
      @request = []
      @listener = @tcp_server.accept
      # @total_count += 1
      while line = @listener.gets and !line.chomp.empty?
        @request << line.chomp
      end

      Controller.new(self).begin



      # puts "Got this request:"
      # puts @request.inspect
      #
      # puts "Sending Response."
      # # @response = Response.new(@request)
      # # build_new_controller unless @controller.is_a?(Controller)
      # # # @controller = Controller.new(@response)
      # # @post_data = @listener.read(@response.content_length.to_i)
      # # @guess = @post_data.split[-2].to_i
      # control_response = @controller.route
      # #
      # header = @response.headers(control_response.length)
      #
      # @listener.puts header
      # @listener.puts control_response
      # puts ["Wrote this response:", control_response].join("\n")
      # puts "\nResponse complete : Exiting."
    end
    @listener.close
  end

  # def build_new_controller
  #   @controller = Controller.new(@response)
  # end

  # def path(path, verb)
  #   if verb == 'GET'
  #     if path == '/'
  #       @response.diagnostics
  #     elsif path == '/hello'
  #       @hello.call
  #     elsif path == '/datetime'
  #       @datetime.current_time
  #     elsif path == '/shutdown'
  #       @shutdown.close_server(@tcp_server, @total_count)
  #     elsif path == '/word_search'
  #       @word_search.check_dictionary(@response.parameter)
  #     elsif path == '/game'
  #       @game.number_of_guesses
  #       @game.evaluate_guess
  #     else
  #       '404'
  #     end
  #   else
  #     if path == '/start_game'
  #       @game = Game.new
  #       @game.start
  #     elsif path == '/game'
  #       @game.make_a_guess(@guess)
  #       path('/game', 'GET')
  #     else
  #       '404'
  #     end
  #   end
  # end
end
