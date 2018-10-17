#!/usr/bin/python
# -*- coding: utf-8 -*-
import requests
import json

url = "http://localhost:6553"
headers = {'content-type': 'application/json'}

def get_result(payload):
    response = requests.post(url, data=json.dumps(payload), headers=headers).json()
    return response
    # return json.dumps(response)

def getinfo():
    method="getinfo"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def getalladdress():
    payload = {
        "method": "getalladdress",
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)


def checkAddress(address):
    method="checkAddress"
    payload = {
        "method": method,
        "params": [address],
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def getbalance(address):
    method="getbalance"
    payload = {
        "method": method,
        "params": [address],
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def getmainbalance():
    method="getmainbalance"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def listtransactions():
    method="listtransactions"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def sendtoaddress(address,amount):
    payload = {
        "method": "sendtoaddress",
        "params": [address,amount],
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def miningStatus():
    method="miningStatus"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def getRoundInfo():
    method="getRoundInfo"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def unitInfo():
    method="unitInfo"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def badJoints():
    method="badJoints"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)

def unhandleJoints():
    method="unhandleJoints"
    payload = {
        "method": method,
        "params": {},
        "jsonrpc": "2.0",
        "id": 1,
    }
    return get_result(payload)