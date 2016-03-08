require 'socket'

class CreateSocket

  attr_accessor :tcp_socket

  def initialize(host,port)
    @tcp_socket = TCPServer.new(host,port)
  end

  def send_response(client)
    client.puts "HTTP/1.1 200/OK\r\nContent-type: text/html\r\n\r\n"
    client.close
  end

end

socket = CreateSocket.new('127.0.0.1',2000)
while (client = socket.tcp_socket.accept)
  puts "Request: #{client.gets}"
  socket.send_response(client)
end
