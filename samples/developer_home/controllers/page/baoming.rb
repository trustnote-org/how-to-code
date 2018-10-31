class BaomingScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/baoming") }
    end

    get '/baoming' do
        erb :index
    end

    get '/baoming/all' do
        db_file = "db/baoming.db"
        db = SQLite3::Database.new db_file
        
        @projects=[]
        @tools=[]
        db.execute( "select id,project_name,project_github,team_name,team_weixin,team_email,time from project" ) do |row|
            @projects << { 
                "id" => row[0],

                "project_name" => row[1], 
                "project_github" => row[2], 
                "team_name" => row[3],
                "team_weixin" => row[4],
                "team_email" => row[5],
                "time" => row[6],
            }
        end
        erb :all
    end

    get '/baoming/new' do
        erb :post
    end

    post '/baoming/new' do
        db_file = "db/baoming.db"
        db = SQLite3::Database.new db_file

        project_name = params["project_name"]
        project_info = params["project_info"]
        project_github = params["project_github"]

        team_name = params["team_name"]
        team_info = params["team_info"]
        team_number = params["team_number"]
        team_weixin = params["team_weixin"]
        team_email = params["team_email"]
        team_mobile = params["team_mobile"]

        time = Time.now
        sql = "insert into project (id,project_name,project_info,project_github,team_name,team_info,team_number,team_weixin,team_email,team_mobile,time) values (NULL,'#{project_name}','#{project_info}','#{project_github}','#{team_name}','#{team_info}','#{team_number}','#{team_weixin}','#{team_email}','#{team_mobile}','#{time}');"
        db.execute(sql)
        redirect '/baoming/success'
    end

    get '/baoming/success' do
        erb :success
    end

    
end