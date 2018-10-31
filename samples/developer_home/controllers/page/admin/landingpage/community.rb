require "sqlite3"
require "pp"
class AdminCommunityScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../../templates/admin/landingpage/community") }
    end

    get '/admin/landingPage/community/all' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        @session = session

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        @items=[]
        db.execute( "select id,icon,title,url from community" ) do |row|
            @items << { "id" => row[0],"icon" => row[1], "title" => row[2],"url" => row[3] }
        end
        erb :all
    end

    get '/admin/landingPage/community/new' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        erb :new
    end

    post '/admin/landingPage/community/new' do

        # id = params["id"]
        if session[:role] != "admin"
            return {"error" => true,"message" => "not admin"}.to_json
        end
        
        title = params["title"]
        text = params["text"]
        image = params["image"]

        db.execute( "update banner set `title`='#{title}',`text`='#{text}',`img`='#{image}'" )
        "ok"
    end
end