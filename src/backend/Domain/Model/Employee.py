class Employee:
    def __init__(self, id='', name=''):
        self.id = id
        self.name = name

    def to_dict(self):
        return self.__dict__
