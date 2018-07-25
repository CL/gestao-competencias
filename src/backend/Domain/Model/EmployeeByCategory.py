class EmployeeByCategory:
    def __init__(self, id='', name='', knowledge='', interest=''):
        self.id = id
        self.name = name
        self.knowledge = knowledge
        self.interest = interest

    def to_dict(self):
        return self.__dict__
