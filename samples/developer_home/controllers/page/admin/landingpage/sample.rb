require "sqlite3"
require "pp"
class AdminSampleScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../../templates/admin/landingpage/sample") }
    end

    get '/admin/landingPage/sample/all' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        @session = session

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        @items=[]
        db.execute( "select id,icon,title,text,url from sample" ) do |row|
            @items << { "id" => row[0],"icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4] }
        end
        erb :all
    end

    get '/admin/landingPage/sample/edit/:id' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end

        id = params["id"]

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        db.execute( "select id,icon,title,text,url from sample where id = '#{id}'" ) do |row|
            @item = { "id" => row[0],"icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4] }
        end

        erb :text
    end

    post '/admin/landingPage/sample/edit/:id' do

        if session[:role] != "admin"
            return {"error" => true,"message" => "not admin"}.to_json
        end

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        id = params["id"]
        title = params["title"]
        text = params["text"]
        icon = params["icon"]
        url = params["url"]

        sql ="update sample set `title`='#{title}',`text`='#{text}',`icon`='#{icon}',`url`='#{url}' where id = '#{id}'"
        db.execute( sql )
        redirect '/admin/landingPage/sample/all'
    end

    get '/admin/landingPage/sample/new' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        erb :new
    end

    post '/admin/landingPage/sample/new' do

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