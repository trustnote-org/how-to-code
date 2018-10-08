from os import popen
import sqlite3
import requests

def get_key():
    # goto https://console.bce.baidu.com/ai/?_=1538041314903#/ai/speech/app/list  reg a baidu access
    API_Key = "here input your baidu app_key"
    Secret_Key = "here input your baidu secret_key"
    url = "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id={0}&client_secret={1}".format(API_Key,Secret_Key)
    r = requests.get(url)
    json = r.json()
    key = json["access_token"]
    return key

def play(txt):
    key = get_key()
    url = "http://tsn.baidu.com/text2audio?lan=zh&ctp=1&cuid=abcdxxx&tok={0}&tex={1}&vol=9&per=0&spd=5&pit=5&aue=3".format(key,txt)
    sh = "mpg123 '{0}'".format(url)
    #print (sh)
    return popen(sh).read()

def get_username():
    handle = popen("whoami")
    username = handle.read()
    return username.strip()

def get_values(sql):
    try:
        username = get_username()
        #print ("username:{0}".format(username))
        db_file = "/home/{0}/.config/trustnote-pow-supernode/trustnote.sqlite".format(username)
        #print ("db_file:{0}".format(db_file))
        conn = sqlite3.connect(db_file)
        cursor= conn.cursor()
        cursor.execute(sql)
        values = cursor.fetchall()
        return values
    except (IOError,ZeroDivisionError):
        return -1

def get_address():
    sql = "select address from my_addresses"
    values = get_values(sql)
    if (len(values)>0):
        address = values[0][0]
        return address
    else :
        return 0

def get_number(type=3):
    address = get_address()
    sql = "SELECT SUM(amount) AS coinbasebalance FROM outputs JOIN units USING(unit) WHERE is_spent=0 AND address='{0}' AND sequence='good' AND asset IS NULL AND pow_type={1}".format(address,type)
    values = get_values(sql)

    if (len(values)>0):
        amount = values[0][0]
        if (amount == None or amount == "None"):
            return 0
        else:
            return amount #float(amount/1000000)
    else :
        return 0

def get_count(type=3):
    address = get_address()
    sql = "select count(units.unit) as count from units join unit_authors using(unit) where address='{0}' and pow_type={1} and sequence='good';".format(address,type)
    values = get_values(sql)
    if (len(values)>0):
        count = values[0][0]
        return count
    else :
        return 0

# sdk api
def is_round_in(round_index):
    address = get_address()
    sql = "select address from units join unit_authors using(unit) where round_index={0} and pow_type=1 and sequence='good';".format(round_index)
    values = get_values(sql)
    print ("!!! {0}".format(values))
    if (len(values)>0):
        for item in values:
            if (address == item[0]):
                return True
    return False

def get_round_index():
    sql = "select max(round_index) from round"
    values = get_values(sql)
    if (len(values)>0):
        count = values[0][0]
        return int(count)
    else :
        return 0

# pow
def get_pow():
    return get_number(1)
# trustme
def get_trustme():
    return get_number(2)
# coinbase
def get_coinbase():
    return get_number(3)
# ttt same the coinbase
def get_ttt():
    return get_number(3)
#pow count
def get_pow_count():
    return get_count(1)
#trustme count
def get_trustme_count():
    return get_count(2)
#coinbase count
def get_coinbase_count():
return get_count(3)
