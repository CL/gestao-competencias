from flask import Flask
from Host.GradeController import grade

app = Flask(__name__)

app.register_blueprint(grade, url_prefix='/grade')

app.run()