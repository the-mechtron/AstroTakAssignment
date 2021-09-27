from flask_login import UserMixin

from app import database


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