from flask_login import UserMixin

from app import database


class Horoscope(UserMixin, database.Model):

    __tablename__ = 'Horoscope'

    id = database.Column(database.Integer, primary_key=True, unique=True)
    name = database.Column(database.String, unique=True)
    date = database.Column(database.String)
    imageUrl = database.Column(database.String)

    def __init__(self, id, name, date, imageUrl):
        self.id = id
        self.name = name
        self.date = date
        self.imageUrl = imageUrl

    def update_imageUrl(self):
        try:
            count = 0
            for item in s3.list_objects(Bucket='zodiacsign')['Contents']:
                print(item['Key'])
                print(Horoscope.query.filter_by(id=0))
                horoscope = Horoscope.query.filter_by(id=count).first()

                presigned_url = s3.generate_presigned_url('get_object',
                                                          Params={'Bucket': 'zodiacsign', 'Key': item['Key']},
                                                          ExpiresIn=100)
                horoscope.imageUrl = presigned_url
                database.session.commit()
                count = count + 1
                print(presigned_url)
        except Exception as e:
            pass



