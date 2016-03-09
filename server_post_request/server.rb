require 'socket'
require_relative './request_controller'

HOST = ARGV[0].nil? ? '127.0.0.1' : ARGV[0]
PORT = ARGV[1].nil? ? 2000 : ARGV[1]
socket = TCPServer.new(HOST,PORT)
while (request = socket.accept)
    RequestController.new(request).process
end
