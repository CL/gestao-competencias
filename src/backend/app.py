from flask import Flask
from Host.GradeController import grade
from Host.LoginController import login

app = Flask(__name__)

app.register_blueprint(grade, url_prefix='/grade')
app.register_blueprint(login, url_prefix='/login')

app.run()