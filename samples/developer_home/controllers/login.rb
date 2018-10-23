class LoginScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../templates") }
    end
    
    get '/login' do
        @title = "login"
        erb :login
    end

    post '/login' do
        # request.body.rewind
        # data = JSON.parse request.body.read
        username = params["username"]
        passwd = params["passwd"]
        "Hello #{params}!"
    end
end