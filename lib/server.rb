require 'pry'
require 'socket'
require_relative 'response'

class Server
  attr_reader :tcp_server,
              :request
  def initialize
    @tcp_server = TCPServer.new(9292)
    @request = []
  end

  def start
    count = 0
    loop do
      puts "Ready for a request"
      listener = @tcp_server.accept
      count += 1
      while line = listener.gets and !line.chomp.empty?
        request << line.chomp
      end

      puts "Got this request:"
      puts request.inspect

      puts "Sending response."
      response = Response.new(request)
      output = "<html><head></head><body><pre>
               Hello World!(#{count})
               Verb: #{response.verb}
               Path: #{response.path}
               Protocol: #{response.protocol}
               Host: #{response.host}
               Port: #{response.port}
               Origin: #{response.origin}
               Accept: #{response.accept}
               </pre></body></html>"

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

  end
end
