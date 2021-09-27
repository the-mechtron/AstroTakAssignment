from flask import jsonify

from app import app
from Horoscope import Horoscope


@app.route('/dashboard/zodiac', methods=['GET'])
def horoscope():
    with app.app_context():
        d = {'output': []}
        for id in range(0, 12):
            print(id)
            temp = {}
            horoscope_temp = Horoscope.query.filter_by(id=id).first()
            name = horoscope_temp.name
            date = horoscope_temp.date
            imageUrl = horoscope_temp.imageUrl
            temp["id"] = id
            temp["name"] = name
            temp["imageUrl"] = imageUrl
            temp["date"] = date
            d['output'].append(temp)
        return jsonify(d)


# with app.app_context():
#     print((horoscope()))
# print(horoscope())
