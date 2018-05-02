import sqlite3
from bottle import route, run, debug, template, request


conn = sqlite3.connect('seminars.db')
c = conn.cursor()

#seminars table creation
conn.execute('''CREATE TABLE IF NOT EXISTS seminars (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL)''')
#semesters table creation
conn.execute('''CREATE TABLE IF NOT EXISTS semesters (
             id INTEGER PRIMARY KEY,
             name TEXT NOT NULL,
             is_current INTEGER NOT NULL CHECK(is_current IN (0,1)))''')
#seminar_semester table creation
conn.execute('''CREATE TABLE IF NOT EXISTS seminar_semester (
            id INTEGER PRIMARY KEY,
            seminar_id INTEGER NOT NULL,
            semester_id INTEGER NOT NULL,
            FOREIGN KEY (semester_id) REFERENCES semesters(id),
            FOREIGN KEY(seminar_id) REFERENCES seminars(id))''')
#teachers table creation
conn.execute('''CREATE TABLE IF NOT EXISTS teachers (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL)''')
#teacher_sems table creation
conn.execute('''CREATE TABlE IF NOT EXISTS teacher_sems (
            id INTEGER PRIMARY KEY,
            teacher_id INTEGER NOT NULL,
            sems_id INTEGER NOT NULL,
            FOREIGN KEY (teacher_id) REFERENCES teachers(id),
            FOREIGN KEY(sems_id) REFERENCES semester_seminar(id))''')

#Semester system will remain janky for now
#c.execute("INSERT INTO semesters (name, is_current) VALUES ('Fall 2017', 0)")
#c.execute("INSERT INTO semesters (name, is_current) VALUES ('Spring 2018', 1)")
#conn.commit()

#c.execute('INSERT INTO teachers (name) VALUES ("Hyman"), ("Catlin"), ("Cristiano"), ("Tolias"), ("Person");')
#conn.commit()

@route('/teacher')
def teacher_home():
    return template('templates/teacher_home.tpl')

@route('/teacher/add', method="POST")
def add_page():
    if request.forms.get('save'):
        title = request.forms.get('title')
        description = request.forms.get('description')

        c.execute("INSERT INTO seminars (title, description) VALUES (?, ?)",(title, description))

        seminar_id = c.lastrowid
        c.execute("SELECT id FROM semesters WHERE is_current = 1")
        semester_id = c.fetchone()[0]
        c.execute("INSERT INTO seminar_semester (seminar_id, semester_id) VALUES (?,?)", (seminar_id, semester_id))
        sems_id = c.lastrowid

        c.execute("INSERT INTO teacher_sems (teacher_id, sems_id) VALUES (?,?)", (request.forms.get('teacher'), sems_id))
        
        conn.commit()
        
        return "Added new"

    else:
        c.execute("SELECT id, name FROM teachers")
        return template('templates/add_page.tpl', teachers = c.fetchall())

@route('/teacher/add_old', method = "POST")
def add_old():
    return "Add_old"

@route('/teacher/edit', method = "POST")
def edit():
        
    if request.forms.get('id') and not request.forms.get('save'):
        print(request.forms.get('id'))
        c.execute('SELECT id,title,description FROM seminars WHERE id LIKE ?', (request.forms.get('id')))
        seminar = c.fetchone()
        #This gets unpacked inside edit_seminar.tpl
        
        return template('templates/edit_seminar.tpl', seminar = seminar)
    else:
        if request.forms.get('save'):
            id = request.forms.get('id')
            title = request.forms.get('title')
            description = request.forms.get('description')

            c.execute('UPDATE seminars SET title = "?", description = "?" WHERE id LIKE ?', (title, description, id))
            conn.commit()


        c.execute("SELECT id,title FROM seminars")
        result = c.fetchall()        
        
        return template('templates/edit_select.tpl', result = result)
        
@route('/teacher/remove', method = "POST")
def delete():
    return "Remove Seminar"
              
@route('/teacher/what')
def what():
    c.execute("SELECT id, title, description FROM seminars")
    result = c.fetchall()
    c.execute("SELECT id, name, is_current FROM semesters")
    result += c.fetchall()
    print(c.fetchall())

    string_result = "Results:\n"
    for row in result:
        for word in row:
            string_result += str(word)
            string_result += " "

    return template('make_table', rows = result)

run(debug = True)