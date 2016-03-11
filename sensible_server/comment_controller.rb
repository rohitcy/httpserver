require 'sqlite3'

DB = SQLite3::Database.open "comments.db"

class CommentController

  def self.create(params)
    begin
      DB.execute "CREATE TABLE IF NOT EXISTS comment_detail(Id INTEGER PRIMARY KEY,
        Name TEXT, Email TEXT, Comment TEXT)"
      DB.execute "INSERT INTO comment_detail(Name, Email, Comment) VALUES('#{params[0]}','#{params[1]}','#{params[2]}')"
      rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
    "From Submitted successfully!!"
  end

  def self.read_all
    puts "HELLO FROM READ ALL"
    begin
      rows = DB.execute( "select * from comment_detail" )
      rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
    "<html>"+generate_html(rows)+"</html>"
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
