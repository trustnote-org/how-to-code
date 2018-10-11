#!/usr/bin/ruby

require "./miningHelper.rb"


helper = Helper.new
helper.init
puts "Unit count:#{helper.get_unit_count}"
puts "My address:#{helper.get_address}"
puts "Round index:#{helper.get_round_index}"
puts "Pow count:#{helper.get_pow_count}"
puts "TrustMe count:#{helper.get_trustme_count}"
puts "CoinBase count:#{helper.get_coinbase_count}"
puts "TTT:#{helper.get_ttt/1000000} MN"