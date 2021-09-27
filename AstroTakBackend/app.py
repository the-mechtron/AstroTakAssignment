from flask import Flask
from flask_sqlalchemy import SQLAlchemy


def create_app():
    app = Flask(__name__)
    app.secret_key = 'Blah-Blah'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
    app.config['SECRET_KEY'] = 'Thisissupposedtobesecret!'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///D:/Flutter Projects/My Databases/Trying.db'
    return app


app = create_app()
database = SQLAlchemy(app)
