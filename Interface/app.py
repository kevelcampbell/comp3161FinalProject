from flask import Flask, render_template, redirect, url_for, request, session, flash, json
from functools import wraps
from flask_mysqldb import MySQL
from datetime import datetime

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'mybook'

mysql = MySQL(app)
app.secret_key = "secret"

def login_required(f):
  @wraps(f)
  def wrap(*args, **kwargs):
    if 'logged_in' in session:
      return f(*args, **kwargs)
    else:
      flash('Please login to access this feature.')
      return redirect(url_for('login'))
  return wrap

@app.route('/home', methods=['GET', 'POST'])
@login_required
def home():
  uid = session['uid']
  postDate = str(datetime.now())
  cur = mysql.connection.cursor()
  cur.execute("SELECT posts.*, users.user_fname, users.user_lname FROM posts INNER JOIN users ON posts.user_id=users.user_id INNER JOIN friends ON users.user_id=friends.friend_id WHERE friends.user_id='"+uid+"' OR users.user_id='"+uid+"' ORDER BY post_datetime DESC")
  posts = cur.fetchall()
  cur.execute("SELECT user_fname, user_lname FROM users WHERE user_id='"+uid+"'")
  name = cur.fetchone()
  cur.close()
  if 'search' in request.form:
    findUser = request.form['search']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM posts WHERE user_id='"+findUser+"' ORDER BY post_datetime DESC")
    posts = cur.fetchall()
    cur.execute("SELECT user_fname, user_lname FROM users WHERE user_id='"+findUser+"'")
    name = cur.fetchone()
    cur.close()
    return render_template('profile.html', posts=posts, name=name, uid=uid)
  if 'newPost' in request.form:
    newPost = request.form['post']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO posts (user_id, post_text, post_datetime) VALUES ('"+uid+"', '"+newPost+"', '"+postDate+"')")
    mysql.connection.commit()
    cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
    posts = cur.fetchall()
    postResult = 'your post has been uploaded.'
    return render_template('profile.html', posts=posts, name=name, postResult=postResult)
  if 'photoUpload' in request.form:
    photo = request.form['photo']
    newPost = request.form['photoPost']
    cur = mysql.connection.cursor()
    cur.execute("INSERT INTO photos (user_id, photo_name, photo_image, photo_datetime) VALUES ('"+uid+"', '"+newPost+"', '"+photo+"', '"+postDate+"')")
    mysql.connection.commit()
    cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
    posts = cur.fetchall()
    postResult = 'your post has been uploaded.'
    return render_template('profile.html', posts=posts, name=name, postResult=postResult)
  return render_template('home.html', posts=posts, name=name)

@app.route('/profile', methods=['GET', 'POST'])
@login_required
def profile():
  postResult = None
  uid = session['uid']
  cur = mysql.connection.cursor()
  cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
  posts = cur.fetchall()
  cur.execute("SELECT user_fname, user_lname FROM users WHERE user_id='"+uid+"'")
  name = cur.fetchone()
  cur.close()
  if request.method == 'POST':
    postDate = str(datetime.now())
    if 'search' in request.form:
      findUser = request.form['search']
      cur = mysql.connection.cursor()
      cur.execute("SELECT * FROM posts WHERE user_id='"+findUser+"' ORDER BY post_datetime DESC")
      posts = cur.fetchall()
      cur.execute("SELECT user_fname, user_lname, user_id FROM users WHERE user_id='"+findUser+"'")
      name = cur.fetchone()
      cur.close()
      return render_template('profile.html', posts=posts, name=name, uid=uid)
    if 'friendType' in request.form:
      friendType = request.form['friendType']
      friendID = request.form['friendID']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO friends (user_id, friend_id, friend_type) VALUES ('"+uid+"', '"+friendID+"', '"+friendType+"')")
      mysql.connection.commit()
      cur.close()
      postResult = 'You just made a new friend!'
      return render_template('profile.html', posts=posts, name=name, postResult=postResult, uid=uid)
    if 'newPost' in request.form:
      newPost = request.form['post']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO posts (user_id, post_text, post_datetime) VALUES ('"+uid+"', '"+newPost+"', '"+postDate+"')")
      mysql.connection.commit()
      cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
      posts = cur.fetchall()
      postResult = 'your post has been uploaded.'
      return render_template('profile.html', posts=posts, name=name, postResult=postResult)
    if 'photoUpload' in request.form:
      photo = request.form['photo']
      newPost = request.form['photoPost']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO photos (user_id, photo_name, photo_image, photo_datetime) VALUES ('"+uid+"', '"+newPost+"', '"+photo+"', '"+postDate+"')")
      mysql.connection.commit()
      cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
      posts = cur.fetchall()
      postResult = 'your post has been uploaded.'
      return render_template('profile.html', posts=posts, name=name, postResult=postResult)
  return render_template('profile.html', posts=posts, name=name)

@app.route('/group', methods=['GET', 'POST'])
@login_required
def groups():
  postResult = None
  uid = session['uid']
  cur = mysql.connection.cursor()
  cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
  posts = cur.fetchall()
  cur.execute("SELECT user_fname, user_lname FROM users WHERE user_id='"+uid+"'")
  name = cur.fetchone()
  cur.close()
  if request.method == 'POST':
    postDate = str(datetime.now())
    if 'search' in request.form:
      findUser = request.form['search']
      cur = mysql.connection.cursor()
      cur.execute("SELECT * FROM posts WHERE user_id='"+findUser+"' ORDER BY post_datetime DESC")
      posts = cur.fetchall()
      cur.execute("SELECT user_fname, user_lname, user_id FROM users WHERE user_id='"+findUser+"'")
      name = cur.fetchone()
      cur.close()
      return render_template('profile.html', posts=posts, name=name, uid=uid)
    if 'friendType' in request.form:
      friendType = request.form['friendType']
      friendID = request.form['friendID']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO friends (user_id, friend_id, friend_type) VALUES ('"+uid+"', '"+friendID+"', '"+friendType+"')")
      mysql.connection.commit()
      cur.close()
      postResult = 'You just made a new friend!'
      return render_template('profile.html', posts=posts, name=name, postResult=postResult, uid=uid)
    if 'newPost' in request.form:
      newPost = request.form['post']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO posts (user_id, post_text, post_datetime) VALUES ('"+uid+"', '"+newPost+"', '"+postDate+"')")
      mysql.connection.commit()
      cur.execute("SELECT * FROM posts WHERE user_id='"+uid+"' ORDER BY post_datetime DESC")
      posts = cur.fetchall()
      postResult = 'your post has been uploaded.'
      return render_template('profile.html', posts=posts, name=name, postResult=postResult)
  return render_template('profile.html', posts=posts, name=name)

@app.route('/friends', methods=['GET', 'POST'])
@login_required
def friends():
  uid = session['uid']
  cur = mysql.connection.cursor()
  cur.execute("SELECT friends.friend_id, friends.friend_type, users.user_fname, users.user_lname FROM friends INNER JOIN users ON friends.friend_id=users.user_id WHERE friends.user_id='"+uid+"'")
  friends = cur.fetchall()
  cur.close()
  if 'search' in request.form:
    findUser = request.form['search']
    cur = mysql.connection.cursor()
    cur.execute("SELECT friends.friend_id, friends.friend_type, users.user_fname, users.user_lname FROM friends INNER JOIN users ON friends.friend_id=users.user_id WHERE friends.user_id='"+findUser+"'")
    friends = cur.fetchall()
    cur.close()
    return render_template('friends.html', friends=friends, uid=uid)
  return render_template('friends.html', friends=friends)

@app.route('/view_groups')
@login_required
def view_groups():
  uid = session['uid']
  cur = mysql.connection.cursor()
  cur.execute("SELECT groups.group_id, groups.user_id, groups.group_name, groups.group_description FROM groups INNER JOIN users ON groups.user_id=users.user_id WHERE groups.user_id='"+uid+"'")
  groups = cur.fetchall()
  cur.close()
  if 'search' in request.form:
    findUser = request.form['search']
    cur = mysql.connection.cursor()
    cur.execute("SELECT groups.group_id, groups.user_id, groups.group_name, groups.group_description FROM groups INNER JOIN users ON groups.user_id=users.user_id WHERE groups.user_id='"+findUser+"'")
    groups = cur.fetchall()
    cur.close()
    return render_template('viewGroups.html', groups=groups, uid=uid)
  if 'groupID' in request.form:
      groupID = request.form['groupID']
      uid = request.form['uid']
      gname = request.form['gname']
      gdes = request.form['gdes']
      cur = mysql.connection.cursor()
      cur.execute("INSERT INTO groups (group_id, user_id, group_name, group_description) VALUES ('"+groupID+"', '"+uid+"', '"+gname+"', '"+gdes+"')")
      mysql.connection.commit()
      cur.close()
      postResult = 'You just made a new group!'
      return render_template('profile.html', groups=groups, postResult=postResult, uid=uid)
  return render_template('viewGroups.html', groups=groups, uid=uid)

@app.route('/', methods=['GET', 'POST'])
def login():
  error = None
  if request.method == 'POST':
    uid = request.form['UserID']
    password = request.form['password']
    cur = mysql.connection.cursor()
    cur.execute("SELECT user_id AND user_password FROM users WHERE user_id='"+uid+"' AND user_password ='"+password+"' ")
    user = cur.fetchone()
    cur.close()
    if user:
      session['logged_in'] = True
      session['uid'] = uid
      return redirect(url_for('home'))
    else:
      error = 'Please enter valid login credentials.'
  return render_template('index.html', error=error)

@app.route('/logout')
@login_required
def logout():
  session.pop('logged_in', None)
  flash(u'you have been successfully logged out', 'container bottom alert alert-warning')
  return redirect(url_for('login'))

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == "POST":
        firstName = request.form['user_fname']
        lastName = request.form['user_lname']
        dob = request.form['user_dob']
        password = request.form['user_password']
        email = request.form['user_email']
        telephone = request.form['user_tel']
        address = request.form['user_addr']
        cur = mysql.connection.cursor()
        # cur.execute("INSERT INTO users (user_fname, user_lname, user_dob, user_password, user_addr) VALUES WHERE user_id='"+uid+"' AND user_password ='"+password+"' ")
        cur.execute("INSERT INTO users (user_fname, user_lname, user_dob, user_password, user_addr) VALUES (%s, %s, %s, %s, %s)", (firstName, lastName, dob, password, address))
        mysql.connection.commit()
        cur.execute("SELECT MAX(user_id) FROM users")
        newID = str(cur.fetchone()[0])
        cur.execute("INSERT INTO emails (user_id, user_email) VALUES (%s, %s)", (newID, email))
        cur.execute("INSERT INTO telephones (user_id, user_tel) VALUES (%s, %s)", (newID, telephone))
        mysql.connection.commit()
        cur.close()
        flash(u'Sign up successful, your user ID is ' + newID, 'container bottom alert alert-success')
        return redirect(url_for('login'))
    else:
      response = 'Please review sign up details'
      return render_template('signup.html', response=response)
    return render_template('signup.html')

if __name__ == '__main__':
  app.run(debug=True)