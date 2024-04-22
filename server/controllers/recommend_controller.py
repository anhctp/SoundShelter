import datetime
from sqlalchemy.orm import Session

from models.user_model import UserModel
from models.song_model import SongModel
from models.like_model import LikeModel
from models.comment_model import CommentModel
from models.history_model import HistoryModel
from models.album_model import AlbumModel
from models.score_model import ScoreModel

MAX_SCORE = 100
GENRE_RATIO = 0.3
ARTIST_RATIO = 0.3
MOST_VIEWED_RATIO = 0.4


class RecommendController:
    def create_recommendation(user_id: int, db: Session):
        most_viewed_songs = db.query(SongModel).order_by(SongModel.views.desc()).limit(10).all()
        for song in most_viewed_songs:
            score = ScoreModel(
                user_id=user_id,
                song_id=song.id,
                score=MAX_SCORE * MOST_VIEWED_RATIO
            )
            db.add(score)
            db.commit() 
            db.refresh(score)
        return most_viewed_songs
    def update_recommendation(user_id: int, db: Session):
        recently_heard_songs = (
            db.query(SongModel)
            .join(HistoryModel, HistoryModel.song_id == SongModel.id)
            .filter(HistoryModel.user_id == user_id)
            .order_by(HistoryModel.play_date.desc())
            .limit(10)
            .all()
        )

        genre_ids = set()
        artists = set()
        for song in recently_heard_songs:
            album = db.query(AlbumModel).filter(AlbumModel.id == song.album_id).first()
            genre_ids.add(album.genre_id)
            artists.add(song.artist)

        # print("genre", genre_ids)
        # print("artist", artists)

        similar_genre_songs = db.query(SongModel).join(AlbumModel, AlbumModel.id == SongModel.album_id).filter(AlbumModel.genre_id.in_(genre_ids)).all()
        similar_artist_songs = db.query(SongModel).filter(SongModel.artist.in_(artists)).all()
        for song in similar_genre_songs:
            if song in similar_artist_songs:
                score_value = MAX_SCORE * (GENRE_RATIO + ARTIST_RATIO)
            else:
                score_value = MAX_SCORE * GENRE_RATIO
            score = db.query(ScoreModel).filter(ScoreModel.user_id == user_id, ScoreModel.song_id == song.id).first()
            if score is None:
                score = ScoreModel(
                    user_id=user_id,
                    song_id=song.id,
                    score=score_value
                )
                db.add(score)
                db.commit()
                db.refresh(score)
            else:
                score.score = score_value
                db.commit()
                db.refresh(score)
        for song in set(similar_artist_songs) - set(similar_genre_songs):
            score_value = MAX_SCORE * ARTIST_RATIO
            score = db.query(ScoreModel).filter(ScoreModel.user_id == user_id, ScoreModel.song_id == song.id).first()
            if score is None:
                score = ScoreModel(
                    user_id=user_id,
                    song_id=song.id,
                    score=score_value
                )
                db.add(score)
                db.commit()
                db.refresh(score)
            else:
                score.score = score_value
                db.commit()
                db.refresh(score)

    def get_recommendation(user_id: int, db: Session):
        top_10_score = db.query(ScoreModel).filter(ScoreModel.user_id == user_id).order_by(ScoreModel.score.desc()).limit(10).all()
        recommended_songs = []
        for score in top_10_score:
            song = db.query(SongModel).filter(SongModel.id == score.song_id).first()
            recommended_songs.append(song)
        return recommended_songs