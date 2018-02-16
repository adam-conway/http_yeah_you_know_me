require 'socket'
require './lib/controller'

class Server
  attr_reader :tcp_server, :request, :listener, :total_requests
  def initialize(port = 9292)
    @tcp_server = TCPServer.new(port)
    @tcp_server.listen(1)
    @total_requests = 0
  end

  def start
    loop do
      @total_requests += 1
      puts 'Ready for a request'
      @request = []
      @listener = @tcp_server.accept
      while line = @listener.gets and !line.chomp.empty?
        @request << line.chomp
      end
      @controller = Controller.new(self) unless @controller.is_a?(Controller)
      @controller.begin_loop
    end
    @listener.close
  end
end
