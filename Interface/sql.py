import sqlite3
with sqlite3.connect("mybook.db") as connection:
    c = connection.cursor()
    c.execute('INSERT INTO mybook VALUES("')