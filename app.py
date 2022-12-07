import os
import sqlite3
import sys
import hashlib

import beaker.middleware
import bottle
from bottle import route, hook, request, redirect, template, HTTPError, get, post
import bottle.ext.sqlite

# CONSTANTS
keys=["MUSICRECO_DB_PATH"]
tables=["users"]
# FUNCTIONS
def check_env():
    try:
        result = [os.environ[key] for key in keys]
        print("[INFO] ENV VARS ARE SET")
    except KeyError as e:
        print("Missing env var: " + str(e))
        sys.exit(1)

def check_model():
    #Check if the model exists
    conn=sqlite3.connect(os.environ["MUSICRECO_DB_PATH"])
    cur = conn.cursor()
    for table in tables:
        res = cur.execute("SELECT name FROM sqlite_master WHERE type='table' AND name=?;",[table])
        if res.fetchone() is None:
            print("[INFO] MODEL NOT FOUND")
            conn.close()
            create_model()
            return
        print("[INFO] MODEL FOUND")

def create_model():
    conn=sqlite3.connect(os.environ["MUSICRECO_DB_PATH"])
    cur = conn.cursor()
    print("[INFO] CREATING MODEL")
    with open('model.sql', 'r') as sql_file:
        sql_script = sql_file.read()
    try:
        cur.executescript(sql_script)
        conn.commit()
    except Exception as e:
        print("[ERROR] FAILED TO CREATE MODEL")
        print(e)
        conn.close()
        sys.exit(1)
    conn.close()

def create_user():
    conn=sqlite3.connect(os.environ["MUSICRECO_DB_PATH"])
    cur = conn.cursor()
    cur.execute('INSERT INTO users (User,Password) VALUES("TOTOa","TEST")')
    cur.commit()
    pass

def hash_password(password):
    salt = os.urandom(32)
    key = hashlib.pbkdf2_hmac('sha256', password.encode('utf-8'), salt, 100000)
    storage = salt + key 
    return storage

def check_credentials():
    pass

# STARTUP
session_opts = {
    'session.type': 'file',
    'session.data_dir': './session/',
    'session.auto': True,
}
app = bottle.default_app()
plugin = bottle.ext.sqlite.Plugin(dbfile='/tmp/test.db')
app.install(plugin)
app = beaker.middleware.SessionMiddleware(app, session_opts)
check_env()
check_model()

@hook('before_request')
def setup_request():
    request.session = request.environ['beaker.session']

# ROUTES
@route('/')
def index():
    if request.session.get("logged_in"):
        return 'You are logged in'
    redirect('/login')

@get('/login')
def login():
    if request.session.get("logged_in"):
        redirect('/')
    return template("login")

@post('/login')
def do_login(db):
    username = request.forms.get('username')
    password = request.forms.get('password')
    try:
        row = db.execute("SELECT * from users where User=?",[username]).fetchone()
    except sqlite3.Error as e:
        print(e)
        return HTTPError(500, "Internal Error")
    if row:
        hash=row[2]
        salt=hash[:32]
        db_password =hash[32:]
        hashed_form_password = hashlib.pbkdf2_hmac('sha256',password.encode('utf-8'), salt, 100000)
        if db_password == hashed_form_password:
            request.session['logged_in'] = True
            redirect("/")
        else:
            return HTTPError(500, "User or password incorrect")
    else:
        return HTTPError(500, "User or password incorrect")
    

@get('/register')
def register():
    if request.session.get("logged_in"):
        redirect('/')
    return template("register")


@post('/register')
def do_register(db):
    username = request.forms.get('username')
    password = request.forms.get('password')
    hash=hash_password(password)
    try:
        db.execute('INSERT INTO users (User,Password) VALUES(?,?)',(username,hash))
        redirect('/')
    except sqlite3.Error as e:
        return HTTPError(500, e)



# Start app
bottle.run(app=app, host='0.0.0.0', port=8080, debug=True)
