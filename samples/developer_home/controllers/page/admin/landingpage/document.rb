require "sqlite3"
require "pp"
class AdminDocumentScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../../templates/admin/landingpage") }
    end

    get '/admin/landingPage/document' do
        
        # @title = "admin"

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        unless session[:username]
            halt "Access denied, please login"
        end

        db.execute( "select * from document" ) do |row|
            @id = row[0]
            @title = row[1]
            @text = row[2]
            @image = row[3]
            @url = row[4]
        end

        erb :document
    end

    post '/admin/landingPage/document' do

        unless session[:username]
            halt "Access denied, please login"
        end

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file
        
        title = params["title"]
        text = params["text"]
        image = params["image"]
        url = params["url"]
        
        db.execute( "update document set `title`='#{title}',`text`='#{text}',`img`='#{image}',`url`='#{url}'" )

        redirect '/admin/landingPage/document'
    end

end