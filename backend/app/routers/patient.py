from typing import List, Optional

from fastapi import APIRouter, Depends, status, HTTPException, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import PatientUpdate, PatientResponse, PatientCreate
from app.utils import hash_pass, is_admin, is_doctor, is_current_user

router = APIRouter(
    prefix="/api/v1",
    tags=['Patients'],
)


# patients
@router.get('/patients/', response_model=List[PatientResponse])
def get_patients(db: Session = Depends(get_db), current_user=Depends(get_current_user), limit: int = 10, skip: int = 0,
                 search: Optional[str] = ""):
    users = db.query(models.User).filter(models.User.user_level_id == 3, models.User.first_name.contains(search)).limit(
        limit).offset(skip).all()
    if not users:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='there are no patients')
    return users


# noinspection PyNoneFunctionAssignment
@router.get('/patients/{id}', response_model=PatientResponse)
def get_patient(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    patient = db.query(models.User).filter(models.User.id == id, models.User.user_level_id == 3)
    if not patient.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no patient with this id {id}')
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    # else:
    #     if (not is_current_user(patient.first().id, current_user.id)) and (not is_admin(current_user)):
    #         raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
    #                             detail='Not authorized to perform the request action')

    return patient.first()


@router.post('/patients/', status_code=status.HTTP_201_CREATED, response_model=PatientResponse)
def create_patient(patient: PatientCreate, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if (not is_admin(current_user)) and (not is_doctor(current_user)):
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not authorized to perform the request action')
    hashed_password = hash_pass(patient.password)
    patient.password = hashed_password
    new_patient = models.User(user_level_id=3, **patient.dict())
    try:
        db.add(new_patient)
        db.commit()
        db.refresh(new_patient)
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='Couldn\'t create patient with that email')
    return new_patient


# noinspection PyNoneFunctionAssignment
@router.delete('/patients/{id}', status_code=status.HTTP_204_NO_CONTENT)
def delete_patient(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    patient = db.query(models.User).filter(models.User.id == id)
    if patient.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no patient with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if (not is_current_user(patient.first().id, current_user.id)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        patient.delete()
        db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# noinspection PyNoneFunctionAssignment
@router.put('/patients/{id}', response_model=PatientResponse)
def update_patient(id: int, patient: PatientUpdate, db: Session = Depends(get_db),
                   current_user=Depends(get_current_user)):
    patient_query = db.query(models.User).filter(models.User.id == id)
    if patient_query.first() is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f'there\'s no patient with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')

    else:
        if (not is_current_user(patient_query.first().id, current_user.id)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        patient_query.update(patient.dict(exclude_unset=True))
        db.commit()
    return patient_query.first()

# try
