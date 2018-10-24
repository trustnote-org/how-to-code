class LandingPageAPI < Sinatra::Base
    enable :sessions
    
    db_file = "db/landingpage.db"
    db = SQLite3::Database.new db_file

    get '/api/landingPage/banner' do
        db.execute( "select * from banner" ) do |row|
            @banner_id = row[0]
            @banner_title = row[1]
            @banner_text = row[2]
            @banner_image = row[3]
        end
        {"id" => @banner_id,"title" => @banner_title,"text" => @banner_text,"image" => @banner_image}.to_json
    end

    post '/api/landingPage/banner' do

        # id = params["id"]
        title = params["title"]
        text = params["text"]
        image = params["image"]

        db.execute( "update banner set `title`='#{title}',`text`='#{text}',`img`='#{image}'" )
        "ok"
    end

    
end