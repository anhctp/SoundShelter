from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_database
from controllers.favorite_controller import FavoriteController
from controllers.authentication import verify_token
from schemas.favorite_schema import FavoriteCreate
from models.user_model import UserModel

router = APIRouter(
    tags=["Favorite"],
    responses={404: {"description": "Not found"}},
)


@router.post("/add")
def create_favorite(favorite: FavoriteCreate, db: Session = Depends(get_database)):
    return FavoriteController.create_favorite(favorite=favorite, db=db)


@router.get("/all")
def get_all_favorites_by_user_id(current_user: UserModel = Depends(verify_token), db: Session = Depends(get_database)):
    return FavoriteController.get_all_favorites_by_user_id(user_id=current_user.id, db=db)


@router.delete("/delete/{song_id}")
def delete_favorite(song_id: int, current_user: UserModel = Depends(verify_token), db: Session = Depends(get_database)):
    return FavoriteController.remove_favorite_song(
        user_id=current_user.id, song_id=song_id, db=db
    )
