import json
from flask import Blueprint, request

search = Blueprint('search', __name__)


@search.route('/category', methods=['GET'])
def search_by_category(id_category):
    return ''

@search.route('/name', methods=['GET'])
def search_by_name(name):
    return ''