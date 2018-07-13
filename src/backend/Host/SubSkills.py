import json
from flask import Blueprint, request
from Domain.Model.Login import Login
from Domain.Service import LoginService

login = Blueprint('subskills', __name__)


@login.route('/', methods=['POST'])
def save_subskills():
    return ''

@login.route('/', methods=['GET'])
def get_subskills():
    return ''

@login.route('/', methods=['PUT'])
def update_subskills():
    return ''
