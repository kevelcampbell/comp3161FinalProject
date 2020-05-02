from flask_ldap3_login.forms import LDAPLoginForm

@app.route('/')
def home():
    # Redirect users who are not logged in.
    if not current_user or current_user.is_anonymous:
        return redirect(url_for('login'))
    return render_template('home.html')
    
@app.route('/login', methods=['GET', 'POST'])
def login():
    template = 'index.html'
    form = LDAPLoginForm()
    if form.validate_on_submit():
        login_user(form.user)  # Tell flask-login to log them in.
        return redirect('/')  # Send them home
    return render_template(template, form=form)

if __name__ == '__main__':
    app.run(debug=True)