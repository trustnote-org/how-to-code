#!/usr/bin/ruby
require "sqlite3"
class Helper
    
    def init
        db_file = "/home/#{get_user()}/.config/trustnote-pow-supernode/trustnote.sqlite"
        @@db = SQLite3::Database.new db_file
    end

    def get_user
        IO.popen("whoami") do |f|
            @user = f.gets.chomp
        end
        @user
    end

    def get_unit_count
        @@db.execute( "select count(*) from units" ) do |row|
            @unit_count = row[0]
        end
        @unit_count
    end

    def get_address
        @@db.execute( "select address from my_addresses" ) do |row|
            @address = row[0]
        end
        @address
    end

    def get_round_index
        @@db.execute( "select max(round_index) from round" ) do |row|
            @round_index = row[0]
        end
        @round_index
    end

end