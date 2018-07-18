from Data.Agent import NetSuiteSkillsAgent

def save_skills(skill_list,user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None
    for skill in skill_list:
        if skill.funcionario is None or skill.categoria is None or skill.nivelConhecimento is None or skill.interesse is None:
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