class CompetenceRegistry:
    def __init__(self, id='', category='', rating=0.0, interest=0, id_skill='', id_subskill='', text_skill='', text_subskill=''):
        self.id = id
        self.category = category
        self.rating = rating
        self.interest = interest
        self.id_skill = id_skill
        self.id_subskill = id_subskill
        self.text_skill = text_skill
        self.text_subskill = text_subskill

    def to_dict(self):
        return self.__dict__
