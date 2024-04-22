import datetime
from sqlalchemy.orm import Session

from models.user_model import UserModel
from models.song_model import SongModel
from models.like_model import LikeModel
from models.comment_model import CommentModel


class InteractController:
    def like(song_id: int, current_user: UserModel, db: Session):
        song = db.query(SongModel).filter(SongModel.id == song_id).first()
        song.views += 1
        like_db = LikeModel(
            user_id=current_user.id,
            song_id=song_id,
            time=datetime.now())
        db.add(like_db)
        db.commit()
        db.refresh(like_db)
        return like_db
    
    def comment(song_id: int, current_user: UserModel, content:str, db: Session):
        song = db.query(SongModel).filter(SongModel.id == song_id).first()
        song.views += 1
        comment_db = CommentModel(
            user_id=current_user.id,
            song_id=song_id,
            content=content,
            time=datetime.now())
        db.add(comment_db)
        db.commit()
        db.refresh(comment_db)
        return comment_db
    
    def get_likes_by_song_id(song_id: int, db: Session):
        likes = db.query(LikeModel).filter(LikeModel.song_id == song_id).all()
        return len(likes)
    
    def get_cmts_by_song_id(song_id: int, db: Session):
        comments = db.query(CommentModel).filter(CommentModel.song_id == song_id).all()
        return len(comments)