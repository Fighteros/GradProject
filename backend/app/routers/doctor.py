from typing import List

from fastapi import APIRouter, Depends, status, HTTPException, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import DoctorCreate, DoctorResponse, DoctorUpdate
from app.utils import hash_pass, is_admin, is_current_user

router = APIRouter(
    prefix="/api/v1",
    tags=['Doctors'],
)


# doctors
@router.get('/doctors/', response_model=List[DoctorResponse])
def get_doctors(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    users = db.query(models.User).filter(models.User.user_level_id == 2).all()
    if not users:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='there are no doctors')
    return users


# get single doctor
@router.get('/doctors/{id}', response_model=DoctorResponse)
def get_doctor(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    # noinspection PyNoneFunctionAssignment
    doctor = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 2)
    if not doctor.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no doctor with id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    # else:
    #     if (not is_current_user(doctor.first().id, current_user.id)) and (not is_admin(current_user)):
    #         raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
    #                             detail='Not authorized to perform the request action')
    return doctor.first()


@router.post('/doctors/', status_code=status.HTTP_201_CREATED, response_model=DoctorResponse)
def create_doctor(doctor: DoctorCreate, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if not is_admin(current_user):
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail="Not authorized to perform the request action")
    hashed_password = hash_pass(doctor.password)
    doctor.password = hashed_password
    new_doctor = models.User(user_level_id=2, **doctor.dict())
    try:
        db.add(new_doctor)
        db.commit()
        db.refresh(new_doctor)
    except Exception as e:
        # print(e)
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='Couldn\'t create doctor with that email')
    return new_doctor


# noinspection PyNoneFunctionAssignment
@router.delete('/doctors/{id}', status_code=status.HTTP_204_NO_CONTENT)
def delete_doctor(id: int, db: Session = Depends(get_db), current_user: DoctorResponse = Depends(get_current_user)):
    doctor = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 2)

    if doctor.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no doctor with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if (not is_current_user(doctor.first().id, current_user.id)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')

        doctor.delete()
        db.commit()

    return Response(status_code=status.HTTP_204_NO_CONTENT)


# noinspection PyNoneFunctionAssignment
@router.put('/doctors/{id}', response_model=DoctorResponse)
def update_doctor(id: int, doctor: DoctorUpdate, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    doctor_query = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 2)
    if doctor_query.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no doctor with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')

    else:
        if (not is_current_user(doctor_query.first().id, current_user.id)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        doctor_query.update(doctor.dict(exclude_unset=True))
        db.commit()

    return doctor_query.first()
