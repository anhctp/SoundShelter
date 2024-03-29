from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, aliased
from database import get_database
from schemas.history_schema import HistoryCreate
from controllers.history_controller import HistoryController

router = APIRouter(
    tags=["History"],
    prefix="/history",
    responses={404: {"description": "Not found"}},
)


@router.post("/create-heard-song")
def create_heard_song(history: HistoryCreate, db: Session = Depends(get_database)):
    return HistoryController.create_history(history=history, db=db)


@router.get("/recently-heard-songs/{user_id}")
def get_recently_heard_songs_by_user(user_id: int, db: Session = Depends(get_database)):
    return HistoryController.get_recently_heard_songs(user_id=user_id, db=db)
