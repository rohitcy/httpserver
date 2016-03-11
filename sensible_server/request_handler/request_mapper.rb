MAPPINGS = {
  'savedata' => 'comment_controller#create',
  'comments' => 'comment_controller#read_all'
}
MAPPINGS.values.each {|file| require_relative "../#{file.split("#")[0]}" }

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
    controller = get_controller_name(action)
    method = action.split("#")[1]
    eval("#{controller}.#{method}(#{params})") if params.nil?
    eval("#{controller}.#{method}")
  end

  def self.get_controller_name(action)
    action.split("#")[0].split('_').map {|str| str.capitalize}.join
  end

end
