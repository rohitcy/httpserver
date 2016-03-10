require_relative './get_data_db'

class GenerateResponse

  def self.handle_get(extracted_uri)
    case extracted_uri
    when "comments"
      rows = GetResponseDb.retrieve_all_data
      "<html>" + generate_html(rows) + "</html>"
    when /\d/
      GetResponseDb.retrieve_data(extracted_uri.to_i)
    else
      extracted_uri = "index" if extracted_uri.nil?
      return "Content-Type: text/html; charset=utf-8 HTTP/1.1 404 Not Found" unless (File.exist?("html/"+extracted_uri + ".html"))
      txt = open("html/"+extracted_uri + ".html")
      txt.read
    end
  end

  def self.handle_post(form_data)
    GetResponseDb.store_in_db(form_data.split("&").map { |str| str.split("=")[1] })
    txt = open("html/"+"success" + ".html")
    txt.read
  end

  def self.generate_html(rows)
    rows.map do |row|
    generate_table(row)
    end.join("<br><br>")
  end

  def self.generate_table(row)
   "<tr><td><a href='comments/#{row[0]}'>#{row[0]}</a></td>&nbsp;&nbsp;&nbsp;&nbsp;<td>#{row[1]}</td> <td>#{row[2]}</td>&nbsp;&nbsp;&nbsp;&nbsp;<td>#{row[3]}</td></tr>"
  end

end
