import sqlite3, json
from bottle import route, run, debug, template, request, static_file,redirect


conn = sqlite3.connect('seminars.db')
c = conn.cursor()

#seminars table creation
conn.execute('''CREATE TABLE IF NOT EXISTS seminars (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            session INTEGER NOT NULL CHECK(session = 1 OR session = 2 OR session = 3))''')
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
            is_primary INTEGER NOT NULL CHECK(is_primary IN (0,1)),
            FOREIGN KEY (teacher_id) REFERENCES teachers(id),
            FOREIGN KEY(sems_id) REFERENCES semester_seminar(id))''')

#Semester system will remain janky for now
#c.execute("INSERT INTO semesters (name, is_current) VALUES ('Fall 2017', 0)")
#c.execute("INSERT INTO semesters (name, is_current) VALUES ('Spring 2018', 1)")
#conn.commit()
#c.execute('INSERT INTO teachers (name) VALUES ("Hyman"), ("Catlin"), ("Cristiano"), ("Tolias"), ("Person");')
#conn.commit()

@route('/js/<filename:path>')
def send_static(filename):
    return static_file(filename, root='js')

@route('/teacher')
def teacher_home():
    return template('templates/teacher_home.tpl')


@route('/teacher/add', method="GET")
def add_page():
    c.execute("SELECT id, name FROM teachers")
    teachers=json.dumps(c.fetchall())
        
    return template('templates/add_seminar.tpl', teachers=teachers)

@route('/teacher/add', method="POST")
def add_page():
    title = request.forms.get('title')
    description = request.forms.get('description')
    teacher = request.forms.get('teacher')
    session = request.forms.get('session')
    

    c.execute("INSERT INTO seminars (title, description, session) VALUES (?, ?, ?)",(title, description, session))

    seminar_id = c.lastrowid
    c.execute("SELECT id FROM semesters WHERE is_current = 1")
    semester_id = c.fetchone()[0]
    c.execute("INSERT INTO seminar_semester (seminar_id, semester_id) VALUES (?,?)", (seminar_id, semester_id))
    sems_id = c.lastrowid

    c.execute("INSERT INTO teacher_sems (teacher_id, sems_id) VALUES (?,?)", (teacher, sems_id))
        
    conn.commit()
        
    redirect('/teacher')

@route('/teacher/add_old', method = "GET")
def add_old():
    #selects seminars that were offered in previous semester but are NOT offered this semester
    c.execute('''SELECT semi.id, semi.title, semi.description FROM seminars semi
    INNER JOIN seminar_semester sems ON sems.seminar_id = semi.id
    INNER JOIN semesters seme ON sems.semester_id = seme.id AND seme.is_current = 0
    WHERE semi.id NOT IN(
    SELECT semi.id FROM seminars semi
    INNER JOIN seminar_semester sems ON sems.seminar_id = semi.id
    INNER JOIN semesters seme ON sems.semester_id = seme.id AND seme.is_current = 1)''')

    old_seminars=json.dumps(c.fetchall())
    
    return template('templates/add_old_seminar.tpl', old_seminars=old_seminars)
@route('/teacher/add_old', method = "POST")
def add_old_save():
    new_sems_ids = request.forms.getall('added_sems')
    c.execute("SELECT id FROM semesters WHERE is_current = 1")
    semester_id = c.fetchone()[0]
    print(semester_id)
    for sem_id in new_sems_ids:
        sem_id = int(sem_id)
        print(sem_id)
        c.execute("INSERT INTO seminar_semester (seminar_id, semester_id) VALUES (?, ?)", (sem_id, semester_id))
    conn.commit()

    redirect("/teacher")

@route('/teacher/edit', method = "POST")
def edit():
        
    if request.forms.get('sems_id') and not request.forms.get('save'):
        #Actual editing page
        sems_id = request.forms.get('sems_id')
        
        c.execute('SELECT id,title,description FROM seminars WHERE id IN (SELECT seminar_id FROM seminar_semester WHERE id = ?)', (sems_id))
        seminar = c.fetchone()
        
        #This gets unpacked inside edit_seminar.tpl


        c.execute("SELECT id, name FROM teachers")
        teachers = json.dumps(c.fetchall())

        c.execute("SELECT teacher_id, name FROM teacher_sems INNER JOIN teachers ON teacher_sems.teacher_id = teachers.id WHERE sems_id = ?", (sems_id))
        selected_teachers = json.dumps(c.fetchall())
        print(teachers)
        
        return template('templates/edit_seminar.tpl', seminar = seminar, teachers=teachers, sems_id = sems_id, selected_teachers = selected_teachers)
    else:
        if request.forms.get('save'):
            #Saves the edits to the seminars table
            sem_id = request.forms.get('sem_id')
            title = request.forms.get('title')
            description = request.forms.get('description')

            c.execute('UPDATE seminars SET title = ?, description = ? WHERE id = ?', (title, description, sem_id))

            #Resets links in the teacher_sems table
            sems_id = request.forms.get('sems_id')
            
            c.execute("DELETE FROM teacher_sems WHERE sems_id = ?", (sems_id))
            added_teachers = []
            for teacher in request.forms.getall('teacher'):
                if teacher not in added_teachers:
                    added_teachers.append(teacher)
                    c.execute("INSERT INTO teacher_sems (teacher_id, sems_id) VALUES (?, ?)", (teacher, sems_id))

            conn.commit()

        #Edit select page: picks a seminar to edit from the seminar table that is linked to the currently active semester
        c.execute('''SELECT sems.id,  semi.title FROM seminar_semester sems
        INNER JOIN seminars semi ON sems.seminar_id = semi.id
        INNER JOIN semesters seme ON sems.semester_id = seme.id WHERE seme.is_current =1''')
        
        results = c.fetchall()

        return template('templates/edit_select.tpl', results = results)
        
@route('/teacher/remove', method="GET")
def remove():
    c.execute('''SELECT sems.id,  semi.title FROM seminar_semester sems
        INNER JOIN seminars semi ON sems.seminar_id = semi.id
        INNER JOIN semesters seme ON sems.semester_id = seme.id WHERE seme.is_current =1''')

    seminars = json.dumps(c.fetchall())
    
    return template('templates/remove_seminar.tpl', seminars = seminars)
@route('/teacher/remove', method="POST")
def remove_submit():
    for sems_id in request.forms.getall("removed"):
        c.execute("DELETE FROM seminars WHERE id = (SELECT seminar_id FROM seminar_semester WHERE ID = ?)",(sems_id))
        c.execute("DELETE FROM seminar_semester WHERE id = ?",(sems_id))
        
    conn.commit()
    redirect("/teacher")


run(debug = True, reloader = True)
#because for some reason the reloader doesn't work on my laptop because everything is terrible.
#run(debug =True)
