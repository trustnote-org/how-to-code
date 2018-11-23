# hackathon 黑客松活动

没有实际应用的区块链项目都是空气项目。目前很多区块链上面有很多dapp。但是那些dapp毫无意义和用处。trustnote可即时支付，对iot设备友好的公链，通过api，你可以把何物联网设备和支持场景无缝衔接在一起。

一、register 报名

猛击下面的链接，进入报名。

http://developers.trustnote.org/hackathon/register

二、api 与 sdk

我们提供了友好的精简api，您可以根据api自己构建trustnote钱包。

```
npm install wallet-base --save
```

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






https://github.com/trustnote/how-to-code/blob/master/devkit/payment/trustnote.js

1. require TrustNote.js

```
<script src="/static/js/TrustNote.js"></script>
```

2. retrieve the Wallet Address

```
var address;
window.onload = function () {
    trustnote.getAddress(function (resp) {
        address = resp.message.address;
    });
}

```

3. transfer the Money

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

return jsno

```
{
  eventName: "payment",
  message: {
    unit: "MulUMgOU4e2ApF0Egq8R4vPt0alrz98y2JCk+gSQYiM="
  },
  error: null
}

```

4. get balance

GET
```
http://150.109.57.242:6001/api/v1/asset/balance/:address/:asset
```

```
$.getJSON("/api/v1/asset/balance/YAZTIHFC7JS43HOYKGNAU7A5NULUUG5T/TTT",function(josn){
 console.log(json.data.stable);
})
```


三、Sample

https://github.com/trustnote/how-to-code/tree/master/samples/paid_reading

