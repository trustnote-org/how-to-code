require "open-uri"
require "./gpio.rb"
require "json"
uri = "http://150.109.57.242:6001/api/v1/asset/balance/YAZTIHFC7JS43HOYKGNAU7A5NULUUG5T/TTT
html_response = nil
open(uri) do |http|
  html_response = http.read
end
json = JSON.parse(html_response)
stable = json["data"]["stable"]
pending = json["data"]["pending"]
balance = stable + pending
if balance > 1000
  # turn on
  gpio.on(10)
  #transfer(balance,"xxxxxx") # transfer balance to xxxxxx(address)
  puts 60*60
else
  gpio.off(10)
end
