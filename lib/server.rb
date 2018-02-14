require 'pry'
require 'socket'
require_relative 'response'

class Server
  attr_reader :tcp_server, :count
  def initialize(port)
    @tcp_server = TCPServer.new(port)
    @count = 0
  end

  def start
    loop do
      puts "Ready for a request"
      listener = @tcp_server.accept
      request = []
      while line = listener.gets and !line.chomp.empty?
        request << line.chomp
      end

      puts "Sending response."
      @response = Response.new(request)
      path_response = path(@response.path)
      header = @response.headers(path_response.length)

      listener.puts header
      listener.puts path_response

      puts ["Wrote this response:", path_response].join("\n")
      listener.close
      puts "\nResponse complete : Exiting."
    end
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
    else
      '404'
    end
  end

  def root
    @response.diagnostics
  end

  def hello
    @count += 1
    "Hello World!(#{@count})"
  end

  def datetime
    Time.now.strftime('%I:%M%p on %A, %B %d, %Y')
  end
end
