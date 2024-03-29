from fastapi import Depends
from sqlalchemy.orm import Session
from models.playlist_model import PlaylistModel
from models.song_model import SongModel
from models.album_model import AlbumModel
from schemas.playlist_schema import PlaylistCreate


class PlaylistController:
    def create_playlist(playlist: PlaylistCreate, db: Session):
        db_playlist = (
            db.query(PlaylistModel).filter(
                PlaylistModel.code == playlist.code).first()
        )
        if not db_playlist:
            playlist_data = {
                "code": playlist.code,
                "name": playlist.name,
                "image_file_path": playlist.image_file_path,
            }
            if playlist.user_id is not None:
                playlist_data["user_id"] = playlist.user_id

            db_playlist = PlaylistModel(**playlist_data)
            db.add(db_playlist)
            db.commit()
            db.refresh(db_playlist)

        return db_playlist

    def get_playlist_by_id(playlist_id: int, db: Session):
        return db.query(PlaylistModel).filter(PlaylistModel.id == playlist_id).first()

    def get_all_playlists(db: Session):
        return db.query(PlaylistModel).all()

    def get_songs_by_playlist_id(playlist_id: int, db: Session):
        songs = db.query(SongModel).filter(
            SongModel.playlist_id == playlist_id).all()
        result = []
        for song in songs:
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
