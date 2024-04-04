import json
from fastapi import APIRouter, Depends, Response, HTTPException
from datetime import datetime
from models.genre_model import GenreModel
from models.playlist_model import PlaylistModel
from models.album_model import AlbumModel
from models.song_model import SongModel
from schemas.album_schema import AlbumCreate
from schemas.playlist_schema import PlaylistCreate
from schemas.genre_schema import GenreCreate
from schemas.song_schema import SongCreate
from controllers.playlist_controller import PlaylistController
from controllers.genre_controller import GenreController
from controllers.album_controller import AlbumController
from controllers.song_controller import SongController
from sqlalchemy.orm import Session
from database import get_database

router = APIRouter(
    tags=["Data"],
    prefix="/data",
    responses={404: {"description": "Not found"}},
)


@router.get("/")
async def save_data(db: Session = Depends(get_database)):
    try:
        file_path = "data/playlists.json"
        with open(file_path, "r", encoding="utf8") as file:
            data = json.load(file)
        for item in data:
            playlist = PlaylistCreate(
                name=item.get("name"),
                code=item.get("code"),
                image_file_path=item.get("image_file_path"),
            )
            PlaylistController.create_playlist(playlist=playlist, db=db)

        file_path = "data/genres.json"
        with open(file_path, "r", encoding="utf8") as file:
            data = json.load(file)
        for item in data:
            genre = GenreCreate(
                name=item.get("name"),
                code=item.get("id"),
            )
            GenreController.create_genre(genre=genre, db=db)

        file_path = "data/songs.json"
        with open(file_path, "r", encoding="utf8") as file:
            data = json.load(file)
        for item in data:
            date_object = datetime.strptime(
                item.get("album").get("release_date"), "%d/%m/%Y"
            )
            formatted_date = date_object.strftime("%Y-%m-%dT%H:%M:%S")

            for genre in item.get("album").get("genre"):
                db_genre = db.query(GenreModel).filter(
                    GenreModel.code == genre).first()
                if db_genre:
                    album = AlbumCreate(
                        title=item.get("album").get("title"),
                        code=item.get("album").get("code"),
                        image_file_path=item.get(
                            "album").get("image_file_path"),
                        release_date=formatted_date,
                        artist=item.get("album").get("artist"),
                        genre_id=db_genre.id,
                    )
                    album = AlbumController.create_album(album=album, db=db)
                    break

            for playlist in item.get("playlist_id"):
                db_playlist = (
                    db.query(PlaylistModel)
                    .filter(PlaylistModel.code == playlist)
                    .first()
                )
                if db_playlist:
                    song = SongCreate(
                        code=item.get("code"),
                        title=item.get("title"),
                        artist=item.get("artist"),
                        audio_file_path=item.get("audio_file_path"),
                        image_file_path=item.get("image_file_path"),
                        album_id=album.id,
                        playlist_id=db_playlist.id,
                        release_date=item.get("release_date"),
                        views=0,
                    )
                    SongController.create_song(song=song, db=db)
                    break

        return {"msg": "Data saved successfully"}

    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error saving data: {str(e)}")
