import urllib
import requests
from Domain.Model import User

URL_NETSUITE = "https://4529249-rp.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script=353&deploy=1"
NLAUTH_ACCOUNT = "4529249_RP"

def login(loginData):
    authHeader = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}".format(NLAUTH_ACCOUNT, loginData.email, urllib.parse.quote(loginData.password))
    response = requests.get(URL_NETSUITE, headers={"content-type":"application/json", "Authorization": authHeader})
    return User(response.json.get("email"), response.json.get("name"), response.json.get("id"), response.json.get("role"))