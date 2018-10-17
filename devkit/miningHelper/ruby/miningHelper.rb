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
    
    def get_pow_count
        sql = "select count(units.unit) as count from units join unit_authors using(unit) where address='#{get_address}' and pow_type=1 and sequence='good';"
        @@db.execute( sql ) do |row|
            @return = row[0]
            if @return == nil
                @return = 0
            end
        end
        @return
    end

    def get_trustme_count
        sql = "select count(units.unit) as count from units join unit_authors using(unit) where address='#{get_address}' and pow_type=2 and sequence='good';"
        @@db.execute( sql ) do |row|
            @return = row[0]
            if @return == nil
                @return = 0
            end
        end
        @return
    end

    def get_coinbase_count
        sql = "select count(units.unit) as count from units join unit_authors using(unit) where address='#{get_address}' and pow_type=3 and sequence='good';"
        @@db.execute( sql ) do |row|
            @return = row[0]
            if @return == nil
                @return = 0
            end
        end
        @return
    end

    def get_ttt
        sql = "SELECT SUM(amount) AS coinbasebalance FROM outputs JOIN units USING(unit) WHERE is_spent=0 AND address='#{get_address}' AND sequence='good' AND asset IS NULL AND pow_type=3"
        @@db.execute( sql ) do |row|
            @return = row[0]
            if @return == nil
                @return = 0
            end
        end
        @return
    end

end