from Data.Agent import NetSuiteSkillsAgent


def list_user_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    return NetSuiteSkillsAgent.list_user_skills(user_data)

def list_all_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    return NetSuiteSkillsAgent.list_all_skills(user_data)