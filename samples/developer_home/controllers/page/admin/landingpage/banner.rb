require "sqlite3"
require "pp"
class AdminBannerScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../../templates/admin/landingpage") }
    end

    get '/admin/landingPage/banner' do
        
        # @title = "admin"

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        unless session[:username]
            halt "Access denied, please login"
        end

        db.execute( "select * from banner" ) do |row|
            @banner_id = row[0]
            @banner_title = row[1]
            @banner_text = row[2]
            @banner_image = row[3]
        end

        erb :banner
    end

    post '/admin/landingPage/banner' do

        unless session[:username]
            halt "Access denied, please login"
        end

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file
        
        id = params["id"]
        title = params["title"]
        text = params["text"]
        image = params["image"]

        db.execute( "update banner set `title`='#{title}',`text`='#{text}',`img`='#{image}'" )
        redirect '/admin/landingPage/banner'
    end

end