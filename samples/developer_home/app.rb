# require 'sinatra-base'
require 'sinatra/base'

# require controllers page
require './controllers/page/index.rb'
require './controllers/page/login.rb'
require './controllers/page/register.rb'
require './controllers/page/admin/index.rb'
require './controllers/page/upload.rb'
require './controllers/page/baoming.rb'
require './controllers/page/user.rb'
require './controllers/page/set.rb'


# landingPages

require './controllers/page/admin/landingpage/banner.rb'
require './controllers/page/admin/landingpage/document.rb'
require './controllers/page/admin/landingpage/task.rb'
require './controllers/page/admin/landingpage/sample.rb'
require './controllers/page/admin/landingpage/tool.rb'
require './controllers/page/admin/landingpage/video.rb'
require './controllers/page/admin/landingpage/community.rb'

# require controllers api
require './controllers/api/user/login.rb'

class App < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :public_folder, Proc.new { File.join(root, "static") }
    end
    # ... use contorllers for page ...
    use IndexScreen

    use LoginScreen
    use RegisterScreen
    use AdminScreen
    use UploadScreen
    use UserScreen
    use SetScreen

    use BaomingScreen

    # admin

    use AdminDocumentScreen
    use AdminBannerScreen
    use AdminTaskScreen
    use AdminSampleScreen
    use AdminToolScreen
    use AdminVideoScreen
    use AdminCommunityScreen

    # ... use contorllers for apis ...

    use LoginAPI

    # 404 / 500
    not_found do
        '404'
    end

    error do
        "Sorry there was a nasty error - #{env['sinatra.error'].name}"
    end
end