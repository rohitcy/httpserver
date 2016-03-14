MAPPINGS = {
  'savedata' => 'comment_controller#create',
  'comments' => 'comment_controller#read_all',
  'comments/' => 'comment_controller#read_comment'
}

MAPPINGS.values.each { |file| require_relative "../#{file.split("#")[0]}" }

class RequestMapper

  def self.get_handeller(request)
    return  MAPPINGS[request.split(/[0-9]/)[0]] if request.include?('/')
    return "static" if MAPPINGS[request].nil?
    MAPPINGS[request]
  end

  def self.serveStatic(url)
    return "Content-Type: text/html; charset=utf-8 HTTP/1.1 404 Not Found" unless (File.exist?("html/"+url + ".html"))
    txt = open("html/"+ url + ".html")
    txt.read
  end

  def self.serveDynamic(action, params)
    params = Array.new if params.nil?
    controller_class = get_controller_name(action)
    method = action.split("#")[1]
    controller_obj = eval("#{controller_class}.new(params)")
    response = eval("controller_obj.#{method}")
    response
  end

  def self.get_controller_name(action)
    action.split("#")[0].split('_').map {|str| str.capitalize}.join
  end

end
