require_relative './httpserver'

socket = HttpServer.new('127.0.0.1',2000)
while (client = socket.tcp_socket.accept)
  socket.send_response(client,client.gets)
end
