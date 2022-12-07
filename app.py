import os
import sqlite3
import sys

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

@route('/login')
def login(db):
    if request.session.get("logged_in"):
        redirect('/')
    return template("login")
    #request.session['logged_in'] = True
    #db.execute('INSERT INTO users (User,Password) VALUES("TOTO","TEST")')
    #redirect('/')

@get('/register')
def register():
    if request.session.get("logged_in"):
        redirect('/')
    return template("register")
    #request.session['logged_in'] = True
    #db.execute('INSERT INTO users (User,Password) VALUES("TOTO","TEST")')
    #redirect('/')

@post('/register')
def do_register(db):
    username = request.forms.get('username')
    password = request.forms.get('password')
    print(username)
    print(password)
    try:
        db.execute('INSERT INTO users (User,Password) VALUES(?,?)',(username,password))
        redirect('/')
    except sqlite3.Error as e:
        return HTTPError(500, e)


@route('/list/users')
def index(db):
    if request.session.get("logged_in"):
        row = db.execute('SELECT * from users').fetchone()
        if row:
            return template('showitem', page=row)
        return HTTPError(404, "Page not found")


# Start app
bottle.run(app=app, host='0.0.0.0', port=8080, debug=True)
