import urllib
import requests
from Domain.Model.User import User
from flask import json
from Shared import Constants


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
