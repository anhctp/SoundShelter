from sqlalchemy.orm import Session
from models.user_model import UserModel
from schemas.user_schema import Register, Login
from fastapi import Depends, HTTPException, status
from controllers.authentication import reusable_oauth2, bcrypt, create_access_token, verify, verify_token, token_blacklist
from database import get_database
from jwt import PyJWTError


class UserController:
    def get_user_by_email(email: str, db: Session = Depends(get_database)):
        return db.query(UserModel).filter(UserModel.email == email).first()

    def create_user(user: Register, db: Session = Depends(get_database)):
        db_user = UserModel(
            name=user.name,
            email=user.email,
            password=bcrypt(user.password),
        )
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        access_token = create_access_token(data={"sub": user.email})
        db_user.password = "hashed"
        return {
            "user": db_user,
            "jwtToken": access_token,
        }

    def login(
        request: Login,
        db: Session = Depends(get_database),
    ):
        user = db.query(UserModel).filter(
            UserModel.email == request.email).first()
        if not user:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail=f"Invalid Credentials"
            )
        if not verify(user.password, request.password):
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail=f"Incorrect password"
            )

        access_token = create_access_token(data={"sub": user.email})

        response = {
            "user": user,
            "jwtToken": access_token,
        }
        return response

    def logout(token: str = Depends(reusable_oauth2)):
        try:
            verify_token
            token_blacklist.add(str(token))
            return {"msg": "You have been logged out"}
        except PyJWTError:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate credentials",
                headers={"WWW-Authenticate": "Bearer"},
            )
