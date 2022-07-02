from typing import List

import sqlalchemy
from fastapi import APIRouter, Depends, status, HTTPException, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import AdminResponse, AdminCreate, AdminUpdate
from app.utils import hash_pass, is_admin

router = APIRouter(
    prefix='/api/v1/admins',
    tags=['Admins']
)


@router.get('/', response_model=List[AdminResponse])
def get_admins(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    admins = db.query(models.User).filter(models.User.user_level_id == 1).all()
    if not admins:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='there are no admins')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
    return admins


@router.post('/', status_code=status.HTTP_201_CREATED, response_model=AdminResponse)
def create_admin(admin: AdminCreate, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    hashed_admin_pass = hash_pass(admin.password)
    admin.password = hashed_admin_pass
    new_admin = models.User(user_level_id=1, **admin.dict())
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if current_user.user_level_id != 1:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        try:
            db.add(new_admin)
            db.commit()
            db.refresh(new_admin)
        except sqlalchemy.exc.IntegrityError as e:
            # print(e)
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='Couldn\'t create admin with that email')
    return new_admin


@router.get('/{id}', response_model=AdminResponse)
def get_admin(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    admin = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 1).first()
    if admin is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no admin with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if current_user.user_level_id != 1:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')

    return admin


# noinspection PyNoneFunctionAssignment
@router.delete('/{id}', status_code=status.HTTP_204_NO_CONTENT)
def delete_admin(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    admin = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 1)

    if admin.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no admin with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')

    else:
        if current_user.user_level_id != 1:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')

    admin.delete()
    db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# noinspection PyNoneFunctionAssignment
@router.put('/{id}', response_model=AdminResponse)
def update_admin(id: int, admin: AdminUpdate, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    admin_to_update = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 1)

    if admin_to_update.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no admin with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if current_user.user_level_id != 1:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        admin_to_update.update(admin.dict())
        db.commit()
    return admin_to_update.first()
