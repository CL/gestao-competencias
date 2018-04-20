import json
from flask import Blueprint, request
from Domain.Model import Login
from Domain.Service import LoginService

login = Blueprint('login', __name__)

@login.route('/', methods=['POST'])

def inserirNota():
    dadosLogin = Login(request.json.get('email'), request.json.get('password'))
    user = LoginService.login(dadosLogin)
    return json.dumps(user)
