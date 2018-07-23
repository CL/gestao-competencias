from Data.Agent import NetSuiteSearchAgent


def list_by_category(association_id, user_data):
    if user_data.email is None or user_data.password is None or association_id is None:
        return None

    return NetSuiteSearchAgent.list_by_category(association_id, user_data)


def list_all(user_data):
    if user_data.email is None or user_data.password is None:
        return None

    return NetSuiteSearchAgent.list_all(user_data)