require 'sqlite3'
require 'uri'

DB = SQLite3::Database.open "comments.db"

class CommentController

  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def create
    begin
      DB.execute "CREATE TABLE IF NOT EXISTS comment_detail\
        (Id INTEGER PRIMARY KEY,
        Name TEXT, Email TEXT, Comment TEXT)"
      DB.execute "INSERT INTO comment_detail(Name, Email, Comment)\
        VALUES('#{params[0]}','#{params[1]}','#{params[2]}')"
      rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
    "<html>"+"From Submitted successfully!!"+"</html>"
  end

  def read_all
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

  def read_comment
    id = params.split('/')[1]
    begin
      "<html>" + DB.get_first_value("select comment from comment_detail where id=#{id}") + "</html>"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
  end

  def generate_html(rows)
    rows.map do |row|
    generate_table(row)
    end.join("<br><br>")
  end

  def generate_table(row)
    "<tr><td><a href='comments/#{row[0]}'>#{row[0]}</a></td>&nbsp;\
      &nbsp;&nbsp;&nbsp;<td>#{row[1]}</td> <td>#{row[2]}</td>&nbsp;\
      &nbsp;&nbsp;&nbsp;<td>#{row[3]}</td></tr>"
  end

end
