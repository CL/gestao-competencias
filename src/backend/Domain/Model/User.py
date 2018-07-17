class User:
    def __init__(self, email, name, user_id, role, password):
        self.id = user_id
        self.role = role
        self.email = email
        self.name = name
        self.password = password
