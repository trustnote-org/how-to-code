require "sqlite3"
require "pp"
class IndexScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../templates") }
    end

    get '/' do
        db_file = "db/landingpage.db"
        db = SQLite3::Database.new db_file

        db.execute( "select * from banner" ) do |row|
            @banner_title = row[1]
            @banner_text = row[2]
            @banner_image = row[3]
        end

        db.execute( "select id,title,text,img,url from document" ) do |row|
            @document_title = row[1]
            @document_text = row[2]
            @document_image = row[3]
            @document_url = row[4]
        end

        @tasks=[]
        db.execute( "select id,icon,title,text,url,status from task" ) do |row|
            @tasks << { "icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4], "status" => row[5] }
        end

        @samples=[]
        db.execute( "select id,icon,title,text,url from task" ) do |row|
            @samples << { "icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4] }
        end

        @tools=[]
        db.execute( "select id,icon,title,text,url from tool" ) do |row|
            @tools << { "icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4] }
        end

        @videos=[]
        db.execute( "select id,icon,title,text,url from video" ) do |row|
            @videos << { "icon" => row[1], "title" => row[2], "text" => row[3], "url" => row[4] }
        end

        @communitys=[]
        db.execute( "select id,icon,title,url from community" ) do |row|
            @communitys << { "icon" => row[1], "title" => row[2], "url" => row[3] }
        end

        erb :index
    end
end