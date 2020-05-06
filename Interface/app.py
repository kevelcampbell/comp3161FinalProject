from flask import Flask, render_template, redirect, url_for, request, session, flash, json
from functools import wraps
from flask_mysqldb import MySQL

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

@app.route('/home')
@login_required
def home():
  return render_template('home.html')

@app.route('/profile')
@login_required
def profile():
  return render_template('profile.html')

@app.route('/friends')
@login_required
def friends():
  return render_template('friends.html')

@app.route('/groups')
@login_required
def groups():
  return render_template('groups.html')

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