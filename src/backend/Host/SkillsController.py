from flask import Blueprint, request

import json
from Domain.Model.User import User
from Domain.Service import SkillsService

skills = Blueprint('skills', __name__)


@skills.route('/', methods=['POST'])
def save_skills():
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