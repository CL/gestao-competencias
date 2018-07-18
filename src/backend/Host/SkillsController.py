from flask import Blueprint, request

import json
from Domain.Model.User import User
from Domain.Model.Skills import Skills
from Domain.Service import SkillsService

skills = Blueprint('skills', __name__)


@skills.route('/', methods=['POST'])
def save_skills():

    authorization_header = request.headers['Authorization']
    authorization_split_comma = authorization_header.split(',')
    nlauth_account = authorization_split_comma[0].split('=')[1]
    nlauth_email = authorization_split_comma[1].split('=')[1]
    nlauth_signature = authorization_split_comma[2].split('=')[1]

    user_data = User(email=nlauth_email, password=nlauth_signature)

    skill_list = list()

    for data in request.json:
        employee = data['funcionario']
        category = data['categoria']
        knowledgeLevel = data['nivelConhecimento']
        interest = data['interesse']

        skill_data = Skills(employee=employee, category=category, knowledgeLevel=knowledgeLevel, interest=interest)
        skill_list.append(skill_data)

    skill_response = SkillsService.save_skills(skill_list, user_data)

    final_response_json = "["

    for i,response in enumerate(skill_response):
        if(response==None):
            return "False"
        if(i==0):
            final_response_json += '"'+response+'"'
        else:
            final_response_json += ',"' + response + '"'
    final_response_json += "]"

    return "True"

@skills.route('/', methods=['GET'])
def list_user_skills():
    id = request.json.get('id')
    role = request.json.get('role')
    email = request.json.get('email')
    name = request.json.get('name')
    password = request.json.get('password')

    user_data = User(id, role, email, name, password)

    user_skills = SkillsService.list_user_skills(user_data)

    if user_skills is not None:
        return json.dumps(user_skills.__dict__)
    else:
        return ''

@skills.route('/all', methods=['GET'])
def list_all_skills():
    id = request.json.get('id')
    role = request.json.get('role')
    email = request.json.get('email')
    name = request.json.get('name')
    password = request.json.get('password')

    user_data = User(id, role, email, name, password)

    return SkillsService.list_all_skills(user_data)

@skills.route('/', methods=['PUT'])
def update_skills():
    return ''