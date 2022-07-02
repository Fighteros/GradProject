from typing import List

from fastapi import APIRouter, Depends, HTTPException, status, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import CreateCheckup, CheckupResponse, CheckupUpdate, CreateCheckupDrugs, CheckupDrugsResponse, \
    CheckupDiagnoseResponse, CreateCheckupDiagnose
from app.utils import is_admin, is_doctor

router = APIRouter(
    prefix='/api/v1',
    tags=['Checkups']
)


# noinspection PyNoneFunctionAssignment
@router.get('/checkups/admin', response_model=List[CheckupResponse])
def get_checkups_admin(db: Session = Depends(get_db), current_user=Depends(get_current_user), ):
    checkups = db.query(models.Checkup).all()
    if not checkups:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no checkups")

    return checkups


# noinspection PyNoneFunctionAssignment
@router.get('/checkups/doctor', response_model=List[CheckupResponse])
def get_checkups_doctor(db: Session = Depends(get_db), current_user=Depends(get_current_user), ):
    checkups = db.query(models.Checkup).filter(models.Checkup.doctor_id == current_user.id).all()
    if not checkups:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no checkups")

    return checkups


@router.get('/checkups/patient', response_model=List[CheckupResponse])
def get_checkups_doctor(db: Session = Depends(get_db), current_user=Depends(get_current_user), ):
    checkups = db.query(models.Checkup).filter(models.Checkup.patient_id == current_user.id).all()
    if not checkups:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no checkups")

    return checkups


# noinspection PyNoneFunctionAssignment
@router.get('/checkups/{id}', response_model=CheckupResponse)
def get_checkup(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    checkup = db.query(models.Checkup).filter(models.Checkup.id == id)
    if not checkup.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no checkup with id {id}")

    return checkup.first()


# noinspection PyNoneFunctionAssignment
@router.post('/checkups/', status_code=status.HTTP_201_CREATED, response_model=CheckupResponse)
def create_checkup(checkup: CreateCheckup, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if (not is_admin(current_user)) and (not is_doctor(current_user)):
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not authorized to perform the request action')

    doctor_exists = db.query(models.User).filter(models.User.id == checkup.doctor_id,
                                                 models.User.user_level_id == 2)
    patient_exists = db.query(models.User).filter(models.User.id == checkup.patient_id,
                                                  models.User.user_level_id == 3)

    if doctor_exists.first() is None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail=f'a doctor with this id {checkup.doctor_id} doesn\'t exists')

    if patient_exists.first() is None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail=f'a patient with this id {checkup.patient_id} doesn\'t exists')
    new_checkup = models.Checkup(**checkup.dict())
    try:
        db.add(new_checkup)
        db.commit()
        db.refresh(new_checkup)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='could not create a checkup')
    return new_checkup


# checkup_drugs
@router.get('/checkups/drugs/', response_model=List[CheckupDrugsResponse])
def get_checkup_drugs(db: Session = Depends(get_db),
                      current_user=Depends(get_current_user)):
    checkup_drugs = db.query(models.CheckupDrugs).all()
    if checkup_drugs is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no checkup_drugs")

    return checkup_drugs


@router.get('/checkups/drugs/{id}', response_model=CheckupDrugsResponse)
def get_checkup_drug_by_id(id: int, db: Session = Depends(get_db),
                           current_user=Depends(get_current_user)):
    checkup_drug = db.query(models.CheckupDrugs).filter(models.CheckupDrugs.checkup_id == id).first()

    if checkup_drug is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there is no checkup_drug with id {id}")

    return checkup_drug


@router.post('/checkups/drugs/', status_code=status.HTTP_201_CREATED, response_model=CheckupDrugsResponse)
def create_checkup_drugs(checkup_drugs: CreateCheckupDrugs, db: Session = Depends(get_db),
                         current_user=Depends(get_current_user)):
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if (not is_doctor(current_user)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        checkup_exists = db.query(models.Checkup).filter(models.Checkup.id == checkup_drugs.checkup_id).first()
        drug_exists = db.query(models.Drugs).filter(models.Drugs.id == checkup_drugs.drug_id).first()

        if checkup_exists is None:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f'a checkup with this id {checkup_drugs.checkup_id} doesn\'t exists')
        if drug_exists is None:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f'a drug with this id {checkup_drugs.drug_id} doesn\'t exists')

        new_checkup_drug = models.CheckupDrugs(**checkup_drugs.dict())
        try:
            db.add(new_checkup_drug)
            db.commit()
            db.refresh(new_checkup_drug)
        except Exception as e:
            print(e)
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='could not create a checkup drug')
    return new_checkup_drug


# check diagnoses

@router.get('/checkups/diagnoses/', response_model=List[CheckupDiagnoseResponse])
def get_check_diagnoses(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    diagnoses = db.query(models.CheckupDiagnoses).all()

    if not diagnoses:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail='there are no checkup diagnoses')

    return diagnoses


@router.get('/checkups/diagnoses/{id}', response_model=CheckupDiagnoseResponse)
def get_check_diagnoses(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    diagnose = db.query(models.CheckupDiagnoses).filter(models.CheckupDiagnoses.checkup_id == id).first()

    if not diagnose:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'there is no checkup diagnose with this id {id}')

    return diagnose


@router.post('/checkups/diagnoses/', response_model=CheckupDiagnoseResponse)
def create_checkup_diagnose(checkup_diagnose: CreateCheckupDiagnose, db: Session = Depends(get_db),
                            current_user=Depends(get_current_user)):
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        # noinspection DuplicatedCode
        if (not is_doctor(current_user)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        checkup_exists = db.query(models.Checkup).filter(models.Checkup.id == checkup_diagnose.checkup_id).first()
        diagnose_exists = db.query(models.Diagnose).filter(models.Diagnose.id == checkup_diagnose.diagnose_id).first()

        if checkup_exists is None:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f'a checkup with this id {checkup_diagnose.checkup_id} doesn\'t exists')

        if diagnose_exists is None:
            raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                                detail=f'a diagnose with this id {checkup_diagnose.diagnose_id} doesn\'t exists')

        new_checkup_diagnose = models.CheckupDiagnoses(**checkup_diagnose.dict())

        try:

            db.add(new_checkup_diagnose)
            db.commit()
            db.refresh(new_checkup_diagnose)

        except Exception as e:
            print(e)
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='could not create a checkup diagnose')

    return new_checkup_diagnose


# noinspection PyNoneFunctionAssignment
@router.delete('/checkups/{id}')
def delete_checkup(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    checkup = db.query(models.Checkup).filter(models.Checkup.id == id)
    if not checkup.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no checkup with this id {id}")

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if (not is_doctor(current_user)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        checkup.delete()
        db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# noinspection PyNoneFunctionAssignment
@router.put('/checkups/{id}', response_model=CheckupResponse)
def update_checkup(id: int, checkup: CheckupUpdate, db: Session = Depends(get_db),
                   current_user=Depends(get_current_user)):
    checkup_query = db.query(models.Checkup).filter(models.Checkup.id == id)
    if not checkup_query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f'could not find a checkup with this id {id}')

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if (not is_doctor(current_user)) and (not is_admin(current_user)):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')

        checkup_query.update(checkup.dict(exclude_unset=True))
        db.commit()
    return checkup_query.first()
