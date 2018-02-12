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
    # count = 0
    loop do
      puts "Ready for a request"
      listener = @tcp_server.accept
      request = []
      # count += 1
      while line = listener.gets and !line.chomp.empty?
        request << line.chomp
      end

      puts "Sending response."
      @response = Response.new(request)
      # hello = "Hello World!(#{count})"
      # output = "#{hello}\n<html><head></head><body><pre>\n#{response.diagnostics}\n</pre></body></html>"
      output = path(@response.path)
      header = @response.headers(output.length)
      listener.puts header
      listener.puts "<html><body><pre>#{output}</pre></body></html>"

      puts ["Wrote this response:", output].join("\n")
      listener.close
      puts "\nResponse complete : Exiting."
    end
  end

  def path(response_path)
    if response_path == '/'
      root
    elsif response_path == '/hello'
      hello
    end
  end

  def root
    @response.diagnostics
  end

  def hello
    @count += 1
    "Hello World!(#{count})"
  end
end
