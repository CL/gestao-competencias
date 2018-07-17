from Data.Agent import NetSuiteSkillsAgent

def save_skills(skill_list,user_data):
    if skill_list.employee is None or skill_list.category is None or skill_list.knowledgeLevel is None or skill_list.interest is None or user_data.email is None or user_data.password is None or user_data.id is None :
        return None
    return NetSuiteSkillsAgent.save_skills(skill_list, user_data)


def list_user_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    return NetSuiteSkillsAgent.list_user_skills(user_data)

def list_all_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    return NetSuiteSkillsAgent.list_all_skills(user_data)