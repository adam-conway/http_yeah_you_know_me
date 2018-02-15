require 'pry'
require 'socket'
require_relative 'response'

class Server
  attr_reader :tcp_server, :count
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @tcp_server.listen(1)
    @hello_count = 0
    @total_count = 0
    @server_on = true
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

      puts "Sending response."
      @response = Response.new(@request)
      path_response = path(@response.path)
      header = @response.headers(path_response.length)

      @listener.puts header
      @listener.puts path_response
      puts ["Wrote this response:", path_response].join("\n")
      puts "\nResponse complete : Exiting."
    end
    @listener.close
  end

  def path(response_path)
    if response_path == '/'
      root
    elsif response_path == '/hello'
      hello
    elsif response_path == '/datetime'
      datetime
    elsif response_path == '/shutdown'
      shutdown
    elsif response_path == '/word_search'
      word_search
    else
      '404'
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
