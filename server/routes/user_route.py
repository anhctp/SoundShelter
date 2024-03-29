from fastapi import APIRouter, Depends, Response
from sqlalchemy.orm import Session
from database import get_database
from controllers.user_controller import UserController
from controllers.authentication import verify_token
from schemas.user_schema import Register, Login
from models.user_model import UserModel

router = APIRouter(
    tags=["Users"],
    responses={404: {"description": "Not found"}},
)


@router.post("/login")
def login(
    request: Login,
    db: Session = Depends(get_database),
):
    return UserController.login(request=request, db=db)


@router.post("/register")
def register(user: Register, db: Session = Depends(get_database)):
    return UserController.create_user(user=user, db=db)


@router.post("/logout")
def logout(response: str = Depends(UserController.logout)):
    return response


@router.get("/me")
def get_me(current_user: UserModel = Depends(verify_token)):
    return current_user
