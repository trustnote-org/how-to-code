require "sqlite3"
require "pp"

class AdminScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../templates/admin") }
    end

    # before do
    #     unless session['user_name']
    #       halt "Access denied, please <a href='/login'>login</a>."
    #     end
    # end
    
    get '/admin' do
        
        # @title = "admin"

        if session[:role] != "admin"
            redirect '/login'
        end

        erb :admin
    end

    get '/notadmin' do
        "not admin"
    end
end