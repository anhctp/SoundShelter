from fastapi import Depends, HTTPException
from sqlalchemy import AliasedReturnsRows, func
from sqlalchemy.orm import Session
from sqlalchemy.orm import aliased
from models.user_model import UserModel
from models.album_model import AlbumModel
from models.song_model import SongModel
from schemas.album_schema import AlbumCreate


class AlbumController:
    def create_album(album: AlbumCreate, db: Session):
        db_album = db.query(AlbumModel).filter(
            AlbumModel.code == album.code).first()
        if not db_album:
            db_album = AlbumModel(
                code=album.code,
                title=album.title,
                release_date=album.release_date,
                artist=album.artist,
                genre_id=album.genre_id,
                image_file_path=album.image_file_path,
            )
            db.add(db_album)
            db.commit()
            db.refresh(db_album)
        return db_album

    def get_album_by_id(album_id: int, db: Session):
        return db.query(AlbumModel).filter(AlbumModel.id == album_id).first()

    def get_all_album(db: Session):
        return db.query(AlbumModel).all()

    def get_all_songs_by_album_id(album_id: int, db: Session):
        album = db.query(AlbumModel).filter(AlbumModel.id == album_id).first()
        songs = db.query(SongModel).filter(
            SongModel.album_id == album_id).all()
        result = []
        for song in songs:
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

    def get_feature_albums(db: Session):
        album_alias = aliased(AlbumModel)
        top_album_subquery = (
            db.query(AlbumModel.id, func.sum(
                SongModel.views).label("total_views"))
            .join(SongModel, AlbumModel.id == SongModel.album_id)
            .group_by(AlbumModel.id)
            .order_by(func.sum(SongModel.views).desc())
            .limit(3)
            .subquery()
        )
        # Main query to get details of top 3 albums and their songs
        ranked_albums_and_songs = (
            db.query(
                AlbumModel.id,
                AlbumModel.title,
                SongModel.id.label("song_id"),
                SongModel.title.label("song_title"),
                SongModel.artist,
                SongModel.audio_file_path,
                SongModel.image_file_path,
                SongModel.release_date,
                SongModel.views,
            )
            .join(SongModel, AlbumModel.id == SongModel.album_id)
            .join(top_album_subquery, AlbumModel.id == top_album_subquery.c.id)
            .order_by(top_album_subquery.c.total_views.desc(), SongModel.views.desc())
            .all()
        )

        result = {}
        for (
            album_id,
            album_title,
            song_id,
            song_title,
            artist,
            audio_file_path,
            image_file_path,
            release_date,
            views,
        ) in ranked_albums_and_songs:
            if album_id not in result:
                result[album_id] = {
                    "album_id": album_id,
                    "album_title": album_title,
                    "total_views": 0,
                    "songs": [],
                }

            song_info = {
                "song_id": song_id,
                "song_title": song_title,
                "artist": artist,
                "audio_file_path": audio_file_path,
                "image_file_path": image_file_path,
                "release_date": release_date,
                "views": views,
            }

            result[album_id]["songs"].append(song_info)
            result[album_id]["total_views"] += views

        final_result = list(result.values())

        return final_result
