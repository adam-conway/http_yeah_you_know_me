class Shutdown
  def close_server(server, requests)
    server.close
    "Total Requests: #{requests}"
  end
end
