from Data.Agent import NetSuiteLoginAgent


def login(data):
    if data.email is None or data.password is None:
        return None
    
    return NetSuiteLoginAgent.login(data)