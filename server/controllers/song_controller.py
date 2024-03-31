from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from models.song_model import SongModel
from models.album_model import AlbumModel
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

    def rank_song_by_views(db: Session):
        # Retrieve songs ranked by views in descending order
        ranked_songs = (
            db.query(
                SongModel.id,
                SongModel.album_id,
                SongModel.playlist_id,
                SongModel.title,
                SongModel.artist,
                SongModel.audio_file_path,
                SongModel.image_file_path,
                SongModel.release_date,
                SongModel.views,
            )
            .order_by(SongModel.views.desc())
            .limit(100)
            .all()
        )

        result = []

        # Iterate through ranked songs and create a dictionary for each
        for song in ranked_songs:
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

    def get_newest_songs(db: Session):
        try:
            # Query to get 10 newest songs
            newest_songs = (
                db.query(SongModel)
                .order_by(SongModel.release_date.desc())
                .limit(12)
                .all()
            )
            songs_list = []
            for song in newest_songs:
                # Convert objects to a list of dictionaries
                song_data = {
                    'id': song.id,
                    'title': song.title,
                    'artist': song.artist,
                    'audio_file_path': song.audio_file_path,
                    'image_file_path': song.image_file_path,
                    'album_id': song.album_id,
                    'playlist_id': song.playlist_id,
                    'release_date': song.release_date,
                    'views': song.views
                }
                songs_list.append(song_data)

            return {'newest_songs': songs_list}

        except Exception as e:
            # Handle exceptions appropriately
            raise HTTPException(status_code=500, detail=str(e))
