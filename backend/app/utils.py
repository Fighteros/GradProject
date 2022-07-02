from fastapi import HTTPException, status
from passlib.context import CryptContext

from app.schemas import User

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_pass(password: str):
    return pwd_context.hash(password)


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def is_admin(user: User):
    if user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    return user.user_level_id == 1


def is_doctor(user: User):
    if user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    return user.user_level_id == 2


def is_patient(user: User):
    if user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    return user.user_level_id == 3


def is_current_user(id1, id2):
    return id1 == id2
