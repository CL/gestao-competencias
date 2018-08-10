import os

from flask import Flask
from Host.LoginController import login
from Host.SkillsController import skills
from Host.SearchController import search

app = Flask(__name__)

app.register_blueprint(login, url_prefix='/login')
app.register_blueprint(skills, url_prefix='/skills')
app.register_blueprint(search, url_prefix='/search')

app.run(host=os.environ.get("HOST_APP", "127.0.0.1"), port=int(os.environ.get("PORT", "5000")))
