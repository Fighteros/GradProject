from typing import List

from fastapi import APIRouter, Depends, HTTPException, status, Response
from sqlalchemy.orm import Session

from app import models
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import DrugResponse, CreateDrug, UpdateDrug
from app.utils import is_admin

router = APIRouter(
    prefix='/api/v1',
    tags=['Drugs']
)


@router.get('/drugs/', response_model=List[DrugResponse])
def get_drugs(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    drugs = db.query(models.Drugs).all()
    if not drugs:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no drugs")
    return drugs


@router.get('/drugs/{id}', response_model=DrugResponse)
def get_drug(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    drug = db.query(models.Drugs).filter(models.Drugs.id == id)
    if not drug.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no drug with this id {id}")

    return drug.first()


@router.post('/drugs/', response_model=DrugResponse, status_code=status.HTTP_201_CREATED)
def create_drug(drug: CreateDrug, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    drug_exists = db.query(models.Drugs).filter(models.Drugs.drug_name == drug.drug_name)
    if drug_exists.first() is not None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="drug with this name already exists")
    new_drug = models.Drugs(**drug.dict())
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        try:
            db.add(new_drug)
            db.commit()
            db.refresh(new_drug)
        except Exception as e:
            print(e)
            raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="could not create a new drug")

    return new_drug


@router.delete('/drugs/{id}', )
def delete_drug(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    drug = db.query(models.Drugs).filter(models.Drugs.id == id)
    if not drug.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no drug with this id {id}")

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        drug.delete()
        db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.put('/drugs/{id}', response_model=DrugResponse)
def update_drug(id: int, drug: UpdateDrug, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    drug_update = db.query(models.Drugs).filter(models.Drugs.id == id)
    if not drug_update.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no drug with this id {id}")

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
        drug_update.update(drug.dict())
        db.commit()

    return drug_update.first()
