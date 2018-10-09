from peewee import *
user_db = SqliteDatabase('db/users.db')
post_db = SqliteDatabase('db/posts.db')
node_db = SqliteDatabase('db/nodes.db')
reply_db = SqliteDatabase('db/replys.db')
class User(Model):
    username = CharField()
    passwd = CharField()
    avatar = CharField()
    role = CharField()
    class Meta:
        database = user_db

class Post(Model):
    timestamp = CharField()
    username = CharField()
    title = CharField()
    text = CharField()
    node = CharField()
    tag = CharField()
    class Meta:
        database = post_db

class Node(Model):
    title = CharField()
    class Meta:
        database = node_db

class Reply(Model):
    text = CharField()
    post = CharField() 
    reply = CharField() 
    class Meta:
        database = reply_db

def init():
    user_db.connect()
    user_db.create_tables([User])
    user_db.close()

    post_db.connect()
    post_db.create_tables([Post])
    post_db.close()

    node_db.connect()
    node_db.create_tables([Node])
    node_db.close()

    reply_db.connect()
    reply_db.create_tables([Reply])
    reply_db.close()