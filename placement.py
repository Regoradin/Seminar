import random, sqlite3

class Seminar:
    def __init__(self, id, capacity, session):
        self.id = id
        self.capacity = capacity
        self.students = []
        self.session = session

    def AddStudent(self, student, keep_capacity = True):
        self.students.append(student)

        if keep_capacity:
            self.RemoveStudents()

    def RemoveStudents(self):
        while len(self.students) > self.capacity:
            min_benefit = 100
            min_student = None
            for student in self.students:
                if self.session == 1:
                    rankings = student.first_rankings
                if self.session == 2:
                    rankings = student.second_rankings
                for i in range(0,len(rankings)):
                    if rankings[i][0] == self:
                        #benefit is calculated as (the weight assigned to this seminar - the next best seminar)
                        found_next_best = False
                        #Loops to the next highest ranked seminar with open seats
                        for j in range(i,len(rankings)):
                            next_best_seminar = rankings[j][0]
                            if next_best_seminar.capacity > len(next_best_seminar.students):
                                benefit = rankings[i][1] - rankings[j][1]
                                found_next_best = True
                        #If that doesn't exist, benefit is just the benefit of being in the current seminar
                        if not found_next_best:
                            benefit = rankings[i][1]
                        #Minor bias towards upperclassmen here
                        if benefit < min_benefit or (benefit == min_benefit and student.grade < min_student.grade):
                            min_benefit = benefit
                            min_student = student
                        break
                    #only gets to here if this seminar isn't even on their list, in which case it's impossible to get benefit
                    min_student = student
                    min_benefit = 0
                    
            #Kicks the student out, and moves them to their highest ranked seminar with open seats
            self.students.remove(min_student)
            placed = False
            if self.session == 1:
                rankings = min_student.first_rankings
            if self.session == 2:
                rankings = min_student.second_rankings
            if self.session == 3:
                rankings = min_student.double_rankings

            for ranking in rankings:
                if ranking[0].capacity > len(ranking[0].students):
                    ranking[0].AddStudent(min_student)
                    placed = True
            if not placed:
                if self.session == 1:
                    all_first_seminars.values()[random.randint(0, len(all_first_seminars.values())-1)].AddStudent(min_student)
                if self.session == 2:
                    all_second_seminars.values()[random.randint(0, len(all_second_seminars.values())-1)].AddStudent(min_student)
                if self.session == 3:
                    min_student.first_rankings[0][0].AddStudent(student)
                    min_student.second_rankings[0][0].AddStudent(student)

        return
            
    def PrintStudents(self):
        print("Students in seminar " + str(self.id))
        for student in self.students:
            print(student.id)


class Student:
    def __init__(self, id, grade):
        self.id = id
        self.first_rankings = []
        self.second_rankings = []
        self.double_rankings = []
        self.grade = grade

    def AddRanking(self, sem, ranking):
        if sem.session == 1:
            rankings = self.first_rankings
        if sem.session == 2:
            rankings = self.second_rankings
        if sem.session == 3:
            rankings = self.double_rankings

        #places the new ranking in the appropriate list in order
        if len(rankings) == 0:
            rankings.append((sem, ranking))
        else:
            for i in range(0, len(self.rankings)):
                if rankings[i][1] < ranking:
                    rankings.insert(i, (sem, ranking))
        

def SortStudents(students, seminars, unranked_students):
    #Adds all students into their first choice seminar
    for student in students:
        if len(student.double_rankings) != 0:
            student.double_rankings[0][0].AddStudent(student, False)
        else:
            if len(student.first_rankings) != 0:
                student.first_rankings[0][0].AddStudent(student, False)
            else:
                all_first_seminars.values()[random.randint(0, len(all_first_seminars.values())-1)].AddStudent(student)
            if len(student.second_rankings) != 0:
                student.second_rankings[0][0].AddStudent(student, False)
            else:
                all_second_seminars.values()[random.randint(0, len(all_second_seminars.values())-1)].AddStudent(student)


    #Places students who did not make a selection into a random seminar
    for student in unranked_students:
        all_first_seminars.values()[random.randint(0, len(all_first_seminars.values())-1)].AddStudent(student)
        all_second_seminars.values()[random.randint(0, len(all_second_seminars.values())-1)].AddStudent(student)
            
    for seminar in seminars:
        seminar.RemoveStudents()
    #All seminars should now be at or under capacity and students should be properly sorted
    conn.execute('''DROP TABLE if exists assignments''')
    conn.execute('''CREATE TABLE assignments(
                 id INTEGER PRIMARY KEY,
                 sems_id INTEGER NOT NULL,
                 student_id INTEGER NOT NULL,
                 FOREIGN KEY (sems_id) REFERENCES seminar_semester(id),
                 FOREIGN KEY (student_id) REFERENCES students(id))''')

    for seminar in seminars:
        for student in seminar.students:
            c.execute('''INSERT INTO assignments (sems_id, student_id) VALUES (?, ?)''',(seminar.id, student.id))

    conn.commit()


conn = sqlite3.connect('seminars.db')
c = conn.cursor()

#Builds seminar items
all_first_seminars = {}
all_second_seminars = {}
all_double_seminars = {}
c.execute('''SELECT sems.id, semi.capacity, semi.session  FROM seminar_semester sems
           INNER JOIN seminars semi ON semi.id = sems.seminar_id
           INNER JOIN semesters seme ON seme.id = sems.semester_id WHERE seme.is_current = 1''')
results = c.fetchall()
for result in results:
    new_seminar = Seminar(result[0], result[1], result[2])
    if int(result[2]) == 1:
        all_first_seminars[result[0]] = new_seminar
    if int(result[2]) == 2:
        all_second_seminars[result[0]] = new_seminar
    if int(result[2]) == 3:
        all_double_seminars[result[0]] = new_seminar

all_seminars = all_first_seminars
all_seminars.update(all_second_seminars)
all_seminars.update(all_double_seminars)
#Builds student items
all_ranked_students = []
created_ids = []
c.execute('''SELECT choices.student_id, choices.rank, choices.sems_id, students.grade FROM student_choices choices
          INNER JOIN students students ON choices.student_id = students.id''')
results = c.fetchall()
for result in results:
    #matches sems_id to seminar object
    seminar = all_seminars[result[2]]
    
    if result[0] not in created_ids:
        student = Student(result[0], int(result[3]))
        all_ranked_students.append(student)
        created_ids.append(result[0])
        student.AddRanking(seminar, result[1])
    else:
        for student in all_ranked_students:
            if student.id == result[0]:
                student.AddRanking(seminar, result[1])
                break

#creating students who did not put a ranking
all_unranked_students = []
c.execute('''SELECT id,grade FROM students WHERE id NOT IN (SELECT student_id FROM student_choices)''')
unranked_students = c.fetchall()
for student in unranked_students:
    print("UNRANKED: %s" % student[0])
    new_student = Student(student[0], int(student[1]))
    all_unranked_students.append(new_student)
          
SortStudents(all_ranked_students, all_seminars.values(), all_unranked_students)

# sem1 = Seminar(1, 0)
# sem2 = Seminar(2, 1)
# sem3 = Seminar(3, 2)

# stud1 = Student(1, [(sem2, 10), (sem1, 4)])
# stud2 = Student(2, [(sem2, 10), (sem1, 6), (sem3, 2)])

# all_seminars = [sem1, sem2, sem3]

# sem2.AddStudent(stud1)
# sem2.AddStudent(stud2)

# sem1.PrintStudents()
# sem2.PrintStudents()
# sem3.PrintStudents()
