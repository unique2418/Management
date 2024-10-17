


from flask import Flask, render_template, request, redirect, session, flash, url_for
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt

app = Flask(__name__)
app.secret_key = 'your_secret_key'

# MySQL Config
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '1314'
app.config['MYSQL_DB'] = 'payroll'

mysql = MySQL(app)
bcrypt = Bcrypt(app)

# Route for the home page
@app.route('/')
def home():
    return render_template('home.html')

# Registration Route
@app.route('/register', methods=['GET', 'POST'])
def register():

    if request.method == 'POST':
        employee_id = request.form['employee_id']
        fullname = request.form['fullname']
        email = request.form['email']
        username = request.form['username']
        password = request.form['password']
        confirm_password = request.form['confirm_password']
        role = request.form['role']  # 'employee' or 'manager'

        # Password Validation
        if password != confirm_password:
            flash('Passwords do not match', 'danger')
            return redirect(url_for('register'))

        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        # Insert user data into the database
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO employee (employee_id, fullname, email, username, password, role) "
                    "VALUES (%s, %s, %s, %s, %s, %s)",
                    (employee_id, fullname, email, username, hashed_password, role))
        mysql.connection.commit()
        cur.close()

        flash('Registration successful! You can now login.', 'success')
        return redirect(url_for('login'))

    return render_template('register.html')

# Login Route
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Fetch user from the database
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM employee WHERE username = %s", [username])
        user = cur.fetchone()
        cur.close()

        if user and bcrypt.check_password_hash(user[5], password):  # Verify password
            session['username'] = username
            session['role'] = user[6]  # Set role in session (either 'manager' or 'employee')
            flash(f"Logged in as {session['username']} with role {session['role']}", 'success')

            # Redirect based on role
            if user[6] == 'manager':
                return redirect(url_for('manager_dashboard'))
            else:
                return redirect(url_for('employee_dashboard'))
        else:
            flash('Invalid credentials, please try again.', 'danger')

    return render_template('login.html')

# Route for employee dashboard
# @app.route('/employee_dashboard')
# def employee_dashboard():
#     if 'username' not in session or session['role'] != 'employee':
#         flash('Access denied. Only employees can view this page.', 'warning')
#         return redirect(url_for('login'))
#
#     # Fetch employee details from the database
#     cur = mysql.connection.cursor()
#     cur.execute("SELECT employee_id, fullname, email FROM employee WHERE username = %s", [session['username']])
#     user = cur.fetchone()
#     cur.close()
#
#     return render_template('employee_dashboard.html', user=user)
#

# Route for employee dashboard
@app.route('/employee_dashboard')
def employee_dashboard():
    if 'username' not in session or session['role'] != 'employee':
        flash('Access denied. Only employees can view this page.', 'warning')
        return redirect(url_for('login'))

    # Fetch employee details including working days from the database
    cur = mysql.connection.cursor()
    cur.execute("SELECT employee_id, fullname, email, working_days FROM employee WHERE username = %s", [session['username']])
    user = cur.fetchone()
    cur.close()

    return render_template('employee_dashboard.html', user=user)


# Route for manager dashboard
@app.route('/manager_dashboard')
def manager_dashboard():
    if 'username' not in session or session['role'] != 'manager':
        flash('Access denied. Only managers can view this page.', 'warning')
        return redirect(url_for('login'))

    # Fetch manager details from the database
    cur = mysql.connection.cursor()
    cur.execute("SELECT employee_id, fullname, email, working_days FROM employee WHERE username = %s",
                [session['username']])
    user = cur.fetchone()

    # Fetch all employees to display their working days
    cur.execute("SELECT employee_id, fullname, working_days,role FROM employee")
    employees = cur.fetchall()
    cur.close()

    return render_template('manager_dashboard.html', user=user, employees=employees)

# Route to update working days
@app.route('/update_working_days', methods=['POST'])
def update_working_days():
    if 'username' not in session or session['role'] != 'manager':
        flash('Access denied. Only managers can perform this action.', 'warning')
        return redirect(url_for('login'))

    employee_id = request.form['employee_id']
    working_days = request.form['working_days']

    # Update working days in the database
    cur = mysql.connection.cursor()
    cur.execute("UPDATE employee SET working_days = %s WHERE employee_id = %s", (working_days, employee_id))
    mysql.connection.commit()
    cur.close()

    flash('Working days updated successfully!', 'success')
    return redirect(url_for('manager_dashboard'))




# Route for logging out
@app.route('/logout')
def logout():
    session.clear()
    flash('You have been logged out successfully.', 'success')
    return redirect(url_for('home'))

@app.route('/about_us')
def about_us():
    return render_template('about_us.html')

if __name__ == '__main__':
    app.run(debug=True)
