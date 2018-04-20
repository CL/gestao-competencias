from Domain.Model import Login
from Data.Agent import NetSuiteLoginAgent

def login(data):
    return NetSuiteLoginAgent.login(data)