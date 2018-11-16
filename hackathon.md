# hackathon 

一、register

http://developers.trustnote.org/hackathon/register

二、SDK

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

