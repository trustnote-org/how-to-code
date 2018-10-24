class UploadScreen < Sinatra::Base
    configure do
        set :root, File.dirname(__FILE__)
        set :views, Proc.new { File.join(root, "../../templates/user") }
    end

    get '/user/upload' do
        @upload = "upload"
        erb :upload
    end

    post '/user/upload' do
        if params[:file] &&(tmpfile = params[:file][:tempfile]) && (name = params[:file][:filename])
            tempfile = params[:file][:tempfile]
            filename = params[:file][:filename] 
            target = "static/uploads/#{filename}"
            File.open(target, 'wb') do |f|
                f.write tempfile.read
            end
            redirect "/uploads/#{filename}"
        else
           @error = "not file"
        end
    end
end