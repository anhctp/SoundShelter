from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from models.song_model import SongModel
from schemas.song_schema import SongCreate


class SongController:
    def create_song(song: SongCreate, db: Session):
        db_song = db.query(SongModel).filter(
            SongModel.code == song.code).first()
        if not db_song:
            song_data = {
                "code": song.code,
                "title": song.title,
                "artist": song.artist,
                "audio_file_path": song.audio_file_path,
                "image_file_path": song.image_file_path,
                "release_date": song.release_date,
                "views": song.views,
            }
            if song.album_id is not None:
                song_data["album_id"] = song.album_id
            if song.playlist_id is not None:
                song_data["playlist_id"] = song.playlist_id
            db_song = SongModel(**song_data)
            db.add(db_song)
            db.commit()
            db.refresh(db_song)
        return db_song

    def get_song_by_name(name: str, db: Session):
        return db.query(SongModel).filter(SongModel.title.ilike(f"%{name}%")).all()

    def get_song_by_id(song_id: int, db: Session):
        return db.query(SongModel).filter(SongModel.id == song_id).first()

    def get_all_song(db: Session):
        return db.query(SongModel).all()

    def update_view_song(song_id: int, db: Session):
        db_song = db.query(SongModel).filter(SongModel.id == song_id).first()

        if db_song is not None:
            db_song.views = db_song.views + 1
            db.commit()
            return {"msg": "Updated"}
        else:
            raise HTTPException(status_code=400, detail="Invalid views")
