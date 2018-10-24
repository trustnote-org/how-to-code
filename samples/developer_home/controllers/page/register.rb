require "sqlite3"
require "pp"
class RegisterScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates") }
    end
    
    get '/register' do
        @title = "register"
        erb :register
    end
end