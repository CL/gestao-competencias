from Domain.Model.Grade import Grade
from Data import GradeRepository

def getGradeById(id):
    return GradeRepository.getGradeById(id)

def insertGrade(nota):
    return GradeRepository.insertGrade(nota)

def getAllGrades():
    return GradeRepository.getAllGrades()

def removeGrade(id):
    return GradeRepository.removeGrade(id)

def updateGrade(nota):
    return GradeRepository.updateGrade(nota)