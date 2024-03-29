from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.song_controller import SongController
from schemas.song_schema import SongCreate
from models.song_model import SongModel

router = APIRouter(
    tags=["Songs"],
    prefix="/song",
    responses={404: {"description": "Not found"}},
)


@router.post("/create")
def create_song(song: SongCreate, db: Session = Depends(get_database)):
    return SongController.create_song(song=song, db=db)


@router.get("/all")
def get_all_song(db: Session = Depends(get_database)):
    return SongController.get_all_song(db=db)


@router.get("/find")
def find_song_by_name(name: str, db: Session = Depends(get_database)):
    return SongController.get_song_by_name(name=name, db=db)


@router.get("/{song_id}")
def get_song_by_id(song_id: int, db: Session = Depends(get_database)):
    return SongController.get_song_by_id(song_id=song_id, db=db)


@router.get("/update-view/{song_id}")
def update_song(song_id: int, db: Session = Depends(get_database)):
    return SongController.update_view_song(song_id=song_id, db=db)
