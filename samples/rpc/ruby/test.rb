require './rpc.rb'
rpc = RPC.new("http://localhost:8888")
puts rpc.getinfo
# puts rpc.getnewaddress
puts rpc.getalladdress
# puts rpc.checkaddress("O2ZH72Q4TJ4ECCN3MKMFZKR4XIBYIPJW")
puts rpc.getBalance("O2ZH72Q4TJ4ECCN3MKMFZKR4XIBYIPJW")