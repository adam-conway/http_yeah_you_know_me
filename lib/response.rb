require 'pry'

class Response
  attr_reader :verb, :path, :protocol, :host, :port, :origin, :accept, :parameter, :content_length

  def initialize(response_info)
    @verb = response_info[0].split[0]
    @path = response_info[0].split[1].split('?').first
    @protocol = response_info[0].split[2]
    @host = response_info[1].split[1].split(':')[0]
    @port = response_info[1].split[1].split(':')[1]
    @origin = response_info[1].split[1].split(':')[0]
    @accept = response_info.find { |item| item.start_with?('Accept:') }.split[1]
    @parameter = response_info[0].split[1].split('?')[1].split('=')[1] unless response_info[0].split[1].split('?')[1].nil?
    @content_length = response_info.find { |item| item.start_with?('Content-Length:') }.split[1] if @verb == "POST"
  end

  def diagnostics
    "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{origin}\nAccept: #{accept}"
  end

  def headers(length)
    ["http/1.1 200 ok",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1",
     "content-length: #{length}\r\n\r\n"].join("\r\n")
  end

  def response_301
  end
end
