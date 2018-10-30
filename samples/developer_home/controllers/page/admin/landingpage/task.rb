require "sqlite3"
require "pp"
class AdminTaskScreen < Sinatra::Base
    configure do
        enable :sessions
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../../../templates/admin/landingpage") }
    end

    get '/admin/landingpage/tasks' do
        unless session[:username]
            halt "Access denied, please <a href='/login'>login</a>."
        end
        @session = session

        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        @tasks=[]
        db.execute( "select id,icon,title,text,url,status from task" ) do |row|
            @tasks << { "id" => row[0],"icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4], "status" => row[5] }
        end
        @tasks.to_json

        erb :tasks
    end
end