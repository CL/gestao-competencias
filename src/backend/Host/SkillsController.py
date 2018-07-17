from flask import Blueprint, request

import json
from Domain.Model.User import User
from Domain.Model.Skills import Skills
from Domain.Service import SkillsService

skills = Blueprint('skills', __name__)


@skills.route('/', methods=['POST'])
def save_skills():
    id = request.json.get('id')
    role = request.json.get('role')
    email = request.json.get('email')
    name = request.json.get('name')
    password = request.json.get('password')

    user_data = User(id, role, email, name, password)

    json_response = request.json
    data_response = json.loads(json_response)

    skill_list = list()

    for data in data_response:
        employee = data.employee
        category = data.category
        knowledgeLevel = data.knowledgeLevel
        interest = data.interest

        skill_data = Skills(employee, category, knowledgeLevel, interest)
        skill_list.append(skill_data)

    skill_response = SkillsService.save_skills(skill_list, user_data)

    if(skill_response) is not None:
        return json.dumps(skill_response.__dict__)
    else:
        return ''

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