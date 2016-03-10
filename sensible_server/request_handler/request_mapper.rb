MAPPINGS = { 'savedata' => 'create' }

class RequestMapper

  def self.get_handeller(request)
    puts "#{request}"
    return "static" if MAPPINGS[request].nil?
    MAPPINGS[request]
  end

  def self.serveStatic(url)
    return "Content-Type: text/html; charset=utf-8 HTTP/1.1 404 Not Found" unless (File.exist?("html/"+url + ".html"))
    txt = open("html/"+ url + ".html")
    txt.read
  end

  def self.serveDynamic(action, params)
    puts "hello"
  end

end
