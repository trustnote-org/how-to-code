# hackathon 黑客松活动 API 及 示例说明

没有实际应用的区块链项目都是空气项目。目前很多区块链上面有很多dapp。但是那些dapp毫无意义和用处。trustnote可即时支付，对iot设备友好的公链，通过api，你可以把何物联网设备和支持场景无缝衔接在一起。

一、register 报名

猛击下面的链接，进入报名。

http://developers.trustnote.org/hackathon/register

二、钱包 api 与 sdk

我们提供了友好的精简api，您可以根据api自己构建trustnote钱包。


1）安装核心库

只需要一条命令，核心库就安装好了。
```
npm install wallet-base --save
```
2）引入核心库
```
const Client = require('wallet-base')
```

3) 生成助记词

```
// 助记词
let mnemonic = Client.mnemonic()
```

4）生成私钥

```
// 私钥
let privkey = Client.xPrivKey(mnemonic)
```

这个api还能做什么？

脑钱包。用任意词汇作为助记词，生成私钥。用户随意输入任何自负，返回一个私钥。

5) 生成钱包公钥
```
// 钱包公钥
let walletPubkey = Client.walletPubKey(privkey, 0)
```

6)生成钱包地址
```
// 地址
let address = Client.walletAddress(walletPubkey, 0, 0)
```

7）注册钱包

提交钱包公钥即可完成注册。钱包必须经过注册，才能使用。不注册就不能使用api。

post

http://cockatoo.trustnote.org:6002/api/v1/account/register

提交格式
```
{
  "pubkey": "xpub6BwQQwThGkpzP5uLJ8NMXMFLsFt1B7rqNyeNTB3VXGb95eoK1caM5JpmPAMg8vJQf7d86689qwtGeRC4KL4fVTvMtp9u5W8jo5V5GiRNMNo"
}
```

成功后，如果没有发生错误，会返回钱包地址，该钱包地址和第6步生成的钱包地址是一样的。因此可以注册时用返回的地址和生成的地址进行比对，以此判断注册成功与否。

8） 查询余额

GET方式提交

http://cockatoo.trustnote.org:6002/api/v1/asset/balance/:address/:asset

如：
```
http://cockatoo.trustnote.org:6002/api/v1/asset/balance/YAZTIHFC7JS43HOYKGNAU7A5NULUUG5T/TTT
```

返回如下信息：
```
{
  "network": "devnet",
  "errCode": 0,
  "errMsg": "success",
  "data": {
    "stable": 25,
    "pending": 80451
  }
}
```

其中，stable是稳定状态的余额，pending是未稳定状态下的余额，两项加在一起，是该钱包的实际总额。

该方法可以用来做什么？

付费点灯

应用场景：在一个共享自习室中，每个写字桌上面有一个台灯，上面有一个二维码。用户扫码支付TTT，这个时候台灯就可以亮1小时。1小时过后，需要再次支付。

如何实现？

关键源码在这里：https://github.com/trustnote/how-to-code/blob/master/samples/iot_light/task.py

这个脚本是一个任务脚本，由linux系统任务每10秒钟执行一次。如果发现有钱就对gpio输出高电平，这样继电器就会让电灯通电。电灯通电后，脚本调用转账命令，把这个灯里的钱转走，同时输出一个 1小时的秒数，告诉任务管理器，下一次执行检测余额任务是1小时之后。

这个api还能做什么？

可以制作投票程序。每个选项是一个钱包地址，通过统计钱包余额，用余额做选票的投票数。

9）构建支付

post

http://cockatoo.trustnote.org:6002/api/v1/asset/transfer

如：

```
{
  "asset": "TTT",
  "payer": "ZDKNB2DQJPQR7PKYI37A5M2MTU5SIZ2A",
  "message": "hello world",
  "outputs": [
    {
      "address": "FYQXBPQWBPXWMJGCHWJ52AK2QMEOICR5",
      "amount": 5
    }
  ]
}
```


上面的提价格式中，payer代表自己的地址，即付款方。outputs中的address是对方，即收款方。amount是你转给对方的钱。

返回如下：
```
{
    network": "devnet",
    "errCode": 0,
    "errMsg": "success",
    "data": {
        "b64_to_sign": "iQjSol75QjDLtzapgxZBWPMgxJnRj2IoOO6pt41eBW8=",
        "txid": "XQ/8hrHpYgtVZxAHSdScUaQGjyVaKwsv52q2qmqLtQE="
    }
}
```

10）签名

使用sdk的sign方法进行签名,第一个参数是上一步骤中返回结果中的b64_to_sign。第二个参数是第4步骤中产生的私钥。第三个参数不用管，保持"m/44'/0'/0'/0/0"即可。

```
let sig = Client.sign(b64_to_sign, privkey, "m/44'/0'/0'/0/0")
```

11） 发送交易

post

http://cockatoo.trustnote.org:6002/api/v1/asset/sign

参数如下：

```
{
  "txid": "BWEGp9t1yKEttWrLkshn7b3brWMy/tHMdyisLFL/3ck=",
  "sig": "li4xPfMMbiMyw7YWGuiHjklWu6IPxQOnlB9S0rjlUkAplCyP5OrlfcjOWOuRO4Ua99cgCTI23wI6rg0outpUwA=="
}
```

支付失败返回状态：

```
{
	"network": "devnet",
	"errMsg": "not enough asset: TTT from address OQXCPQ6NQVKPI46U2YFBY55EBCPAV3GF",
	"data": "null"
}
```

支付成功返回状态：

```
{
  "network": "devnet",
  "errCode": 0,
  "errMsg": "success",
  "data": {
    "version": "1.0",
    "alt": "1",
    "messages": [
      {
        "app": "text",
        "payload_location": "inline",
        "payload_hash": "gC2EKFPWD6yh7/5opSCOoBU7p0dVrfIawrvx7G+m6PA=",
        "payload": "hello"
      },
      {
        "app": "payment",
        "payload_location": "inline",
        "payload_hash": "PR1YY8CzI194rIacz5v7WXspoHeBApUNktm7fAb8KgI=",
        "payload": {
          "outputs": [
            {
              "address": "KPQ3CRPBG5FSKVEH6Y76ETGD5D2N7QZ7",
              "amount": 123
            },
            {
              "address": "ZR5Y4RNILLXNGTHIVPSSVMM32NYEFFCQ",
              "amount": 9997108
            }
          ],
          "inputs": [
            {
              "unit": "uujm67ROYdYE06+3Cwrsg/8je8YRrhLCJaBdDK0MFgU=",
              "message_index": 1,
              "output_index": 1
            }
          ]
        }
      }
    ],
    "authors": [
      {
        "address": "ZR5Y4RNILLXNGTHIVPSSVMM32NYEFFCQ",
        "authentifiers": {
          "r": "li4xPfMMbiMyw7YWGuiHjklWu6IPxQOnlB9S0rjlUkAplCyP5OrlfcjOWOuRO4Ua99cgCTI23wI6rg0outpUwA=="
        }
      }
    ],
    "parent_units": [
      "YKvqGN0BPSGU7V1OyZQ3CngT0F1h9625t1w5+PHaRZA="
    ],
    "last_ball": "42oBobq5QeGixWyPyzgGo20Yidz8rBbu3aP9PejN1OU=",
    "last_ball_unit": "TVrwV2a2ikajPkg8e40QjIjViqIhqN2cL/PArZKtpRY=",
    "witness_list_unit": "MtzrZeOHHjqVZheuLylf0DX7zhp10nBsQX5e/+cA3PQ=",
    "headers_commission": 344,
    "payload_commission": 256,
    "unit": "7GC0ZBUf72SH07YXCLTrhpebdx9umNSFhYD3RXPMl0Y=",
    "timestamp": 1541645181
  }
}
```

其中 sig 是第10步签名得出的结果。txid是第9步时返回的。

12）获得交易历史

get

http://cockatoo.trustnote.org:6002/api/v1/asset/txhistory/:address/:asset/:page/:itemsPerPage

如：

```
http://cockatoo.trustnote.org:6001/api/v1/asset/txinfo/F8ofJgi8wokp0uIetxK%2fxwg3aAJ5t7Pvln2MNLGyS8M%3d
```

返回：

```
{
	"network": "devnet",
	"errCode": 0,
	"errMsg": "success",
	"data": {
		"unit": {
			"unit": "F8ofJgi8wokp0uIetxK/xwg3aAJ5t7Pvln2MNLGyS8M=",
			"version": "1.0",
			"alt": "1",
			"witness_list_unit": "MtzrZeOHHjqVZheuLylf0DX7zhp10nBsQX5e/+cA3PQ=",
			"last_ball_unit": "FU7+kILFFfH4UK2pIctXWbO6kNliAVP3toei/HHxbiE=",
			"last_ball": "HlVm3tqKy6hWYR3ia/Qat5oNeOxTbxW2siBwhGtdmrc=",
			"headers_commission": 714,
			"payload_commission": 358,
			"main_chain_index": 153960,
			"timestamp": 1539789830,
			"parent_units": ["91IvDcfFy37zKdJ30WXbyUl6/bD2ip1Y6tmBUnK4YW8="],
			"earned_headers_commission_recipients": [{
				"address": "OHLL5L5W57IROOH4A3GISUGSP6KMFBRQ",
				"earned_headers_commission_share": 100
			}],
			"authors": [{
				"address": "5AOABXFRL5AX3MWEPWKQ6QY3MY6A5TMH",
				"authentifiers": {
					"r": "nC+l/MzXcqsYyHjurBqEUasUz3Eje8TF6XbIuKXZgWw0CsXBF8ORE+0EiHO4PdqGUijDtQ3XNCaa1OFT7I3NpA=="
				}
			}, {
				"address": "OHLL5L5W57IROOH4A3GISUGSP6KMFBRQ",
				"authentifiers": {
					"r.0.0": "nC+l/MzXcqsYyHjurBqEUasUz3Eje8TF6XbIuKXZgWw0CsXBF8ORE+0EiHO4PdqGUijDtQ3XNCaa1OFT7I3NpA=="
				},
				"definition": ["or", [
					["and", [
						["address", "5AOABXFRL5AX3MWEPWKQ6QY3MY6A5TMH"],
						["in data feed", [
							["4VYYR2YO6NV4NTF572AUBEKJLSTM4J4E"], "timestamp", ">", 1531299600000
						]]
					]],
					["and", [
						["address", "752L4B7Y7WQF3BRFEI2IGIN5RDZE54DM"],
						["in data feed", [
							["4VYYR2YO6NV4NTF572AUBEKJLSTM4J4E"], "timestamp", "=", 0
						]]
					]]
				]]
			}],
			"messages": [{
				"app": "payment",
				"payload_hash": "FOfA6SWV/0UVgefXXHMsGk0U4u7lNqo5ewVwZLhNaMc=",
				"payload_location": "inline",
				"payload": {
					"inputs": [{
						"unit": "4Cq1KWx1vmXO1L35F6cUj6yXilweVgBn9lCG6d/MLa4=",
						"message_index": 0,
						"output_index": 1
					}],
					"outputs": [{
						"address": "OHLL5L5W57IROOH4A3GISUGSP6KMFBRQ",
						"amount": 88928
					}]
				}
			}, {
				"app": "payment",
				"payload_hash": "grQJshnOKYhYUQCuS1tXEJ7X3schjU5FyGdJ8uvUUy8=",
				"payload_location": "inline",
				"payload": {
					"inputs": [{
						"unit": "eap7glIf3PDZ95doA+ngk3vdhFDUhhoQmBn+Cj5SU/A=",
						"message_index": 1,
						"output_index": 0
					}],
					"asset": "7acKn25O/OuxUHJFXFHOACvNWpSDejx/BzxcWsQ8qzY=",
					"outputs": [{
						"address": "LVP5X4PB2T757EIWJPACVLACLOOEMAVV",
						"amount": 150
					}]
				}
			}]
		},
		"ball": "ZEHEija1zDNT2Bc52pmmrEZ+Az89lkLAnEpiClUxt94=",
		"skiplist_units": ["KkXI52tTaQSiOz6buEK7i/rJEYuz6rGW7tCGfeqms0M="],
		"arrShareDefinition": [{
			"arrDefinition": ["or", [
				["and", [
					["address", "5AOABXFRL5AX3MWEPWKQ6QY3MY6A5TMH"],
					["in data feed", [
						["4VYYR2YO6NV4NTF572AUBEKJLSTM4J4E"], "timestamp", ">", 1531299600000
					]]
				]],
				["and", [
					["address", "752L4B7Y7WQF3BRFEI2IGIN5RDZE54DM"],
					["in data feed", [
						["4VYYR2YO6NV4NTF572AUBEKJLSTM4J4E"], "timestamp", "=", 0
					]]
				]]
			]],
			"assocSignersByPath": {
				"r.0.0": {
					"device_address": "0YJBUFXU6NX3YII2NZWXBE63CMCKH53BM",
					"address": "5AOABXFRL5AX3MWEPWKQ6QY3MY6A5TMH",
					"member_signing_path": "r"
				},
				"r.1.0": {
					"device_address": "0IQQISCHCS7OHLNPSZKG2W4CLJCNV3QXW",
					"address": "752L4B7Y7WQF3BRFEI2IGIN5RDZE54DM",
					"member_signing_path": "r"
				}
			}
		}]
	}
}
```

这个api可以做什么？

我们可以制作一个抽奖程序。根据参与用户（历史支付记录）作为一个序列，产生一个随即数，从这个序列里产生一个中奖者。

三、Sample 例子

1）web钱包示例 

wallet-base 核心库、vue ，基于通用钱包api构建。

https://github.com/fusionwallet/wallet

2）chrome 扩展示例

使用chrome扩展对第一个示例web钱包进行了封装。

https://github.com/fusionwallet/chrome_extensions

