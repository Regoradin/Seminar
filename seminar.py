import sqlite3
from bottle import route, run, debug, template

conn = sqlite3.connect('seminars.db')
conn.execute("CREATE TABLE IF NOT EXISTS seminars (id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL)")
c = conn.cursor()

@route('/teacher')
def teacher_home():
    return template('templates/teacher_home.tpl')

@route('/teacher/add', method="POST")
def add_new():
    c.execute("INSERT INTO seminars (title, description) VALUES ('test', 'this is just a test what do you want')")
    
    return "Add_new"

@route('/teacher/add_old', method = "POST")
def add_old():
    return "Add_old"

@route('/teacher/edit', method = "POST")
def edit():
    return "Edit seminar"

@route('/teacher/remove', method = "POST")
def delete():
    return "Remove Seminar"
              
@route('/teacher/what')
def what():
    c.execute("SELECT id, title, description FROM seminars")
    result = c.fetchall()

    string_result = "Results:\n"
    for row in result:
        for word in row:
            print(row)
            string_result += str(word)
            string_result += " "
    print(string_result)

    return string_result


run(debug = True)
