from flask import Flask
from Host.LoginController import login
from Host.LoginController import skills
from Host.LoginController import subSkills
from Host.LoginController import search

app = Flask(__name__)

app.register_blueprint(login, url_prefix='/login')
app.register_blueprint(skills, url_prefix='/skills')
app.register_blueprint(subSkills, url_prefix='/subSkills')
app.register_blueprint(search, url_prefix='/search')

app.run()