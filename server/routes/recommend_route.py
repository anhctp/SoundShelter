from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.playlist_controller import PlaylistController
from schemas.playlist_schema import PlaylistCreate
from models.playlist_model import PlaylistModel
from controllers.recommend_controller import RecommendController

router = APIRouter(
    tags=["Recommends"],
    prefix="/recommend",
    responses={404: {"description": "Not found"}},
)


@router.get("/get_recommendation/{user_id}")
def get_recommendation(user_id, db: Session = Depends(get_database)):
    return RecommendController.get_recommendation(user_id=user_id, db=db)

