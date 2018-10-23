require "sqlite3"
require "pp"
class LoginScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../templates") }
    end
    
    get '/login' do
        @title = "login"
        erb :login
    end

    post '/login' do
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
            end
        end
        
        # redirect '/login'
        "#{login_success}"
    end
end