from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.playlist_controller import PlaylistController
from schemas.playlist_schema import PlaylistCreate
from models.playlist_model import PlaylistModel

router = APIRouter(
    tags=["Playlists"],
    prefix="/playlist",
    responses={404: {"description": "Not found"}},
)


@router.post("/create")
def create_playlist(playlist: PlaylistCreate, db: Session = Depends(get_database)):
    return PlaylistController.create_playlist(playlist=playlist, db=db)


@router.get("/all")
def get_all_playlist(db: Session = Depends(get_database)):
    return PlaylistController.get_all_playlists(db=db)


@router.get("/{playlist_id}")
def get_playlist_by_id(playlist_id: int, db: Session = Depends(get_database)):
    return PlaylistController.get_playlist_by_id(playlist_id=playlist_id, db=db)


@router.get("/{playlist_id}/songs")
def get_songs_by_playlist_id(playlist_id: int, db: Session = Depends(get_database)):
    return PlaylistController.get_songs_by_playlist_id(playlist_id=playlist_id, db=db)
