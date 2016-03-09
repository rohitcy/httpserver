class GetResponse

  def self.store_in_file(form_data)
    stream = File.open('form_data.txt','a')
    stream.write(form_data +"/n")
    stream.close
    txt = open("success.html")
    txt.read
  end

  def self.get_response_file(extracted_uri)
    extracted_uri = "index" if extracted_uri.nil?
    return "Content-Type: text/html; charset=utf-8 HTTP/1.1 404 Not Found" unless (File.exist?("html/"+extracted_uri + ".html"))
    txt = open("html/"+extracted_uri + ".html")
    txt.read
  end

end
