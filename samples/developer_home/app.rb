# require 'sinatra-base'
require 'sinatra/base'

# require controllers page
require './controllers/page/index.rb'
require './controllers/page/about.rb'
require './controllers/page/login.rb'
require './controllers/page/admin.rb'
require './controllers/page/upload.rb'

# require controllers api
require './controllers/api/user/login.rb'
require './controllers/api/landingPage/banner.rb'

class App < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new { File.join(root, "static") }
    end
    # ... use contorllers for page ...
    use IndexScreen
    use AboutScreen
    use LoginScreen
    use AdminScreen
    use UploadScreen

    # ... use contorllers for apis ...

    use LoginAPI
    use LandingPageAPI

    # 404 / 500
    not_found do
        '404'
    end

    error do
        "Sorry there was a nasty error - #{env['sinatra.error'].name}"
    end
end