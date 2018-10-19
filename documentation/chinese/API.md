# TrustNote 2.0 API

### 生成助记词

```
http://developers.trustnote.org/api/generate/mnemonic
```

### 生成私钥

```
http://developers.trustnote.org/api/generate/private_key/mnemonic
```

### 生成公钥

```
http://developers.trustnote.org/api/generate/public_key/private_key
```

### 生成地址

```
http://developers.trustnote.org/api/generate/address/public_key
```

### 组装交易单元

```
http://developers.trustnote.org/api/generate/unit/from_public_key/to_public_key/amount/timestramp
```

### 对交组装的交易信息进行签名

```
http://developers.trustnote.org/api/generate/unit/private_key/un_signature_unit
```

### 发送带有签名的交易单元

```
http://developers.trustnote.org/api/generate/transaction/signature_unit
```



说明：

该API仅作为方便调试时使用，不建议在正式网中使用该API，因为该API会向网络发送助记词。建议使用TrustNote提供的SDK在本地生成。



备注：

该功能尚未实现，欢迎开发者积极参与！