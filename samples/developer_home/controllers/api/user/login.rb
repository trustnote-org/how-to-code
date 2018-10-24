require "sqlite3"
require "pp"
class LoginAPI < Sinatra::Base

    enable :sessions

    post '/api/login' do
        db_file = "db/users.db"
        db = SQLite3::Database.new db_file
        # request.body.rewind
        # data = JSON.parse request.body.read
        username = params["username"]
        passwd = params["passwd"]
        login_success = false
        
        db.execute( "select * from user where username='#{username}'" ) do |row|
            pass_word = row[2]
            if passwd== pass_word
                login_success = true
                session[:username] = username
                session[:role] = row[3]
            end
        end
        # redirect '/login'
        "#{login_success}"
    end
    
end
