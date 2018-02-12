require 'pry'
require 'socket'
require_relative 'response'

class Server
  attr_reader :tcp_server
  def initialize
    @tcp_server = TCPServer.new(9292)
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

      headers = ["http/1.1 200 ok",
                 "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
                 "server: ruby",
                 "content-type: text/html; charset=iso-8859-1",
                 "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      listener.puts headers
      listener.puts output


      puts ["Wrote this response:", output].join("\n")
      listener.close
      puts "\nResponse complete : Exiting."
    end
  end

  def responding
    puts "Sending response."
    response = Response.new(request)

  end
end
