require_relative './generate_response'

class ProcessRequest

  def self.request_processor(request)
    case_variable = request.gets.split(" ")
    request_hash = generate_request_hash(request)
    case case_variable[0]
    when "POST"
      GetResponse.store_in_file(request.read(request_hash["Content-Length"].to_i))
    else "GET"
      GetResponse.get_response_file(case_variable[1].split("/")[1])
    end
  end

  private

  def self.generate_request_hash(request)
    request_hash = {}
    while line = request.gets.split(' ',2)
      break if line[0].strip == ""
      request_hash[line[0].chop] = line[1].strip
    end
    request_hash
  end

end
