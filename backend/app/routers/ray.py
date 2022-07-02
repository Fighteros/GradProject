import uuid
from typing import List

from azure.storage.blob import BlobServiceClient
from fastapi import APIRouter, Depends, HTTPException, status, Response, Form
from fastapi import File, UploadFile
from sqlalchemy.orm import Session

from app import models
from app.config import settings
from app.database import get_db
from app.oauth2 import get_current_user
from app.schemas import RaysResponse, CreateRay, UpdateRays, CheckupAnalysisAndRaysResponse
from app.utils import is_admin

router = APIRouter(
    prefix='/api/v1',
    tags=['Analysis and Rays']
)

blob_service_client = BlobServiceClient.from_connection_string(settings.azure_storage_connection_string)

container_name = "imgs"


def get_client(filename: str):
    return blob_service_client.get_blob_client(container=container_name, blob=filename)


# @router.post('/rays/upload')
# def upload_result(file: UploadFile = File(...)):
#     new_file_name = str(uuid.uuid4()) + file.filename
#     db = get_client(new_file_name)
#     db.upload_blob(file.file)
#     return {'url': db.url}


# rays

@router.post('/rays/upload', response_model=CheckupAnalysisAndRaysResponse)
def upload_result(checkup_id: int = Form(...), analysis_id: int = Form(...), img: UploadFile = File(...),
                  db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    checkup_exists = db.query(models.Checkup).filter(models.Checkup.id == checkup_id).first()
    analysis_exists = db.query(models.AnalysisAndRays).filter(models.AnalysisAndRays.id == analysis_id).first()

    if checkup_exists is None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail=f'a checkup with this id {checkup_id} doesn\'t exists')
    if analysis_exists is None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail=f'an Analysis and rays object with this id {analysis_id} doesn\'t exists')

    # upload img to blob storage
    new_img_name = str(uuid.uuid4()) + img.filename
    blob_storage = get_client(new_img_name)
    blob_storage.upload_blob(img.file)
    img_url = blob_storage.url

    new_img = models.Image(url=img_url)
    db.add(new_img)
    db.commit()
    db.refresh(new_img)

    checkup_analysis = models.CheckupAnalysisAndRays(checkup_id=checkup_id, analysis_id=analysis_id, img_url=new_img.id)
    try:

        db.add(checkup_analysis)
        db.commit()
        db.refresh(checkup_analysis)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail='Couldn\'t create doctor with that email')

    return checkup_analysis


@router.get('/rays/results/', response_model=List[CheckupAnalysisAndRaysResponse])
def get_results(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    results = db.query(models.CheckupAnalysisAndRays).all()
    if not results:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no results")

    return results


@router.get('/rays/results/{id}', response_model=CheckupAnalysisAndRaysResponse)
def get_results_by_checkup_id(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    results = db.query(models.CheckupAnalysisAndRays).filter(models.CheckupAnalysisAndRays.checkup_id == id).first()
    if not results:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there is no result with id {id}")

    return results


@router.get('/rays/', response_model=List[RaysResponse])
def get_analysis_and_rays(db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    rays = db.query(models.AnalysisAndRays).all()
    if not rays:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="there are no analysis and rays objects")
    return rays


@router.get('/rays/{id}', response_model=RaysResponse)
def get_analysis_and_rays_by_id(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    ray = db.query(models.AnalysisAndRays).filter(models.AnalysisAndRays.id == id)
    if not ray.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"there's no analysis and rays with this id {id}")

    return ray.first()


# noinspection DuplicatedCode
@router.post('/rays/', response_model=RaysResponse, status_code=status.HTTP_201_CREATED)
def create_analysis_and_rays(ray: CreateRay, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
    ray_exists = db.query(models.AnalysisAndRays).filter(models.AnalysisAndRays.name == ray.name)
    if ray_exists.first() is not None:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail="analysis and rays object with this name already exists")

    new_ray = models.AnalysisAndRays(**ray.dict())
    try:
        db.add(new_ray)
        db.commit()
        db.refresh(new_ray)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=status.HTTP_409_CONFLICT,
                            detail="could not create a new analysis and ray object")

    return new_ray


@router.delete('/rays/{id}', )
def delete_analysis_and_ray(id: int, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
    ray = db.query(models.AnalysisAndRays).filter(models.AnalysisAndRays.id == id)
    if not ray.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
                            detail=f"there's no analysis and rays object with this id {id}")

    ray.delete()
    db.commit()
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@router.put('/rays/{id}', response_model=RaysResponse)
def update_drug(id: int, ray: UpdateRays, db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        if not is_admin(current_user):
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                                detail='Not authorized to perform the request action')
    ray_update = db.query(models.AnalysisAndRays).filter(models.AnalysisAndRays.id == id)
    if not ray_update.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"there's no drug with this id {id}")

    ray_update.update(ray.dict())
    db.commit()

    return ray_update.first()
