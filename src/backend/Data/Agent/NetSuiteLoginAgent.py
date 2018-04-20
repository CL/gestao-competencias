import urllib
import requests
from Domain.Model.User import User
from flask import json

URL_NETSUITE = "https://4529249-rp.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=353&deploy=1"
NLAUTH_ACCOUNT = "4529249_RP"


def login(login_data):
    email = login_data.email
    password = urllib.parse.quote(login_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(NLAUTH_ACCOUNT, email, password)
    response = requests.get(URL_NETSUITE, headers={"content-type": "application/json", "Authorization": auth_header})
    response_data = json.loads(response.text)
    if "error" in response_data:
            return None

    return User(response_data["email"], response_data["name"], response_data["id"], response_data["role"])
