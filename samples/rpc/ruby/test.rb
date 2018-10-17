require './rpc.rb'
rpc = RPC.new("http://localhost:6553")
# puts rpc.getinfo
# puts rpc.getnewaddress
# puts rpc.getalladdress
# puts "checkaddress:#{rpc.checkaddress("O2ZH72Q4TJ4ECCN3MKMFZKR4XIBYIPJW")}"
puts rpc.getbalance("XKPXK5NDUFYYCL46UKJCAMSGSCFAPMGZ")
puts rpc.getbalance("MID53HBTZ35WCYZ4FB7LORHKH43XZVVH")
# bug
# puts rpc.getmainbalance


# puts "sendtoaddress:#{rpc.sendtoaddress("MID53HBTZ35WCYZ4FB7LORHKH43XZVVH",1000)}"
# puts rpc.miningStatus
#puts rpc.getRoundInfo

# puts rpc.unitInfo
# puts rpc.badJoints
# puts rpc.unhandleJoints


