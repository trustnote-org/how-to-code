class LandingTasksAPI < Sinatra::Base
    enable :sessions
    
    db_file = "db/landingpage.db"
    db = SQLite3::Database.new db_file

    get '/api/landingPage/tasks' do
        @tasks=[]
        db.execute( "select id,icon,title,text,url,status from task" ) do |row|
            @tasks << { "icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4], "status" => row[5] }
        end
        @tasks.to_json
    end

    post '/api/landingPage/tasks/new' do

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