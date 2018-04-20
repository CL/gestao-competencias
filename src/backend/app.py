from flask import Flask
from Host.LoginController import login

app = Flask(__name__)

app.register_blueprint(login, url_prefix='/login')

app.run()