require_relative './process_request'
require_relative './request_mapper'
require_relative './serve_response'

class RequestController

  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def handle_request
    request_details = ProcessRequest.get_request_details(request)
    url = request_details["GET"].nil? ? request_details["POST"].split(" ")[0].gsub('/','') : request_details["GET"].split(" ")[0].gsub('/','')
    action = RequestMapper.get_handeller(url)
    case action
    when "static"
      response = GenerateResponse.serveStatic(url)
    else
      request_det_par = ProcessRequest.extract_params(request_details,request)
      puts "#{request_det_par}"
      response = GenerateResponse.serveDynamic(action,request_det_par["params"])
   end
    sendResponse(response)
  end

  def sendResponse(response)
    request.puts "#{response}"
    request.close
  end

end
