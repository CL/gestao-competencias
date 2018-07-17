import json
from flask import Blueprint, request

search = Blueprint('search', __name__)


@search.route('/category', methods=['GET'])
def searchByCategory(id_category):
    return ''

@search.route('/name', methods=['GET'])
def searchByName(name):
    return ''