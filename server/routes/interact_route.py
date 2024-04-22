from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.user_controller import UserController
from controllers.authentication import verify_token
from schemas.user_schema import Register, Login
from models.user_model import UserModel
from controllers.interact_controller import InteractController

router = APIRouter(
    tags=["Interact"],
    responses={404: {"description": "Not found"}},
)

@router.post("/like/{song_id}")
def like(song_id: int, current_user: UserModel = Depends(verify_token), db: Session = Depends(get_database)):
    return InteractController.like(song_id=song_id, current_user=current_user, db=db)

@router.post("/comment/{song_id}")
def comment(content: str, song_id, current_user: UserModel = Depends(verify_token), db: Session = Depends(get_database)):
    return InteractController.comment(song_id=song_id, current_user=current_user, content=content, db=db)

@router.get("/get_likes/{song_id}")
def get_likes_by_song_id(song_id: int, db: Session = Depends(get_database)):
    return InteractController.get_likes_by_song_id(song_id=song_id, db=db)

@router.get("/get_comments/{song_id}")
def get_cmts_by_song_id(song_id: int, db: Session = Depends(get_database)):
    return InteractController.get_cmts_by_song_id(song_id=song_id, db=db)