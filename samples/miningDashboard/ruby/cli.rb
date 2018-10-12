#!/usr/bin/ruby
require 'rubygems'
require "./miningHelper.rb"
require './audio.rb'
require 'rufus-scheduler'

helper = Helper.new
helper.init

mn = helper.get_ttt/1000000

scheduler = Rufus::Scheduler.new
puts Time.new
scheduler.every '10s' do
    puts Time.new
    puts "Unit count:#{helper.get_unit_count}"
    puts "My address:#{helper.get_address}"
    puts "Round index:#{helper.get_round_index}"
    puts "Pow count:#{helper.get_pow_count}"
    puts "TrustMe count:#{helper.get_trustme_count}"
    puts "CoinBase count:#{helper.get_coinbase_count}"
    puts "TTT:#{helper.get_ttt/1000000} MN"
    new_mn = helper.get_ttt/1000000
    if mn < new_mn
        say(" 恭喜，挖到#{(new_mn-mn)}枚TTT")
        mn = new_mn
    end
end
scheduler.join