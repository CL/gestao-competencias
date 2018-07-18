class Skill:
    def __init__(self, skill_id='', skill_name='', skill_rating=0.0, total_sub_skills=0, sub_skills=[]):
        self.skill_id = skill_id
        self.skill_name = skill_name
        self.skill_rating = skill_rating
        self.total_sub_skills = total_sub_skills
        self.sub_skills = sub_skills

    def to_dict(self):
        return self.__dict__
