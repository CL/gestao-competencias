import os

URL_NETSUITE = os.environ.get('URL_NETSUITE', 'https://4529249.restlets.api.netsuite.com/app/site/hosting/restlet.nl?script={0}&deploy=1')

NLAUTH_ACCOUNT = os.environ.get('NLAUTH_ACCOUNT', '4529249')

SCRIPT_LOGIN = os.environ.get('SCRIPT_LOGIN', '436')

SCRIPT_RELACIONAL = os.environ.get('SCRIPT_RELACIONAL', '435')

SCRIPT_COMPETENCIAS = os.environ.get('SCRIPT_COMPETENCIAS', '434')

SCRIPT_EMPLOYEE = os.environ.get('SCRIPT_EMPLOYEE', '439')

SCRIPT_CATEGORY = os.environ.get('SCRIPT_CATEGORY', '445')
