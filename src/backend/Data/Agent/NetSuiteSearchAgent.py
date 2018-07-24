import urllib
import requests
from flask import json
from Shared import Constants
from Domain.Model.Employee import Employee
from Domain.Model.EmployeeByCategory import EmployeeByCategory

def list_by_category(association_id, user_data):
    email = user_data.email
    password = urllib.parse.quote(user_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(Constants.NLAUTH_ACCOUNT, email, password)
    headers = {"content-type": "application/json", "Authorization": auth_header}
    response = requests.get(Constants.URL_NETSUITE.format(Constants.SCRIPT_CATEGORY)+'&id='+association_id, headers=headers)
    response_data = json.loads(response.text)
    response_data = json.loads(response_data)

    if "error" in response_data:
            return None

    employee_list = []

    for json_employee in response_data:
        ep = EmployeeByCategory(json_employee.get("idFuncionario"), json_employee.get("nomeFuncionario"),
                      json_employee.get("nivelConhecimento"), json_employee.get("interesse"))
        employee_list.append(ep)
    return employee_list

def list_all(user_data):
    email = user_data.email
    password = urllib.parse.quote(user_data.password)
    auth_string = "NLAuth nlauth_account={0}, nlauth_email={1}, nlauth_signature={2}"
    auth_header = auth_string.format(Constants.NLAUTH_ACCOUNT, email, password)
    headers = {"content-type": "application/json", "Authorization": auth_header}
    response = requests.get(Constants.URL_NETSUITE.format(Constants.SCRIPT_EMPLOYEE), headers=headers)
    response_data = json.loads(response.text)
    response_data = json.loads(response_data)
    if "error" in response_data:
            return None

    employee_list = []

    for json_employee in response_data:
        ep = Employee(json_employee.get("id"), json_employee.get("nome"))
        employee_list.append(ep)
    return employee_list
