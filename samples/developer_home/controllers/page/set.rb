require "sqlite3"
require "pp"
class SetScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/user") }
    end
    
    get '/user/set' do
        @title = "userset"
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        erb :set
    end

    get '/user/set/passwd' do

        @title = "userset"
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        erb :passwd
    end

    post '/user/set/passwd' do
        

        unless session[:username]
            return {:error=>true,:message=>'not login'}.to_json  
        end

        db_file = "db/users.db"
        db = SQLite3::Database.new db_file

        username = session[:username]
        oldpasswd = params["oldpasswd"]
        newpasswd = params["newpasswd"]
    
        db.execute( "select * from user where username='#{username}'" ) do |row|
            @pass_word = row[2]
        end
        if oldpasswd == @pass_word
            db.execute( "update user set `passwd`='#{newpasswd}' where username='#{username}'" )
            {:error=>false,:change=>true}.to_json
        else
            {:error=>true,:message=>"passwd error"}.to_json
        end
    end

end