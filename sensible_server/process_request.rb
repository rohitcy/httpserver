class ProcessRequest

  def self.get_request_details(request)
    generate_request_hash(request)
  end

  def self.generate_request_hash(request)
    request_hash = {}
    while line = request.gets.split(' ',2)
      break if line[0].strip == ""
      request_hash[line[0].gsub(':','')] = line[1].strip
    end
    request_hash
  end

  def self.extract_params(request_hash, request)
    if request_hash["POST"].nil?
      params = request_hash["Referer"].split('?')[1].split('&').map { |str| str.split("=")[1] }
      request_hash["params"] = params
    else
      request_hash["params"] = request.read(request_hash["Content-Length"].to_i).split("&").map { |str| str.split("=")[1] }
    end
    request_hash
  end

end
