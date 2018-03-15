import json
from flask import Blueprint, request
from Domain.Service import GradeService
from Domain.Model.Grade import Grade

grade = Blueprint('grade', __name__)

@grade.route('/', methods=['GET'])
def getAll():
    return GradeService.getAllGrades()

@grade.route('/<id>', methods=['GET'])  
def obterPorId(id):
    return GradeService.getGradeById(id)

@grade.route('/', methods=['POST'])  
def inserirNota():
    newGrade = Grade(request.json.get('valor'), request.json.get('data'), request.json.get('id'))
    return GradeService.insertGrade(newGrade)

@grade.route('/<id>', methods=['DELETE'])  
def removerNota(id):
    return GradeService.removeGrade(id)

@grade.route('/', methods=['PUT'])  
def atualizarNota():
    newGrade = Grade(request.json.get('valor'), request.json.get('data'), request.json.get('id'))
    return GradeService.updateGrade(newGrade)
