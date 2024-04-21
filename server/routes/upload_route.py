from fastapi import APIRouter, Depends, Response, UploadFile
from sqlalchemy.orm import Session
from database import get_database
from controllers.user_controller import UserController
from controllers.authentication import verify_token
from schemas.user_schema import Register, Login
from models.user_model import UserModel
from controllers.uploadController import UploadController

router = APIRouter(
    tags=["Upload"],
    responses={404: {"description": "Not found"}},
)

@router.post("/upload_song")
def upload_song(mp3_file: UploadFile, image_file: UploadFile = None, title: str = None, db: Session = Depends(get_database), current_user: UserModel = Depends(verify_token)):
    return UploadController.upload_song(mp3_file=mp3_file, image_file=image_file, title=title, db=db, current_user=current_user)

@router.get("/get_uploaded_song")
def get_uploaded_song(user_id: int, db: Session = Depends(get_database)):
    return UploadController.get_uploaded_song(user_id=user_id, db=db)
