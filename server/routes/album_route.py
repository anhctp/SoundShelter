from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.album_controller import AlbumController
from schemas.album_schema import AlbumCreate
from models.album_model import AlbumModel
from models.genre_model import GenreModel


router = APIRouter(
    tags=["Albums"],
    prefix="/album",
    responses={404: {"description": "Not found"}},
)


@router.post("/create")
def create_album(album: AlbumCreate, db: Session = Depends(get_database)):
    return AlbumController.create_album(album=album, db=db)


@router.get("/all")
def get_all_album(db: Session = Depends(get_database)):
    return AlbumController.get_all_album(db=db)


@router.get("/feature-albums")
def get_feature_albums(db: Session = Depends(get_database)):
    return AlbumController.get_feature_albums(db=db)


@router.get("/{album_id}")
def get_album_by_id(album_id: int, db: Session = Depends(get_database)):
    return AlbumController.get_album_by_id(album_id=album_id, db=db)


@router.get("/{album_id}/songs")
def get_songs_by_album_id(album_id: int, db: Session = Depends(get_database)):
    return AlbumController.get_all_songs_by_album_id(album_id=album_id, db=db)
