from flask import Flask, render_template, redirect, url_for, request, session, flash
from functools import wraps

app = Flask(__name__)

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
    if request.form['email'] != 'admin' or request.form['password'] != 'admin':
      error = 'Please enter valid login credentials.'
    else:
      session['logged_in'] = True
      return redirect(url_for('home'))
  return render_template('index.html', error=error)

@app.route('/logout')
@login_required
def logout():
  session.pop('logged_in', None)
  flash('you have been successfully logged out')
  return redirect(url_for('login'))

if __name__ == '__main__':
  app.run(debug=True)
