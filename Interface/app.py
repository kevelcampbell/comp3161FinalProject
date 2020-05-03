from flask import Flask, render_template, redirect, url_for, request, session, flash
from functools import wraps
from flask_mysqldb import MySQL

app = Flask(__name__)

# conn = MySQL.connect(host="localhost",user="root",password="root",db="mybook")
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

@app.route('/', methods=['GET', 'POST'])
def login():
  error = None
  if request.method == 'POST':
    email = request.form['email']
    password = request.form['password']
    cur = mysql.connection.cursor()
    cur.execute("SELECT user_name AND user_password FROM users WHERE user_name='"+email+"' AND user_password ='"+password+"' ")
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
  flash('you have been successfully logged out')
  return redirect(url_for('login'))

# @app.route("/checkUser")
# def checkUser():
#   username = str(request.form["user"])

if __name__ == '__main__':
  app.run(debug=True)


# *----Snippet to add a user-----*
# @app.route('/', methods=['GET', 'POST'])
# def index():
#     if request.method == "POST":
#         details = request.form
#         firstName = details['fname']
#         lastName = details['lname']
#         cur = mysql.connection.cursor()
#         cur.execute("INSERT INTO MyUsers(firstName, lastName) VALUES (%s, %s)", (firstName, lastName))
#         mysql.connection.commit()
#         cur.close()
#         return 'success'
#     return render_template('index.html')