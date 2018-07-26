import random

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
    def __init__(self, id, rankings):
        self.id = id
        self.rankings = rankings

def SortStudents(students, seminars):
    for student in students:
        student.rankings[0][0].AddStudent(student, False)

    for seminar in seminars:
        seminar.RemoveStudents()

        
sem1 = Seminar(1, 0)
sem2 = Seminar(2, 1)
sem3 = Seminar(3, 2)

stud1 = Student(1, [(sem2, 10), (sem1, 4)])
stud2 = Student(2, [(sem2, 10), (sem1, 6), (sem3, 2)])

all_seminars = [sem1, sem2, sem3]

sem2.AddStudent(stud1)
sem2.AddStudent(stud2)

sem1.PrintStudents()
sem2.PrintStudents()
sem3.PrintStudents()
