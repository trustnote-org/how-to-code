# TrustNote 2.0 RPC-SDK for Ruby

### TrustNote 2.0 RPC SDK for Ruby

### how to use

超级节点配置后，会开放RPC服务（非标准，不能使用标准RPC客户端通过call方法调用），需要使用TrustNote开源社区提供的SDK进行调用。

1. 配置超级节点

进入超级节点目录，打开conf.js

```
cd trustnote-pow-supernode
nano conf.js
```
找到 exports.bServeAsRpc = false 替换 false 为 true

```
exports.bServeAsRpc = true; 
```

在 exports.bServeAsRpc = true; 下面再添一行代码设置RPC端口
```
exports.rpcPort = 8888;
```

2. 启动超级节点

run supernode
```
node start.js
```

3. 编写测试文件 test.rb

```
require './rpc.rb'
rpc = RPC.new("http://localhost:8888")
puts rpc.getinfo
# puts rpc.getnewaddress
puts rpc.getalladdress
# puts rpc.checkaddress("O2ZH72Q4TJ4ECCN3MKMFZKR4XIBYIPJW")
puts rpc.getBalance("O2ZH72Q4TJ4ECCN3MKMFZKR4XIBYIPJW")
```

4. 运行测试文件
```
ruby test.rb
```

### 注意
> 目前 超级节点的RPC存在bug，请开发者不要调用RPC的getnewaddress接口，因为该接口会让超级节点新增一个地址，而超级节点在设计时定为单地址，因此新增的地址会导致超级节点崩溃无法启动，而且RPC没有删除地址的接口！

### sample

https://github.com/trustnote/how-to-code/tree/master/samples/rpc/ruby