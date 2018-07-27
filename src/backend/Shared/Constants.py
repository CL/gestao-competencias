import os

URL_NETSUITE = os.environ.get('URL_NETSUITE', 'https://4529249-sb1.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script={0}&deploy=1')

NLAUTH_ACCOUNT = os.environ.get('NLAUTH_ACCOUNT', '4529249_SB1')

SCRIPT_LOGIN = os.environ.get('SCRIPT_LOGIN', '370')

SCRIPT_RELACIONAL = os.environ.get('SCRIPT_RELACIONAL', '443')

SCRIPT_COMPETENCIAS = os.environ.get('SCRIPT_COMPETENCIAS', '444')

SCRIPT_EMPLOYEE = os.environ.get('SCRIPT_EMPLOYEE', '446')

SCRIPT_CATEGORY = os.environ.get('SCRIPT_CATEGORY', '449')
