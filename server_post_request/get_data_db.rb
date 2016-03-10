require 'sqlite3'

DB = SQLite3::Database.open "comments.db"

class GetResponseDb

  def self.store_in_db(data)
    begin
      DB.execute "CREATE TABLE IF NOT EXISTS comment_detail(Id INTEGER PRIMARY KEY,
        Name TEXT, Email TEXT, Comment TEXT)"
      DB.execute "INSERT INTO comment_detail(Name, Email, Comment) VALUES('#{data[0]}','#{data[1]}','#{data[2]}')"
      rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
  end

  def self.retrieve_all_data
    begin
    rows = DB.execute( "select * from comment_detail" )
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
  end

  def self.retrieve_data(id)
    begin
    "<html>" + DB.get_first_value("select comment from comment_detail where id=#{id}") + "</html>"
    rescue SQLite3::Exception => e
      puts "Exception occurred"
      puts e
      ensure
    end
  end



end
