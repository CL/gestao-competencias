import json
from flask import Blueprint, request

skills = Blueprint('skills', __name__)


@skills.route('/', methods=['POST'])
def save_skills():
    return ''

@skills.route('/', methods=['GET'])
def get_skills():
    return ''

@skills.route('/', methods=['PUT'])
def update_skills():
    return ''