require_relative './request_mapper'

class RequestController

  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def handle_request
    request_details = get_request_details(request)
    url = request_details["GET"].nil? ? request_details["POST"].split(" ")[0].gsub('/','') : request_details["GET"].split(" ")[0].gsub('/','')
    action = RequestMapper.get_handeller(url)
    case action
    when "static"
      response = RequestMapper.serveStatic(url)
    else
      request_det_par = extract_params(request_details,request)
      puts "#{request_det_par}"
      response = RequestMapper.serveDynamic(action,request_det_par["params"])
   end
    sendResponse(response)
  end

  def get_request_details(request)
    request_hash = {}
    while line = request.gets.split(' ',2)
      break if line[0].strip == ""
      request_hash[line[0].gsub(':','')] = line[1].strip
    end
    request_hash
  end

  def extract_params(request_hash, request)
    if request_hash["POST"].nil?
      params = request_hash["Referer"].split('?')[1].split('&').map { |str| str.split("=")[1] }
      request_hash["params"] = params
    else
      request_hash["params"] = request.read(request_hash["Content-Length"].to_i).split("&").map { |str| str.split("=")[1] }
    end
    request_hash
  end

  def sendResponse(response)
    request.puts "#{response}"
    request.close
  end

end
