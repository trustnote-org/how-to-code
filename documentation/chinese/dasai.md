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



# 这里是重点 需要完善我们的通用钱包与SDK

### 开发者大赛，jssdk功能需求

理念是，会用jquery就能开发TrustNote区块链应用。因此能托管的服务我们尽力托管，尽量不要让开发者自己部署后端代码。

1. H5页面是否在TrustNote通用钱包环境中

   因为开发者构建的是H5页面。因此需要判断，该H5页面是否是在TrustNote通用钱包中打开的。如果不是，则开发者可以提示用户需要下载通用钱包。

2. 登陆授权

   所谓登陆授权，就是获取用户的钱包地址，把用户的钱包地址当作用户的唯一标识。

   1）初次打开页面，弹出一个授权提示框，提示用户该页面需要获得你的钱包地址。用户手动点击同意后，可进入H5应用。

   2）记忆授权，授权页面里有个勾选：“不再提示”，勾选后，第二次进入时不再弹出授权提示框

   注意：jssdk获得用户地址的接口，也需要作出相应的更改。

3. 发送即时交易

   需要改进的是，增加一个过程：要代调出一个支付界面（需要判断余额是否可以支付），让用户手动确认。（目前是自动扣费）

   开发者在成功支付后的回调函数中，写自己的业务逻辑即可。

   未来可以发送定时交易，需要通用钱包作托管。

4. 是否发生过交易

   判断用户钱包，是否向目标钱包地址支付过。如果查询到交易过，则返回所有和该目标地址相关的交易时间。

5. 其他需求，随时探讨
