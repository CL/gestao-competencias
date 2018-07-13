import json
from flask import Blueprint, request
from Domain.Model.Login import Login
from Domain.Service import LoginService

login = Blueprint('skills', __name__)


@login.route('/', methods=['POST'])
def save_skills():
    return ''

@login.route('/', methods=['GET'])
def get_skills():
    return ''

@login.route('/', methods=['PUT'])
def update_skills():
    return ''