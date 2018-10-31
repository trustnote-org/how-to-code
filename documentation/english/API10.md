# TrustNote 2.0 API

Version 1.0

Below is the current draft of the TrustNote 2.0 API release. It is a living document, and will be updated according to feedback and suggestions from the community. Please share any suggestions and feedback in this [Reddit comment thread](https://www.reddit.com/r/trustnotedev/comments/9rfflk/trustnote_request_for_comments_on_trustnote_20/).

Note this proposal has not been implemented yet, we welcome developers join us to implement and make it better. Please take a look at [How to Contribute to TrustNote](https://github.com/TrustNoteDocs/community-committee/blob/master/CONTRIBUTING.md), and our [post](https://github.com/TrustNoteDocs/community-committee/blob/master/INCENTIVE.md) for more information about TrustNote Software Developers Incentive program.

Last modified on Oct 31, 2018

## 1. Payment related requests

### 1.1 Generating a mnemonic phrase
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/mnemonic

Parameters: N/A

Example of returned JSON object:
```
{
	"mnemonic":"portion embrace slice vendor much glass oyster funny emerge misery section sign"
}
```

### 1.2 Generating a private key
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/private_key

Parameters: 
```
{
	"mnemonic":"portion embrace slice vendor much glass oyster funny emerge misery section sign"
}
```

Example of returned JSON object:
```
{
	"private_key":"xxxxxx"
}
```

### 1.3 Generating a public key
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/public_key

Parameters: 
```
{
	"private_key":"xxxxxx"
}
```

Example of returned JSON object:
```
{
	"public_key":"xxxxxx"
}
```

### 1.4 Generating an address
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/address

Parameters: 
```
{
	"public_key":"xxxxxx"
}
```

Example of returned JSON object:
```
{
	"address":"xxxxxx"
}
```

### 1.5 Generating an unsigned transaction unit
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/unsigned_unit

Parameters: 
```
{
	"from_public_key":"xxxxxx",
	"to_public_key":"xxxxxx",
	"amount":1500,
	"timestramp":1539935363
}
```

Example of returned JSON object:
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
```

### 1.6 Generating text for signature
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/text_for_signature

Parameters: 
```
{
	TBD
}
```

Example of returned JSON object:
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

### 1.7 Generating signed text
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/signed_text

Parameters:
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

Example of returned JSON object:
```
{
 "r":"cMKJdsCjSCg1iP9VLq6QFDlv3S6tRhKaXcmJhGTMWtxlKDg6tYn7Q7LqUamjRz7JMbSmAZCP/K1LM1vA1p+/wQ=="
}
```

### 1.8 Generating a transaction unit with signature
Request type: N/A

URL: N/A
Parameters: N/A

Example of modified JSON object: (replace "----------------------------------------------------------------------------------------" in original transaction unit with the "r" value returned from http://developers.trustnote.org/api/v1/generate/signed_text
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

### 1.9 Generating a signed transaction unit
Request type: POST

URL: http://developers.trustnote.org/api/v1/generate/signed_unit

Parameters: 
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

Example of returned JSON object:
```
{
	"id": "HsrXxoukIaRX86Q/Z50BfsEcop20rDqTplR7LjyDZvA="
}
```

Possible Errors: TBD

## 2. Explorer related requests

### 2.1 Retrieving the current consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/consensus_round

Parameters: TBD

Example of returned JSON object: TBD

### 2.2 Retrieving the super nodes' information for a specified consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/supernodes/:index

Parameters: TBD

Example of returned JSON object: TBD

### 2.3 Retrieving the PoW generated by current consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/pow/now

Parameters: TBD

Example of returned JSON object: TBD

### 2.4 Retrieving the PoW generated by a specified consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/pow/:index

Parameters: TBD

Example of returned JSON object: TBD

### 2.5 Retrieving the TrustME generated by current consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/trustme/now

Parameters: TBD

Example of returned JSON object: TBD

### 2.6 Retrieving the TrustME generated by a specified consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/trustme/:index

Parameters: TBD

Example of returned JSON object: TBD

### 2.7 Retrieving the Coinbase generated by current consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/coinbase/now

Parameters: TBD

Example of returned JSON object: TBD

### 2.8 Retrieving the Coinbase generated by a specified consensus round
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/coinbase/:index

Parameters: TBD

Example of returned JSON object: TBD

### 2.9 Retrieving the total amount of TTT being mined on the network
Request type: POST

URL: http://developers.trustnote.org/api/v1/info/ttt/total_amount

Parameters: TBD

Example of returned JSON object: TBD
