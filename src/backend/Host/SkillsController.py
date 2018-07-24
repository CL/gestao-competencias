from flask import Blueprint, request

import json
from Domain.Model.User import User
from Domain.Model.InputCompetence import InputCompetence
from Domain.Service import SkillsService
from Shared.ObjectHandler import object_handler

skills = Blueprint('skills', __name__)


@skills.route('', methods=['POST'])
def save_skills():
    authorization_header = request.headers['Authorization']
    authorization_split_comma = authorization_header.split(',')
    email = authorization_split_comma[0].split('=')[1]
    signature = authorization_split_comma[1].split('=')[1]
    id = authorization_split_comma[2].split('=')[1]

    user_data = User(email=email, password=signature, user_id=id)

    skill_list = list()

    for data in request.json:
        employee = id
        category = data['subskill_assoc_id']
        knowledge_level = int(data['subskill_rating'])
        interest = data['sub_skill_interest']

        skill_data = InputCompetence(employee=employee, category=category, knowledge_level=knowledge_level, interest=interest)

        if skill_data.nivelConhecimento > 0:
            skill_list.append(skill_data)

    skill_response = SkillsService.save_skills(skill_list, user_data)

    for response in skill_response:
        if response is None:
            return "False"

    return "True"


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

@skills.route('', methods=['PUT'])
def update_skills():
    return ''

@skills.route('', methods=['DELETE'])
def delete_skill():
    id_macro = request.args.get('idMacro')
    funcionario = request.args.get('funcionario')
    authorization_header = request.headers['Authorization']
    authorization_split_comma = authorization_header.split(',')
    email = authorization_split_comma[0].split('=')[1]
    signature = authorization_split_comma[1].split('=')[1]
    id = authorization_split_comma[2].split('=')[1]

    user_data = User(email=email, password=signature, user_id=id)

    SkillsService.delete_skill(id_macro, funcionario, user_data)

    return ''