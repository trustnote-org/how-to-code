```
gem install jimson
```

```
cd trustnote-pow-supernode
nano conf.js
```

add 2 line:
```
exports.bServeAsRpc = true; 
exports.rpcPort = 8888;
```

run supernode
```
node start.js
```


run rpc


```
ruby test.rb
```


```
sudo nmap localhost -sS -p 1-65535

```

注意：以上方法不好使，因为RPC非标准RPC。

可用的方法如下：

```
ruby test.rb
```

