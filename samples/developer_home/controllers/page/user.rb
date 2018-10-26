require "sqlite3"
require "pp"
class UserScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/user") }
    end

    get '/user' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        @session = session
        erb :index
    end
end