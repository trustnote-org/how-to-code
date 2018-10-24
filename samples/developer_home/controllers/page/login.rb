require "sqlite3"
require "pp"
class LoginScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates") }
    end
    
    get '/login' do
        @title = "login"
        erb :login
    end

    
end