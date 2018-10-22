# TrustNote 2.0 API

## 与支付相关的 API：

### 1. 生成助记词

GET-URL：

```
http://developers.trustnote.org/api/generate/mnemonic
```

参数：不需要

返回：

```
{
	"mnemonic":"portion embrace slice vendor much glass oyster funny emerge misery section sign"
}
```



### 2. 生成私钥

POST-URL：

```
http://developers.trustnote.org/api/generate/private_key
```

参数 json：

```
{
	"mnemonic":"portion embrace slice vendor much glass oyster funny emerge misery section sign"
}
```

返回：

```
{
	"private_key":"xxxxxx"
}
```



### 3. 生成公钥

POST-URL：

```
http://developers.trustnote.org/api/generate/public_key
```

参数 json：

```
{
	"private_key":"xxxxxx"
}
```

返回：

```
{
	"public_key":"xxxxxx"
}
```



### 4. 生成地址

POST-URL：

```
http://developers.trustnote.org/api/generate/address
```

参数 json：

```
{
	"public_key":"xxxxxx"
}
```

返回：

```
{
	"address":"xxxxxx"
}
```



### 5. 组装交易单元

POST-URL：

```
http://developers.trustnote.org/api/generate/un_signature_unit
```

参数 json：

```
{
	"from_public_key":"xxxxxx",
	"to_public_key":"xxxxxx",
	"amount":1500,
	"timestramp":1539935363
}
```

返回：

```
{
    "unit": {
        "version": "1.0",
        "alt": "1",
        "messages": [{
            "app": "payment",
            "payload_location": "inline",
            "payload_hash": "P46nXMzKXC2LDzXyMUYBDCXetrjchlcP3l0MLo4WORo=",
            "payload": {
                "outputs": [{
                        "address": "YDKTOQ7VCBQ336VGH3S5RLIWRRAUTB5O",
                        "amount": 1000
                    },
                    {
                        "address": "ZXBUYS27ZS7QPISUGH3OBWFEPPYFLNHN",
                        "amount": 232957
                    }
                ],
                "inputs": [{
                    "unit": "0qP+mIYs767MWotyHLtNmOSGSH6ISWGESC1+N1buaPs=",
                    "message_index": 0,
                    "output_index": 0
                }]
            }
        }],
        "authors": [{
            "address": "7LA5PM2WUGONMSFLYRXFE3DY7X6ORKJW",
            "authentifiers": {
                "r": "----------------------------------------------------------------------------------------"
            },
            "definition": [
                "sig",
                {
                    "pubkey": "A5YLk2BEKnOXjXINYIBWPkdYx67lHmsTYso4R+2OygDV"
                }
            ]
        }],
        "parent_units": [
            "EYmSD9jUPMLidEXFIIuI6m/Wj9te3bHE8DouYheGzqQ="
        ],
        "last_ball": "bYY1fmND7WSE6zTSw0l0rs/queoaF83/y+OY4tuMhBs=",
        "last_ball_unit": "sf6F/Rjb7K/5j/GMa3XtLu6JrPCDraeOGBEX/9+FQG8=",
        "witness_list_unit": "rg1RzwKwnfRHjBojGol3gZaC5w7kR++rOR6O61JRsrQ=",
        "unit": "4Hq8fynkNV7PR93kcq7x2vENdGdyJqm+kn4O6uu57fE=",
        "headers_commission": 391,
        "payload_commission": 197,
        "timestamp": 1527068544
    }
}
```

### 6. 提取可用于签名的文本信息

POST-URL：

```
http://developers.trustnote.org/api/generate/signature_text
```

返回：

```
{
    "version": "1.0",
    "alt": "1",
    "messages": [
        {
            "app": "payment",
            "payload_location": "inline",
            "payload_hash": "P46nXMzKXC2LDzXyMUYBDCXetrjchlcP3l0MLo4WORo="
        }
    ],
    "authors": [
        {
            "address": "7LA5PM2WUGONMSFLYRXFE3DY7X6ORKJW",
            "definition": [
                "sig",
                {
                    "pubkey": "A5YLk2BEKnOXjXINYIBWPkdYx67lHmsTYso4R+2OygDV"
                }
            ]
        }
    ],
    "parent_units": [
        "EYmSD9jUPMLidEXFIIuI6m/Wj9te3bHE8DouYheGzqQ="
    ],
    "last_ball": "bYY1fmND7WSE6zTSw0l0rs/queoaF83/y+OY4tuMhBs=",
    "last_ball_unit": "sf6F/Rjb7K/5j/GMa3XtLu6JrPCDraeOGBEX/9+FQG8=",
    "witness_list_unit": "rg1RzwKwnfRHjBojGol3gZaC5w7kR++rOR6O61JRsrQ="
}

```

### 7. 对需要签名的文本进行签名

POST-URL：

```
http://developers.trustnote.org/api/generate/signature
```

参数 json：

```
{
	"private_key":"xxxxxx",
	"un_signature_unit":{
        "version": "1.0",
        "alt": "1",
        "messages": [
            {
                "app": "payment",
                "payload_location": "inline",
                "payload_hash": "P46nXMzKXC2LDzXyMUYBDCXetrjchlcP3l0MLo4WORo="
            }
        ],
        "authors": [
            {
                "address": "7LA5PM2WUGONMSFLYRXFE3DY7X6ORKJW",
                "definition": [
                    "sig",
                    {
                        "pubkey": "A5YLk2BEKnOXjXINYIBWPkdYx67lHmsTYso4R+2OygDV"
                    }
                ]
            }
        ],
        "parent_units": [
            "EYmSD9jUPMLidEXFIIuI6m/Wj9te3bHE8DouYheGzqQ="
        ],
        "last_ball": "bYY1fmND7WSE6zTSw0l0rs/queoaF83/y+OY4tuMhBs=",
        "last_ball_unit": "sf6F/Rjb7K/5j/GMa3XtLu6JrPCDraeOGBEX/9+FQG8=",
        "witness_list_unit": "rg1RzwKwnfRHjBojGol3gZaC5w7kR++rOR6O61JRsrQ="
    }
}
```

返回：

```
{
 "r":"cMKJdsCjSCg1iP9VLq6QFDlv3S6tRhKaXcmJhGTMWtxlKDg6tYn7Q7LqUamjRz7JMbSmAZCP/K1LM1vA1p+/wQ=="
}
```

### 8. 组装带有签名的单元

用返回的json中的r值替换原始单元中的"----------------------------------------------------------------------------------------"

替换后的json如下：

```
{
    "unit": {
        "version": "1.0",
        "alt": "1",
        "messages": [{
            "app": "payment",
            "payload_location": "inline",
            "payload_hash": "P46nXMzKXC2LDzXyMUYBDCXetrjchlcP3l0MLo4WORo=",
            "payload": {
                "outputs": [{
                        "address": "YDKTOQ7VCBQ336VGH3S5RLIWRRAUTB5O",
                        "amount": 1000
                    },
                    {
                        "address": "ZXBUYS27ZS7QPISUGH3OBWFEPPYFLNHN",
                        "amount": 232957
                    }
                ],
                "inputs": [{
                    "unit": "0qP+mIYs767MWotyHLtNmOSGSH6ISWGESC1+N1buaPs=",
                    "message_index": 0,
                    "output_index": 0
                }]
            }
        }],
        "authors": [{
            "address": "7LA5PM2WUGONMSFLYRXFE3DY7X6ORKJW",
            "authentifiers": {
                "r": "cMKJdsCjSCg1iP9VLq6QFDlv3S6tRhKaXcmJhGTMWtxlKDg6tYn7Q7LqUamjRz7JMbSmAZCP/K1LM1vA1p+/wQ=="
            },
            "definition": [
                "sig",
                {
                    "pubkey": "A5YLk2BEKnOXjXINYIBWPkdYx67lHmsTYso4R+2OygDV"
                }
            ]
        }],
        "parent_units": [
            "EYmSD9jUPMLidEXFIIuI6m/Wj9te3bHE8DouYheGzqQ="
        ],
        "last_ball": "bYY1fmND7WSE6zTSw0l0rs/queoaF83/y+OY4tuMhBs=",
        "last_ball_unit": "sf6F/Rjb7K/5j/GMa3XtLu6JrPCDraeOGBEX/9+FQG8=",
        "witness_list_unit": "rg1RzwKwnfRHjBojGol3gZaC5w7kR++rOR6O61JRsrQ=",
        "unit": "4Hq8fynkNV7PR93kcq7x2vENdGdyJqm+kn4O6uu57fE=",
        "headers_commission": 391,
        "payload_commission": 197,
        "timestamp": 1527068544
    }
}
```



### 9. 发送带有签名的交易单元

POST-URL：

```
http://developers.trustnote.org/api/generate/transaction
```

参数 json：

```
{
    "unit": {
        "version": "1.0",
        "alt": "1",
        "messages": [{
            "app": "payment",
            "payload_location": "inline",
            "payload_hash": "P46nXMzKXC2LDzXyMUYBDCXetrjchlcP3l0MLo4WORo=",
            "payload": {
                "outputs": [{
                        "address": "YDKTOQ7VCBQ336VGH3S5RLIWRRAUTB5O",
                        "amount": 1000
                    },
                    {
                        "address": "ZXBUYS27ZS7QPISUGH3OBWFEPPYFLNHN",
                        "amount": 232957
                    }
                ],
                "inputs": [{
                    "unit": "0qP+mIYs767MWotyHLtNmOSGSH6ISWGESC1+N1buaPs=",
                    "message_index": 0,
                    "output_index": 0
                }]
            }
        }],
        "authors": [{
            "address": "7LA5PM2WUGONMSFLYRXFE3DY7X6ORKJW",
            "authentifiers": {
                "r": "cMKJdsCjSCg1iP9VLq6QFDlv3S6tRhKaXcmJhGTMWtxlKDg6tYn7Q7LqUamjRz7JMbSmAZCP/K1LM1vA1p+/wQ=="
            },
            "definition": [
                "sig",
                {
                    "pubkey": "A5YLk2BEKnOXjXINYIBWPkdYx67lHmsTYso4R+2OygDV"
                }
            ]
        }],
        "parent_units": [
            "EYmSD9jUPMLidEXFIIuI6m/Wj9te3bHE8DouYheGzqQ="
        ],
        "last_ball": "bYY1fmND7WSE6zTSw0l0rs/queoaF83/y+OY4tuMhBs=",
        "last_ball_unit": "sf6F/Rjb7K/5j/GMa3XtLu6JrPCDraeOGBEX/9+FQG8=",
        "witness_list_unit": "rg1RzwKwnfRHjBojGol3gZaC5w7kR++rOR6O61JRsrQ=",
        "unit": "4Hq8fynkNV7PR93kcq7x2vENdGdyJqm+kn4O6uu57fE=",
        "headers_commission": 391,
        "payload_commission": 197,
        "timestamp": 1527068544
    }
}
```

返回：

交易成功返回单元的id，如：

```
HsrXxoukIaRX86Q/Z50BfsEcop20rDqTplR7LjyDZvA=
```

交易失败，返回各种错误信息：

```
此处不一一列举了
```



# 说明

以上API可以组成最基本的钱包和交易API。

### 转账 = 生成未签名的单元信息 + 签名 + 发送签名的交易信息

该API仅作为调试时使用，不建议在正式版本中使用该API，因为该API会明文传递助记词。正式产品请使用TrustNote提供的SDK。

以上所有功能皆未实现，欢迎开发者积极参与！



其他API正在规划中。



## 与浏览器相关的API

以下目前没有实现。

### 1. 取得当前轮次

### 2. 获得某轮次的8个参与挖矿节点信息

### 3. 得到当前产生的pow

### 4. 得到当前产生的TrustMe

### 5. 得到当前产生的CoinBase

### 6. 得到已挖数量
