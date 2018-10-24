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

        if session[:role] != "admin"
            redirect '/notadmin'
        end

        erb :admin
    end

    get '/admin/landingPage/banner' do
        
        # @title = "admin"

        if session[:role] != "admin"
            redirect '/notadmin'
        end

        erb :banner
    end

    get '/admin/landingPage/document' do
        
        # @title = "admin"

        if session[:role] != "admin"
            redirect '/notadmin'
        end

        erb :document
    end

    get '/admin/landingPage/tasks' do
        
        # @title = "admin"

        if session[:role] != "admin"
            redirect '/notadmin'
        end

        erb :tasks
    end

    get '/notadmin' do
        "not admin"
    end
end