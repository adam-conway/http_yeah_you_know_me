require 'pry'
require 'socket'

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
      count += 1
      request = []
      while line = listener.gets and !line.chomp.empty?
        request << line.chomp
      end

      puts "Got this request:"
      binding.pry
      puts request.inspect

      puts "Sending response."
      response = "<pre>" + request.join("\n") + "</pre>"

      output = "<html><head></head><body>Hello World!(#{count})</body></html>" #{}"\n#{response}</body></html>"

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
end
