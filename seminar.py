import sqlite3
from bottle import route, run, debug, template, request

conn = sqlite3.connect('seminars.db')
conn.execute("CREATE TABLE IF NOT EXISTS seminars (id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL)")
c = conn.cursor()

@route('/teacher')
def teacher_home():
    return template('templates/teacher_home.tpl')

@route('/teacher/add', method="POST")
def add_page():
    if request.forms.get('save'):
        title = request.forms.get('title')
        description = request.forms.get('description')
    
        c.execute("INSERT INTO seminars (title, description) VALUES (?, ?)",(title, description))
        conn.commit()
        
        return "Added new"

    else:
        return template('templates/add_page.tpl')

@route('/teacher/add_old', method = "POST")
def add_old():
    return "Add_old"

@route('/teacher/edit', method = "POST")
def edit():
    if request.forms.get('save'):
        return "Edited seminar"
    else:
        c.execute("SELECT title FROM seminars")
        result = c.fetchall()
        print(result)

        buttons = '<form action="edit" method="POST">'
        buttons += '<input type="hidden" name="save" value="save" />'
        for seminar in result:
            buttons += '<input type="submit" name="' + seminar[0] + '" value="' + seminar[0] + '">\n'
        buttons += '</form'
        
        return buttons
        
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
            string_result += str(word)
            string_result += " "

#    return string_result
    return template('make_table', rows = result)

run(debug = True)
