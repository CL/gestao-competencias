import json
from flask import Blueprint, request

search = Blueprint('search', __name__)


@search.route('/category', methods=['GET'])
def searchByCategory(idCategory):
    return ''

@search.route('/name', methods=['GET'])
def searchByName(name):
    return ''