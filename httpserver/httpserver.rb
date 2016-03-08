require 'socket'

class HttpServer

  attr_accessor :tcp_socket

  def initialize(host,port)
    @tcp_socket = TCPServer.new(host,port)
  end

  def send_response(client,request_type)
    response = extract_request(request_type)
    puts "#{request_type}"
    client.puts "#{response}"
    client.close
  end

  private

  def extract_request(request_type)

    case request_type.split(" ")[1]
    when "/home"
      get_file("home")
    when "/about"
      get_file("about")
    when "/"
      get_file("root")
    else
      "404: Resource Not Found"
    end

  end

  def get_file(filename)
    txt = open(filename << ".html")
    txt.read
  end


end


