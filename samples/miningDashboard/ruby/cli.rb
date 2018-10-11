#!/usr/bin/ruby

require "./miningHelper.rb"


helper = Helper.new
helper.init
puts "unit count:#{helper.get_unit_count}"
puts "my address:#{helper.get_address}"
puts "round index:#{helper.get_round_index}"
