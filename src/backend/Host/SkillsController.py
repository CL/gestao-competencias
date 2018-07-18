from flask import Blueprint, request

import json
from Domain.Model.User import User
from Domain.Service import SkillsService
from Shared.ObjectHandler import object_handler

skills = Blueprint('skills', __name__)


@skills.route('/', methods=['POST'])
def save_skills():

    return ''

@skills.route('', methods=['GET'])
def list_user_skills():
    id = request.args.get('id')
    role = request.args.get('role')
    email = request.args.get('email')
    name = request.args.get('name')
    password = request.args.get('password')

    user_data = User(email=email, name=name, user_id=id, role=role, password=password)

    user_skills = SkillsService.list_user_skills(user_data)

    if user_skills is not None:
        return json.dumps(user_skills, default=object_handler)

    return ''

@skills.route('/all', methods=['GET'])
def list_all_skills():
    id = request.args.get('id')
    role = request.args.get('role')
    email = request.args.get('email')
    name = request.args.get('name')
    password = request.args.get('password')

    user_data = User(email=email, name=name, user_id=id, role=role, password=password)

    return json.dumps(SkillsService.list_all_skills(user_data), default=object_handler)

@skills.route('/', methods=['PUT'])
def update_skills():
    return ''