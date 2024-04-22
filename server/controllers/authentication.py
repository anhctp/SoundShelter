import jwt
import os
from jwt import PyJWTError
from passlib.context import CryptContext
from fastapi.security import HTTPBearer
from fastapi import Depends, HTTPException, status
from sqlalchemy.orm import Session
from dotenv import load_dotenv
from database import get_database
from datetime import datetime, timedelta
import controllers.user_controller as user_controller

load_dotenv()
# token
reusable_oauth2 = HTTPBearer(scheme_name="Authorization")
token_blacklist = set()


def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(
        days=int(os.getenv("ACCESS_TOKEN_EXPIRE_DAYS"))
    )
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(
        to_encode, os.getenv("SECRET_KEY"), algorithm=os.getenv("ALGORITHM")
    )
    return encoded_jwt


def is_token_invalidated(token=Depends(reusable_oauth2)):
    if str(token) in token_blacklist:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token has been invalidated",
        )
    return True


def verify_token(db: Session = Depends(get_database), data=Depends(reusable_oauth2)):
    try:
        is_token_invalidated(token=data)
        payload = jwt.decode(
            data.credentials, os.getenv("SECRET_KEY"), algorithms=os.getenv("ALGORITHM")
        )
        email: str = payload.get("sub")
        if email is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Could not validate email",
                headers={"WWW-Authenticate": "Bearer"},
            )
        token_data = email
    except PyJWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user = user_controller.UserController.get_user_by_email(
        email=token_data, db=db)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Could not validate user",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return user


# hashing password
pwd_cxt = CryptContext(schemes=["bcrypt"], deprecated="auto")


def bcrypt(password: str):
    return pwd_cxt.hash(password)


def verify(hashed_password, plain_password):
    print(hashed_password)
    print("plain_password")
    print(plain_password)
    
    return pwd_cxt.verify(plain_password, hashed_password)
