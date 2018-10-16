require "sqlite3"
require "pp"
class IndexScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../templates") }
    end
    get '/' do
        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file
        db.execute( "select * from banner" ) do |row|
            @banner_title = row[1]
            @banner_text = row[2]
            @banner_image = row[3]
        end
        erb :index
    end
end