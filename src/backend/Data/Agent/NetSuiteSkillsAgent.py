import urllib
import requests
from Domain.Model.User import User
from flask import json
from Shared import Constants

def save_skills(skill_list, user_data):
    email = user_data.email
    password = urllib.parse.quote(user_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(Constants.NLAUTH_ACCOUNT, email, password)
    headers = {"content-type": "application/json", "Authorization": auth_header}

    response_list = list()

    for skill_data in skill_list:
        skill_data_json = json.dumps(skill_data.__dict__)
        print(skill_data_json)
        response = requests.post(Constants.URL_NETSUITE.format(Constants.SCRIPT_COMPETENCIAS), data=skill_data_json, headers=headers)
        print(response.text)
        response_data = json.loads(response.text)
        if "error" in response_data:
            return None
        response_list.append(response_data)
    return response_list

def list_user_skills(user_data):
    email = user_data.email
    password = urllib.parse.quote(user_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(Constants.NLAUTH_ACCOUNT, email, password)
    headers = {"content-type": "application/json", "Authorization": auth_header}
    response = requests.get(Constants.URL_NETSUITE.format(Constants.SCRIPT_LOGIN), headers=headers)
    response_data = json.loads(response.text)
    if "error" in response_data:
            return None

    return response_data

def list_all_skills(user_data):
    email = user_data.email
    password = urllib.parse.quote(user_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(Constants.NLAUTH_ACCOUNT, email, password)
    headers = {"content-type": "application/json", "Authorization": auth_header}
    response = requests.get(Constants.URL_NETSUITE.format(Constants.SCRIPT_RELACIONAL), headers=headers)
    response_data = json.loads(response.text)
    if "error" in response_data:
        return None

    return response_data
