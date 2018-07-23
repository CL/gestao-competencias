from Data.Agent import NetSuiteSkillsAgent
from collections import defaultdict

from Domain.Model.Skill import Skill
from Domain.Model.Subskill import Subskill


def save_skills(skill_list, user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    for skill in skill_list:
        if skill.funcionario is None or skill.categoria is None or skill.nivelConhecimento is None or skill.interesse is None:
            return None

    return NetSuiteSkillsAgent.save_skills(skill_list, user_data)


def list_user_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    competences = NetSuiteSkillsAgent.list_user_skills(user_data)

    macro_dict = defaultdict(Skill)

    for competence in competences:
        if competence.rating is not '0':
            subskill = Subskill(competence.id_subskill, competence.text_subskill, competence.category, competence.rating, competence.interest, competence.id)
            if macro_dict[competence.id_skill].skill_id is '':
                macro_dict[competence.id_skill].skill_id = competence.id_skill
                macro_dict[competence.id_skill].skill_name = competence.text_skill
                macro_dict[competence.id_skill].sub_skills = []

            macro_dict[competence.id_skill].sub_skills.append(subskill)
            macro_dict[competence.id_skill].skill_rating += float(competence.rating)
            macro_dict[competence.id_skill].skill_rating /= 2

        macro_dict[competence.id_skill].total_sub_skills += 1

    all_skills = []
    for item in macro_dict.values():
        all_skills.append(item)
    return all_skills


def list_all_skills(user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None:
        return None

    skills_dto = NetSuiteSkillsAgent.list_all_skills(user_data)

    if skills_dto is None:
        return None

    macro_dict = defaultdict(Skill)

    for skill_data in skills_dto:
        subskill = Subskill(skill_data.category_micro, skill_data.category_micro_text, skill_data.id)
        if macro_dict[skill_data.category_macro].skill_id is '':
            macro_dict[skill_data.category_macro].skill_id = skill_data.category_macro
            macro_dict[skill_data.category_macro].skill_name = skill_data.category_macro_text
            macro_dict[skill_data.category_macro].sub_skills = []

        macro_dict[skill_data.category_macro].sub_skills.append(subskill)
        macro_dict[skill_data.category_macro].total_sub_skills = len(macro_dict[skill_data.category_macro].sub_skills)

    all_skills = []
    for item in macro_dict.values():
        all_skills.append(item)
    return all_skills

def delete_skill(id_macro, funcionario, user_data):
    if user_data.email is None or user_data.password is None or user_data.id is None or id_macro is None or funcionario is None:
        return None

    return NetSuiteSkillsAgent.delete_skill(id_macro, funcionario, user_data)
