class LandingPageDocumentAPI < Sinatra::Base
    enable :sessions
    
    db_file = "db/landingpage.db"
    db = SQLite3::Database.new db_file

    get '/api/landingPage/document' do
        db.execute( "select * from document" ) do |row|
            @id = row[0]
            @title = row[1]
            @text = row[2]
            @image = row[3]
            @url = row[4]
        end
        {"id" => @id,"title" => @title,"text" => @text,"image" => @image,"url" => @url}.to_json
    end

    post '/api/landingPage/document' do
        # id = params["id"]
        if session[:role] != "admin"
            return {"error" => true,"message" => "not admin"}.to_json
        end
        
        title = params["title"]
        text = params["text"]
        image = params["image"]
        url = params["url"]
        db.execute( "update document set `title`='#{title}',`text`='#{text}',`img`='#{image}',`url`='#{url}'" )
        {"error" => false,"message" => "ok"}.to_json
    end
end