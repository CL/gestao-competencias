import json
from flask import Blueprint, request
from Domain.Model.Login import Login
from Domain.Service import LoginService

login = Blueprint('login', __name__)


@login.route('', methods=['POST'])
def login_user():
    data_login = Login(request.json.get('email'), request.json.get('password'))
    user = LoginService.login(data_login)
    if user is not None:
        return json.dumps(user.__dict__)
    else:
        return ""
