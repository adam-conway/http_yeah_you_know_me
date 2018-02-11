require 'pry'

class Response
  attr_reader :verb,
              :path,
              :protocol,
              :host,
              :port,
              :origin,
              :accept

  def initialize(response_info)
    @verb = response_info[0].split[0]
    @path = response_info[0].split[1]
    @protocol = response_info[0].split[2]
    @host = response_info[1].split[1].split(':')[0]
    @port = response_info[1].split[1].split(':')[1]
    @origin = response_info[1].split[1].split(':')[0]
    @accept = response_info[6].split[1]
  end
end
