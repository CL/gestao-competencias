class Employee:
    def __init__(self, id='', name='', email=''):
        self.id = id
        self.name = name
        self.email = email

    def to_dict(self):
        return self.__dict__
