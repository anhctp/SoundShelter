from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from models.user_model import UserModel
from models.history_model import HistoryModel
from models.song_model import SongModel
from models.album_model import AlbumModel
from schemas.history_schema import HistoryCreate


class HistoryController:
    def create_history(history: HistoryCreate, db: Session):
        db_song = db.query(SongModel).filter(
            SongModel.id == history.song_id).first()
        if db_song is not None:
            db_song.views = db_song.views + 1
        new_history = HistoryModel(
            user_id=history.user_id,
            song_id=history.song_id,
            play_date=history.play_date,
        )
        db.add(new_history)
        db.commit()
        db.refresh(new_history)
        return new_history

    def get_history_by_id(history_id: int, db: Session):
        return db.query(HistoryModel).filter(HistoryModel.id == history_id).first()

    def get_recently_heard_songs(user_id: int, db: Session):
        recently_heard_songs = (
            db.query(SongModel)
            .join(HistoryModel, HistoryModel.song_id == SongModel.id)
            .filter(HistoryModel.user_id == user_id)
            .order_by(HistoryModel.play_date.desc())
            .limit(10)
            .all()
        )
        if not recently_heard_songs:
            raise HTTPException(
                status_code=404, detail="No recently heard songs found for the user!"
            )

        result = []

        for song in recently_heard_songs:
            album = db.query(AlbumModel).filter(
                AlbumModel.id == song.album_id).first()
            song_info = {
                "id": song.id,
                "album_id": song.album_id,
                "playlist_id": song.playlist_id,
                "title": song.title,
                "artist": song.artist,
                "audio_file_path": song.audio_file_path,
                "image_file_path": song.image_file_path,
                "release_date": song.release_date,
                "views": song.views,
                "albums_title": album.title,
            }
            result.append(song_info)

        return result
