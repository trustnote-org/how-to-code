class BaomingScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/baoming") }
    end

    get '/baoming' do
        erb :index
    end

    get '/baoming/all' do
        erb :all
    end

    get '/baoming/new' do
        erb :post
    end
end