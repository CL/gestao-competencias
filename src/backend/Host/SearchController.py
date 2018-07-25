from flask import Blueprint, request

import json
from Domain.Model.Login import Login
from Domain.Service import SearchService
from Shared.ObjectHandler import object_handler

search = Blueprint('search', __name__)


@search.route('/category', methods=['GET'])
def search_by_category():
    email_user = request.args.get('email')
    password_user = request.args.get('password')
    association_id = request.args.get('id')

    user_data = Login(email=email_user, password=password_user)

    list_by_category = SearchService.list_by_category(association_id, user_data)

    if list_by_category is not None:
        return json.dumps(list_by_category, default=object_handler)

    return ''


@search.route('', methods=['GET'])
def search_all():
    email_user = request.args.get('email')
    password_user = request.args.get('password')

    user_data = Login(email=email_user, password=password_user)

    return json.dumps(SearchService.list_all(user_data), default=object_handler)
