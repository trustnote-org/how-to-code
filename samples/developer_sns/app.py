#!/usr/bin/python
# -*- coding:utf-8 -*-
from flask import Flask, jsonify,render_template,request,redirect,url_for,session
from argparse import ArgumentParser
from peewee import *
import random
from models import *
from time import time

app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

@app.before_request
def checksession():
    if "admin" in request.path:
        if "role" in session:
            #验证是否是admin
            if session["role"]=="admin":
                pass
            else:
                return redirect(url_for("home"))
        else:
            return redirect(url_for("login"))
    # if "user" in request.path or "wallet" in request.path:
    if "user" in request.path:
        #验证是否是user
        if "username" in session:
            pass
        else:
            return redirect(url_for("login"))

@app.route('/')
def home():
    posts = [post for post in Post.select()]
    return render_template('index.html',posts=posts,session=session)
    #return jsonify("no nodes")


@app.route('/up')
def up():
    return popen("git pull").read()

@app.route('/user')
def user():
    return render_template('user/user.html',session=session)

@app.route('/signin',methods=['GET','POST'])
def login():
    if request.method == 'POST':
        username=request.form.get('username')
        passwd=request.form.get('passwd')

        users= User.select().where(User.username == username)
        if len(users)==1:
            user=users[0]
            if user.passwd == passwd:

                session["username"]=user.username
                session["userid"]=user.id
                session["role"]=user.role
                #以后可以加头像

                return "ok"
            else:
                return "err pass"
        else:
            return "err"

    if request.method == 'GET':
        num = random.randint(1,3)
        return render_template('signin.html',num=num)

@app.route('/signup',methods=['GET','POST'])
def register():
    if request.method == 'POST':
        username = request.form.get('username')
        passwd = request.form.get('passwd')
        users = User.select().where(User.username == username)
        if len(users)==0:
            User(username=username,passwd=passwd,role="user",avatar="/static/avatar/face.png").save()
            return "success"
        else:
            return "cantreg"
    if request.method == 'GET':
        num = random.randint(1,3)
        return render_template('signup.html',num=num)

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for("home"))

# new
@app.route('/new',methods=['GET','POST'])
def new_post():
    if "username" in session:
        pass
    else:
        return redirect(url_for("login"))
    if request.method == 'POST':
        username = session["username"]
        title = request.form.get('title')
        text = request.form.get('text')
        node = request.form.get('node')
        tag = request.form.get('tag')
        timestamp = round(time()*1000)
        Post(timestamp=timestamp,username=username,title=title,text=text,node=node,tag=tag).save()
        return redirect(url_for("home"))
    return render_template('new.html')
@app.route('/t/<int:id>',methods=['GET','POST'])
def get_post(id):
    posts = Post.select().where(Post.id == id)
    if (len(posts)>0):
        return render_template('post.html',post=posts[0])
    else:
        return render_template('post.html')
# member/crabpi
@app.route('/member/<string:username>')
def member(username):
    return render_template('member.html',username=username)
# settings
# settings/avatar
# 

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('-p', '--port', default=80, type=int, help='port to listen on')
    args = parser.parse_args()
    port = args.port
    app.run(debug=True,host='0.0.0.0',port=port)