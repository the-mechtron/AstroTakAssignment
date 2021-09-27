import boto3
from botocore.client import Config
from app import database

from Horoscope import Horoscope
import json

s3 = boto3.client('s3',
                    region_name = "ap-south-1",
                    config=Config(signature_version='s3v4'),
                    aws_access_key_id='AKIA6B5NHVV3N5XLR5YY',
                    aws_secret_access_key= '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',)





# horoscope_file = open("C:/Users/pmaro/StudioProjects/AstroTakBackend/GivenAssets/horoscope_json.json")
# horoscope_json = json.load(horoscope_file)
# print(Horoscope.query.filter_by(id=0).first())
# try:
#     count = 0
#     for item in s3.list_objects(Bucket='zodiacsign')['Contents']:
#         print(item['Key'])
#         print(Horoscope.query.filter_by(id=0))
#         horoscope = Horoscope.query.filter_by(id=count).first()
#         presigned_url = s3.generate_presigned_url('get_object', Params = {'Bucket': 'zodiacsign', 'Key': item['Key']}, ExpiresIn = 100)
#         horoscope.imageUrl = presigned_url
#         database.session.commit()
#         count = count + 1
#         print(presigned_url)
# except Exception as e:
#     pass
    # print("[INFO] : The contents inside show_image = ", public_urls)
# print(public_urls)


# count = 0
# for item in horoscope_json["data"]:
#     print(temp_image_url)
#     # horoscope = {"id": count, "name": item["name"], "date": item["date"], "imageUrl": temp_image_url + item["name"]}
#     # horoscope = Horoscope(count, item["name"], item["date"], temp_image_url + item["name"])
#     # database.session.add(horoscope)
#     horoscope = Horoscope.query.filter_by(id=count).first()
#     horoscope.imageUrl = presigned_url[name]
#     database.session.commit()
#     count = count + 1

