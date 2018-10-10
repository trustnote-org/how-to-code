开发者大赛

在H5页面中开发，使用jssdk构建基于TrustNote公链的支付类应用。

开发者开发的H5页面，是在TrustNote通用钱包中使用，相当于微信的小程序。开发者围绕支付开发各种应用，实现付费后的增值服务。

jssdk下载地址：

https://raw.githubusercontent.com/trustnote/how-to-code/master/devkit/javascript/trustnote.js

jssdk的使用方法：

1. 引用

```
<script src="/static/js/TrustNote.js"></script>
```
2. 获得用户的钱包地址：
```
var address;
window.onload = function () {
    trustnote.getAddress(function (resp) {
        address = resp.message.address;
    });
}
```
3. 调用支付接口的回调函数：

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



开发者自己构建业务逻辑，支付接口完成的是支付成功后做哪些事情。

示例：

付费阅读

https://github.com/trustnote/how-to-code/tree/master/samples/paid_reading


开发大赛需要提交：

1、github账户

2、H5页面地址

3、APP说明描述



