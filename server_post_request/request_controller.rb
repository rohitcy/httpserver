require_relative './process_request'

class RequestController

  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def process
    response = ProcessRequest.request_processor(request)
    send_response(response)
  end

  def send_response(response)
    @request.puts "#{response}"
    @request.close
  end

end

