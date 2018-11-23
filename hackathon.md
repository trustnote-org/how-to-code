# hackathon 黑客松活动 API 及 示例说明

没有实际应用的区块链项目都是空气项目。目前很多区块链上面有很多dapp。但是那些dapp毫无意义和用处。trustnote可即时支付，对iot设备友好的公链，通过api，你可以把何物联网设备和支持场景无缝衔接在一起。

一、register 报名

猛击下面的链接，进入报名。

http://developers.trustnote.org/hackathon/register

二、钱包 api 与 sdk

我们提供了友好的精简api，您可以根据api自己构建trustnote钱包。



```
npm install wallet-base --save
```

```
const Client = require('wallet-base')

// 助记词
let mnemonic = Client.mnemonic()

// 私钥
let privkey = Client.xPrivKey(mnemonic)

// 钱包公钥
let walletPubkey = Client.walletPubKey(privkey, 0)

// 地址
let address = Client.walletAddress(walletPubkey, 0, 0)
```





4. get balance 查询余额

GET方式提交
```
http://150.109.57.242:6001/api/v1/asset/balance/:address/:asset
```
返回如下信息
```
$.getJSON("/api/v1/asset/balance/YAZTIHFC7JS43HOYKGNAU7A5NULUUG5T/TTT",function(josn){
 console.log(json.data.stable);
})
```

三、通用钱包小程序jssdk

jssdk 是通用钱包内嵌的H5页面调用的简易sdk。可以方便让H5页面纯前端实现支付功能。

下面是方法：

https://github.com/trustnote/how-to-code/blob/master/devkit/payment/trustnote.js

1. require TrustNote.js 引入jssdk

```
<script src="/static/js/TrustNote.js"></script>
```

2. retrieve the Wallet Address 获得当前的钱包地址

```
var address;
window.onload = function () {
    trustnote.getAddress(function (resp) {
        address = resp.message.address;
    });
}

```

如果你的小程序有后台，你可以通过获得钱包地址的方式来判断该钱包是不是老用户。在去中心化的区块链中，钱包地址相当于传统app的用户名。

3. transfer 转账

```
function pay() {
        var _to_address = "OKLGMIWBCFITVWKZF3JASA23OMZLICSH";// Service Provider's wallet address.
        var _amount = 10*1000000;   // 1 MN = 1,000,000 Notes; 10 MN = 10 * 1,000,000
        var _message = "some text" // Texts defined here will be stored on TrustNote network along with the transaction.
        var data = {
            payer: address,// This is the wallet address obtained using the trustnote.getAddress function as above.
            outputs: [{
                address: _to_address,
                amount: _amount
            }],
            message: _message
        }
        
        trustnote.callPay(data, function (resp) {
            if(resp.hasOwnProperty("error")){
              if(resp.error){
                //Callback function after payment failure
              }else{
                //Callback function after successful payment
              }
            }else{
              //Callback function after successful payment
            }
        })
    }

```

return jsno 转账后会返回如下信息：

```
{
  eventName: "payment",
  message: {
    unit: "MulUMgOU4e2ApF0Egq8R4vPt0alrz98y2JCk+gSQYiM="
  },
  error: null
}

```


三、Sample 例子

1）web钱包示例 

wallet-base 核心库、vue ，基于通用钱包api构建。

https://github.com/fusionwallet/wallet

2）chrome 扩展示例

使用chrome扩展对第一个示例web钱包进行了封装。

https://github.com/fusionwallet/chrome_extensions

3）通用钱包小程序示例

使用 trustnote jssdk 在H5上面构建付费阅读的一个小示例。

https://github.com/trustnote/how-to-code/tree/master/samples/paid_reading

