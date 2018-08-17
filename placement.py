import random, sqlite3

class Seminar:
    def __init__(self, id, capacity):
        self.id = id
        self.capacity = capacity
        self.students = []

    def AddStudent(self, student, keep_capacity = True):
        self.students.append(student)

        if keep_capacity:
            self.RemoveStudents()

    def RemoveStudents(self):
        while len(self.students) > self.capacity:
            min_benefit = 100
            min_student = ""
            for student in self.students:
                for i in range(0,len(student.rankings)):
                    if student.rankings[i][0] == self:
                        #benefit is calculated as the weight assigned to this seminar - the next best seminar
                        found_next_best = False
                        for j in range(i,len(student.rankings)):
                            next_best_seminar = student.rankings[j][0]
                            if next_best_seminar.capacity > len(next_best_seminar.students):
                                benefit = student.rankings[i][1] - student.rankings[j][1]
                                found_next_best = True
                        if not found_next_best:
                            if student.rankings[-1][0] == self:
                                benefit = student.rankings[-1][1]
                            else:
                                benefit = student.rankings[i][1]
                        if benefit < min_benefit:
                            min_benefit = benefit
                            min_student = student
                        break

            self.students.remove(min_student)
            placed = False
            for ranking in min_student.rankings:
                if ranking[0].capacity > len(ranking[0].students):
                    ranking[0].AddStudent(min_student)
                    placed = True
            if not placed:
                all_seminars[random.randint(0, len(all_seminars)-1)].AddStudent(min_student)
        return
            
    def PrintStudents(self):
        print("Students in seminar " + str(self.id))
        for student in self.students:
            print(student.id)


class Student:
    def __init__(self, id):
        self.id = id
        self.rankings = []

    def AddRanking(self, sem, ranking):
        if len(self.rankings) == 0:
            self.rankings.append((sem, ranking))
        else:
            for i in range(0, len(self.rankings)):
                if self.rankings[i][1] < ranking:
                    self.rankings.insert(i, (sem, ranking))
        

def SortStudents(students, seminars):
    for student in students:
        print("STUDENT RANKINGS")
        print(student.rankings)
        student.rankings[0][0].AddStudent(student, False)

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

    for seminar in all_seminars.values():
        for student in seminar.students:
            c.execute('''INSERT INTO assignments (sems_id, student_id) VALUES (?, ?)''',(seminar.id, student.id))

    conn.commit()


conn = sqlite3.connect('seminars.db')
c = conn.cursor()

#Builds seminar items
all_seminars = {}
c.execute('''SELECT sems.id, semi.capacity FROM seminar_semester sems
           INNER JOIN seminars semi ON semi.id = sems.seminar_id
           INNER JOIN semesters seme ON seme.id = sems.semester_id WHERE seme.is_current = 1''')
results = c.fetchall()
for result in results:
    new_seminar = Seminar(result[0], result[1])
    all_seminars[result[0]] = new_seminar
    
#Builds student items
all_students = []
created_ids = []
c.execute('''SELECT student_id, rank, sems_id FROM student_choices''')
results = c.fetchall()
for result in results:
    #matches sems_id to seminar object
    seminar = all_seminars[result[2]]
    
    if result[0] not in created_ids:
        student = Student(result[0])
        all_students.append(student)
        created_ids.append(result[0])
        student.AddRanking(seminar, result[1])
    else:
        for student in all_students:
            if student.id == result[0]:
                student.AddRanking(seminar, result[1])
                break

print("Number of Students:")
print(len(all_students))
print("Created_ids:")
for id in created_ids:
    print(id)
            
SortStudents(all_students, all_seminars.values())

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
