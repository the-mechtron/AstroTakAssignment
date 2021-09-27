import boto3
from botocore.client import Config
from app import database

from Astrologer import Astrologer


s3 = boto3.client('s3',
                    region_name = "ap-south-1",
                    # config=Config(signature_version='s3v4'),
                    aws_access_key_id='AKIA6B5NHVV3ADDZSUAR',
                    aws_secret_access_key= '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',
        )

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