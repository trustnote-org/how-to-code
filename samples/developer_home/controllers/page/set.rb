require "sqlite3"
require "pp"
class SetScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates") }
    end
    
    get '/set' do
        @title = "login"
        erb :login
    end

    get '/set' do
        session.clear
        redirect '/'
    end
end