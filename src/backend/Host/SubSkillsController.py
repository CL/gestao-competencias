import json
from flask import Blueprint, request

subSkills = Blueprint('subskills', __name__)


@subSkills.route('/', methods=['POST'])
def save_subskills():
    return ''

@subSkills.route('/', methods=['GET'])
def get_subskills():
    return ''

@subSkills.route('/', methods=['PUT'])
def update_subskills():
    return ''
