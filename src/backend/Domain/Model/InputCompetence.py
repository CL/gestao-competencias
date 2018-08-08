class InputCompetence:
    def __init__(self, employee, category, knowledge_level, interest):
        self.funcionario = employee
        self.categoria = category
        self.nivelConhecimento = knowledge_level
        self.interesse = interest

    def to_dict(self):
        return self.__dict__