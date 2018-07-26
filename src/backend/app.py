import os

from flask import Flask
from Host.LoginController import login
from Host.SkillsController import skills
from Host.SearchController import search

app = Flask(__name__)

app.register_blueprint(login, url_prefix='/login')
app.register_blueprint(skills, url_prefix='/skills')
app.register_blueprint(search, url_prefix='/search')

app.run(host='0.0.0.0', port=os.environ.get("PORT", 5000))
