import os
from dotenv import load_dotenv
import boto3
from botocore.client import Config
from fastapi import APIRouter, Depends, Response, UploadFile
from sqlalchemy.orm import Session
from dataplane import s3_upload
from dataplane import s3_download

from models.user_model import UserModel
from models.song_model import SongModel

load_dotenv()

# 1. Account ID
AccountID = os.environ["secret_dp_S3_ACCOUNT_ID"]

# 2. Bucket name
Bucket = os.environ["secret_dp_BUCKET_NAME"]

# 3. Client access key
ClientAccessKey = os.environ["secret_dp_S3_ACCESS_KEY"]

# 4. Client secret
ClientSecret = os.environ["secret_dp_S3_SECRET"]

# 5. Connection url
ConnectionUrl = f"https://{AccountID}.r2.cloudflarestorage.com"

S3Connect = boto3.client(
    's3',
    endpoint_url=ConnectionUrl,
    aws_access_key_id=ClientAccessKey,
    aws_secret_access_key=ClientSecret,
    config=Config(signature_version='s3v4'),
    region_name='us-east-1'
)


class UploadController:
    def upload_song(mp3_file: UploadFile, image_file: UploadFile, title: str, db: Session, current_user: UserModel):
        folder_name = f"{current_user.id}_{
            current_user.name}/{mp3_file.filename.split('.')[0]}"
        if title is None:
            title = mp3_file.filename.split('.')[0]
        # Upload mp3 file
        mp3_data = mp3_file.file.read()
        rs = s3_upload(Bucket=Bucket,
                       S3Client=S3Connect,
                       TargetFilePath=f"{folder_name}/{mp3_file.filename}",
                       UploadObject=mp3_data,
                       UploadMethod="Object"
                       )
        # print(rs)
        # Upload image file
        if image_file is not None:
            image_data = image_file.file.read()
            rs = s3_upload(Bucket=Bucket,
                           S3Client=S3Connect,
                           TargetFilePath=f"{
                               folder_name}/{image_file.filename}",
                           UploadObject=image_data,
                           UploadMethod="Object"
                           )
        # print(rs)
            db_upload = SongModel(
                title=title,
                audio_file_path=f"/{folder_name}/{mp3_file.filename}",
                image_file_path=f"{folder_name}/{image_file.filename}",
                is_uploaded=True,
                user_id=current_user.id
            )
        else:
            db_upload = SongModel(
                title=title,
                audio_file_path=f"/{folder_name}/{mp3_file.filename}",
                is_uploaded=True,
                user_id=current_user.id
            )
        db.add(db_upload)
        db.commit()
        db.refresh(db_upload)
        return {"msg": "Uploaded"}

    def get_uploaded_song(user_id: int, db: Session):
        upload_song = db.query(SongModel).filter(
            SongModel.user_id == user_id).all()
        # rs = s3_download(Bucket=Bucket,
        # S3Client=S3Connect,
        # S3FilePath=upload_song.audio_file_path,
        # DownloadMethod="Object"
        # )
        # print(f"{ConnectionUrl}/{upload_song.audio_file_path}")
        return upload_song
