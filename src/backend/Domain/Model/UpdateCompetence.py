class UpdateCompetence:
    def __init__(self,entry_id, employee, category, knowledge_level, interest):
        self.funcionario = employee
        self.categoria = category
        self.nivelConhecimento = knowledge_level
        self.interesse = interest
        self.id = entry_id