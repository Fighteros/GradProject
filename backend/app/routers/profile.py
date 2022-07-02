import uuid

from azure.storage.blob import BlobServiceClient
from fastapi import APIRouter, UploadFile, File, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app import models
from app.config import settings
from app.database import get_db
from app.oauth2 import get_current_user

from pydantic_sqlalchemy import sqlalchemy_to_pydantic

from app.schemas import UserResponse

PydanticUser = sqlalchemy_to_pydantic(models.User)

router = APIRouter(
    prefix='/api/v1/profile',
    tags=['Profile']
)

blob_service_client = BlobServiceClient.from_connection_string(settings.azure_storage_connection_string)

container_name = "profile"

"""
to delete a blob
https://stackoverflow.com/questions/58900507/upload-and-delete-azure-storage-blob-using-azure-storage-blob-or-azure-storage
"""


def get_client(filename: str):
    return blob_service_client.get_blob_client(container=container_name, blob=filename)


@router.post('/upload/', response_model=UserResponse)
def upload_img(img: UploadFile = File(...), db: Session = Depends(get_db), current_user=Depends(get_current_user)):
    # upload
    new_file_name = str(uuid.uuid4()) + img.filename
    blob_db = get_client(new_file_name)
    blob_db.upload_blob(img.file)
    img_url = blob_db.url

    new_image = models.Image(url=img_url)
    # save image to db
    db.add(new_image)
    db.commit()
    db.refresh(new_image)

    if current_user is None:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN,
                            detail='Not valid token to perform the request action')
    else:
        current_user_query = db.query(models.User).filter(models.User.id == current_user.id)
        current_user_obj = current_user_query.first()
        pydantic_user = PydanticUser.from_orm(current_user_obj).dict(exclude_unset=True)
        pydantic_user.update({'img_url': new_image.id})

        current_user_query.update(pydantic_user)
        db.commit()

    return current_user_query.first()
