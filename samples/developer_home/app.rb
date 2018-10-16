# require 'sinatra-base'
require 'sinatra/base'

# require controllers
require './controllers/index.rb'
require './controllers/about.rb'
require './controllers/login.rb'


class App < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new { File.join(root, "static") }
    end
    # ... use contorllers ...
    use IndexScreen
    use AboutScreen
    use LoginScreen

    # 404 / 500
    not_found do
        '404'
    end

    error do
        "Sorry there was a nasty error - #{env['sinatra.error'].name}"
    end
end