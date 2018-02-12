require 'pry'
require 'socket'
require_relative 'response'

class Server
  attr_reader :tcp_server
  def initialize(port)
    @tcp_server = TCPServer.new(port)
  end

  def start
    count = 0
    loop do
      puts "Ready for a request"
      listener = @tcp_server.accept
      request = []
      count += 1
      while line = listener.gets and !line.chomp.empty?
        request << line.chomp
      end

      puts "Sending response."
      response = Response.new(request)
      hello = "Hello World!(#{count})"
      output = "#{hello}\n<html><head></head><body><pre>\n#{response.diagnostics}\n</pre></body></html>"

      header = headers(output)

      listener.puts header
      listener.puts output


      puts ["Wrote this response:", output].join("\n")
      listener.close
      puts "\nResponse complete : Exiting."
    end
  end

  def headers(output)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

end
