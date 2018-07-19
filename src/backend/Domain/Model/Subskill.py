class Subskill:
    def __init__(self, subskill_id='', subskill_name='', subskill_assoc_id='', subskill_rating=0.0, sub_skill_interest=False):
        self.subskill_id = subskill_id
        self.subskill_name = subskill_name
        self.subskill_assoc_id = subskill_assoc_id
        self.subskill_rating = subskill_rating
        self.sub_skill_interest = sub_skill_interest

    def to_dict(self):
        return self.__dict__
