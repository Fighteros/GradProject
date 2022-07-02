from typing import List

from fastapi import APIRouter, Depends, HTTPException, status, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.schemas import DiagnoseResponse, CreateDiagnose, UpdateDiagnose

router = APIRouter(
    prefix='/api/v1',
    tags=['Diagnoses']
)


@router.get('/diagnoses/', response_model=List[DiagnoseResponse])
def get_diagnoses(db: Session = Depends(get_db)):
    diagnoses = db.query(models.Diagnose).all()
    if not diagnoses:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no diagnoses")
    return diagnoses


@router.get('/diagnoses/{id}', response_model=DiagnoseResponse)
def get_diagnose(id: int, db: Session = Depends(get_db)):
    diagnose = db.query(models.Diagnose).filter(models.Diagnose.id == id)
    if not diagnose.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there is no diagnose with this id {id}")

    return diagnose.first()


@router.post('/diagnoses/', response_model=DiagnoseResponse, status_code=status.HTTP_201_CREATED)
def create_diagnose(diagnose: CreateDiagnose, db: Session = Depends(get_db)):
    diagnose_exists = db.query(models.Diagnose).filter(models.Diagnose.diagnose_name == diagnose.diagnose_name)

    new_diagnose = models.Diagnose(**diagnose.dict())
    if diagnose_exists.first():
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail=f"a diagnose with this name {diagnose.diagnose_name} already exists")
    try:
        db.add(new_diagnose)
        db.commit()
        db.refresh(new_diagnose)
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="could not create a diagnose")

    return new_diagnose


@router.delete('/diagnoses/{id}')
def delete_diagnose(id: int, db: Session = Depends(get_db)):
    diagnose = db.query(models.Diagnose).filter(models.Diagnose.id == id)
    if not diagnose.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there is no diagnose with this id {id}")

    diagnose.delete()
    db.commit()

    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.put("/diagnoses/{id}", response_model=DiagnoseResponse)
def update_diagnose(id: int, diagnose: UpdateDiagnose, db: Session = Depends(get_db)):
    diagnose_query = db.query(models.Diagnose).filter(models.Diagnose.id == id)
    if not diagnose_query.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there is no diagnose with this id {id}")

    diagnose_query.update(diagnose.dict())
    db.commit()

    return diagnose_query.first()
