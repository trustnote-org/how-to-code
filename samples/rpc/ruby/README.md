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


