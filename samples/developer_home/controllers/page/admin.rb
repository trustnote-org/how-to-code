require "sqlite3"
require "pp"

class AdminScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/admin") }
    end
    
    get '/admin' do
        
        # @title = "admin"

        # if session[:role] != "admin"
        #     redirect '/notadmin'
        # end

        erb :admin
    end

    get '/admin/landingPage/banner' do
        
        # @title = "admin"

        # if session[:role] != "admin"
        #     redirect '/notadmin'
        # end

        erb :banner
    end

    post '/save_document' do
        
        # request.body.rewind
        # data = JSON.parse request.body.read
        username = params["username"]
        passwd = params["passwd"]
        login_success = false
        
        
        
        # redirect '/login'
        "#{login_success}"
    end

    get '/notadmin' do
        "not admin"
    end
end