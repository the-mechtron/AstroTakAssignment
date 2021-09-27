import base64
import json

import boto3
import requests
from botocore.config import Config
from flask import Flask, render_template, redirect, url_for, request, jsonify, send_from_directory
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField
from wtforms.validators import InputRequired, Email, Length
from flask_sqlalchemy  import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
# from Horoscope import Page
# from sqlalchemy_imageattach.entity import Image, image_attachment
from sqlalchemy_imageattach.stores.fs import HttpExposedFileSystemStore


app = Flask(__name__, static_url_path='')
app.config['SECRET_KEY'] = 'Thisissupposedtobesecret!'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///D:/Flutter Projects/My Databases/Trying.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
# from Horoscope import setup

auth_db = SQLAlchemy(app)
image_db = SQLAlchemy(app)
database = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)
temp_image_url = "D:/Flutter Projects/My Databases/Photos/"

s3 = boto3.client('s3',
                    region_name = "ap-south-1",
                    config=Config(signature_version='s3v4'),
                    aws_access_key_id='AKIA6B5NHVV3ADDZSUAR',
                    aws_secret_access_key= '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',)
# print(s3.list_objects(Bucket='astrologers')['Contents'])
a = s3.list_objects(Bucket='astrologers')['Contents']
presigned_url = s3.generate_presigned_url('get_object',
                Params={'Bucket': 'astrologers', 'Key': a[0]['Key']},
                ExpiresIn=3000)
print(presigned_url)

print("\n\n****************************\n\n")


class Astrologer(UserMixin, database.Model):

    __tablename__ = 'Astrologer'

    id = database.Column(database.Integer, nullable=False, primary_key=True, unique=True)
    name = database.Column(database.String)
    skills = database.Column(database.String)
    charges = database.Column(database.String)
    language = database.Column(database.String)
    experience = database.Column(database.String)
    imageUrl = database.Column(database.String)

    def __init__(self, id, name, skills, charges, language, experience, imageUrl):
        self.id = id
        self.name = name
        self.skills = skills
        self.charges = charges
        self.language = language
        self.experience = experience
        self.imageUrl = imageUrl


class Horoscope(UserMixin, auth_db.Model):

    __tablename__ = 'Horoscope'

    id = auth_db.Column(auth_db.Integer, primary_key=True, unique=True)
    name = auth_db.Column(auth_db.String, unique=True)
    date = auth_db.Column(auth_db.String)
    imageUrl = auth_db.Column(auth_db.String)
    # picture = image_attachment('UserPicture')

    def __init__(self, id, name, date, imageUrl):
        self.id = id
        self.name = name
        self.date = date
        self.imageUrl = imageUrl


class Banner(UserMixin, auth_db.Model):

    __tablename__ = 'Banner'

    id = auth_db.Column(auth_db.Integer, primary_key=True, unique=True)
    name = auth_db.Column(auth_db.String, unique=True)
    link = auth_db.Column(auth_db.String)
    imageUrl = auth_db.Column(auth_db.String)
    # picture = image_attachment('UserPicture')

    def __init__(self, id, name, link, imageUrl):
        self.id = id
        self.name = name
        self.link = link
        self.imageUrl = imageUrl


with app.app_context():
    def update_banner():
        try:
            count = 0
            for item in s3.list_objects(Bucket='zodiacsign')['Contents']:
                key = item['Key']
                key = str(key[0]) + item['Key'][1:-5]
                banner = Banner.query.filter_by(name=key).first()
                if(banner == None):
                    continue
                presigned_url = s3.generate_presigned_url('get_object',
                                                          Params={'Bucket': 'zodiacsign', 'Key': item['Key']},
                                                          ExpiresIn=3000)
                banner.imageUrl = presigned_url
                banner.link = "www.google.com"
                auth_db.session.commit()
                count = count + 1
        except Exception as e:
            pass


with app.app_context():
    def update_imageUrl():
        try:
            count = 0
            for item in s3.list_objects(Bucket='zodiacsign')['Contents']:
                key = item['Key']
                key = str(key[0]) + item['Key'][1:-5]
                horoscope = Horoscope.query.filter_by(name=key).first()
                if(horoscope == None):
                    continue
                presigned_url = s3.generate_presigned_url('get_object',
                                                          Params={'Bucket': 'zodiacsign', 'Key': item['Key']},
                                                          ExpiresIn=3000)
                horoscope.imageUrl = presigned_url
                auth_db.session.commit()
                count = count + 1
        except Exception as e:
            pass


with app.app_context():
    def astro_urls():
        try:
            count = 0
            print(count)
            for item in s3.list_objects(Bucket='zodiacsign')['Contents']:
                key = item['Key']
                key = str(key[0]) + item['Key'][1:-5]
                print(key)
                astrologer = Astrologer.query.filter_by(name=key).first()
                print(astrologer)
                if astrologer == None:
                    continue
                presigned_url = s3.generate_presigned_url('get_object',
                                                          Params={'Bucket': 'zodiacsign', 'Key': item['Key']},
                                                          ExpiresIn=3000)
                astrologer.imageUrl = presigned_url
                database.session.commit()
                count = count + 1
                print(presigned_url)
        except Exception as e:
            pass


@app.route('/dashboard/banners', methods=['GET'])
def banners():
    with app.app_context():
        d = []
        update_banner()
        for id in range(0, 3):
            temp = {}
            banner_temp = Banner.query.filter_by(id=id).first()
            name = banner_temp.name
            link = banner_temp.link
            imageUrl = banner_temp.imageUrl
            temp["id"] = id
            temp["name"] = name
            temp["imageUrl"] = imageUrl
            temp["link"] = link
            print(imageUrl)
            d.append(temp)
        response = jsonify({"output": d})
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add("Access-Control-Allow-Credentials", "true")
        return response


@app.route('/dashboard/astrologers', methods=['GET'])
def astrologers():
    with app.app_context():
        d = []
        astro_urls()
        for id in range(0, 5):
            temp = {}
            astrologers_temp = Astrologer.query.filter_by(id=id).first()
            name = astrologers_temp.name
            skills = astrologers_temp.skills
            charges = astrologers_temp.charges
            language = astrologers_temp.language
            experience = astrologers_temp.experience
            imageUrl = astrologers_temp.imageUrl
            temp["id"] = id
            temp["name"] = name
            temp["imageUrl"] = imageUrl
            temp["experience"] = experience
            temp["language"] = language
            temp["charges"] = charges
            temp["skills"] = skills
            print(imageUrl)
            d.append(temp)
        response = jsonify({"output": d})
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add("Access-Control-Allow-Credentials", "true")
        return response

@app.route('/dashboard/zodiac', methods=['GET'])
def horoscope():
    with app.app_context():
        d = []
        update_imageUrl()
        for id in range(0, 12):
            temp = {}
            horoscope_temp = Horoscope.query.filter_by(id=id).first()
            name = horoscope_temp.name
            date = horoscope_temp.date
            imageUrl = horoscope_temp.imageUrl
            temp["id"] = id
            temp["name"] = name
            temp["imageUrl"] = imageUrl
            print(imageUrl)
            # b = BytesIO()
            # temp["imageUrl"] = base64.b64encode(b.read()).decode('ascii')
            temp["date"] = date
            d.append(temp)
        response = jsonify({"output": d})
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add("Access-Control-Allow-Credentials", "true")
        return response


class Images(image_db.Model):
    id = image_db.Column(image_db.Integer, primary_key=True)
    type = image_db.Column(image_db.String, unique=True)
    name = image_db.Column(image_db.String, unique=True)
    image_url = image_db.Column(image_db.String)


class User(UserMixin, auth_db.Model):
    id = auth_db.Column(auth_db.Integer, primary_key=True)
    username = auth_db.Column(auth_db.String, unique=True)
    email = auth_db.Column(auth_db.String, unique=True)
    password = auth_db.Column(auth_db.String)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class LoginForm(FlaskForm):
    username = StringField('username', validators=[InputRequired()])
    password = PasswordField('password', validators=[InputRequired()])
    remember = BooleanField('remember me')


class RegisterForm(FlaskForm):
    email = StringField('email', validators=[InputRequired(), Email(message='Invalid email')])
    username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
    password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])


@app.route('/login', methods=['GET', 'POST'])
def login():
    print("here")
    if request.method == "POST":
        login_details = request.data
        login_details = json.loads(login_details.decode('utf-8'))
        email = login_details['email']
        password = login_details['password']
        user = User.query.filter_by(email=email).first()
        if user:
            if check_password_hash(user.password, password):
                print("Hurray")
                return jsonify({"response": "dashboard"})
            return jsonify({"response": "Incorrect Password"})
        return jsonify({"response": "Incorrect Email"})
    else:
        return jsonify({"response": "Incorrect Request"})


if __name__ == '__main__':
    app.run(debug=True)
