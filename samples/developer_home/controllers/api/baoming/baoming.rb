require "sqlite3"
require "pp"
class BaomingAPI < Sinatra::Base

    enable :sessions

    get '/api/baoming/all' do

        db_file = "db/baoming.db"
        db = SQLite3::Database.new db_file
        
        @projects=[]
        db.execute( "select * from project" ) do |row|
            @projects << { 
                "id" => row[0],
                "project_name" => row[1], 
                "project_info" => row[2], 
                "project_github" => row[3], 
                "team_type" => row[4], 
                "team_name" => row[5],
                "team_info" => row[6],
                "team_number" => row[7],
                "team_weixin" => row[8],
                "team_mobile" => row[9],
                "team_email" => row[10],
            }
        end
        @projects.to_json
    end

    get '/api/baoming/:id' do
        db_file = "db/baoming.db"
        db = SQLite3::Database.new db_file
        id = params["id"]
        @json = {
            "error" => true
        }.to_json
        db.execute( "select * from project where id = #{id}" ) do |row|
            @json = { 
                "error" => false,
                "id" => row[0],
                "project_name" => row[1], 
                "project_info" => row[2], 
                "project_github" => row[3], 
                "team_type" => row[4], 
                "team_name" => row[5],
                "team_info" => row[6],
                "team_number" => row[7],
                "team_weixin" => row[8],
                "team_mobile" => row[9],
                "team_email" => row[10],
            }.to_json
        end
        @json
    end

    post '/api/baoming/new' do
        db_file = "db/baoming.db"
        db = SQLite3::Database.new db_file
        # request.body.rewind
        # data = JSON.parse request.body.read

        project_name = params["project_name"]
        project_info = params["project_info"]
        project_github = params["project_github"]

        team_name = params["team_name"]
        team_info = params["team_info"]
        team_number = params["team_number"]
        team_weixin = params["team_weixin"]
        team_email = params["team_email"]
        team_mobile = params["team_mobile"]

        sql = "insert into project (id,project_name,project_info,project_github,team_name,team_info,team_number,team_weixin,team_email,team_mobile) values (NULL,'#{project_name}','#{project_info}','#{project_github}','#{team_name}','#{team_info}','#{team_number}','#{team_weixin}','#{team_email}','#{team_mobile}');"
        db.execute( sql ) 
        # # redirect '/login'
        # {
        #     "project_name" => project_name,
        #     "project_info" => project_info,
        #     "project_github" => project_github,
        #     "team_name" => team_name,
        #     "team_info" => team_info,
        #     "team_number" => team_number,
        #     "team_weixin" => team_weixin,
        #     "team_email" => team_email,
        #     "team_mobile" => team_mobile
        # }.to_json
        "ok"
    end
    
end