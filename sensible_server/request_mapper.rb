MAPPINGS = { 'savedata' => 'create' }

class RequestMapper

  def self.get_handeller(request)
    puts "#{request}"
    return "static" if MAPPINGS[request].nil?
    MAPPINGS[request]
  end

end
