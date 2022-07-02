from datetime import datetime
from typing import Optional

from pydantic import BaseModel, EmailStr, HttpUrl


class Image(BaseModel):
    id: int
    url: HttpUrl
    is_deleted: bool

    class Config:
        orm_mode = True


class User(BaseModel):
    id: str
    first_name: str
    last_name: str
    email: EmailStr
    gender: Optional[str] = ""
    age: Optional[str] = ""
    phone_number: Optional[str] = ""
    job_title: Optional[str] = ""
    user_level_id: int
    created_at: datetime
    updated_at: datetime

    image: Optional[Image]


# requests

# create
class UserCreate(BaseModel):
    first_name: str
    last_name: str
    email: EmailStr
    password: str
    phone_number: Optional[str]
    gender: Optional[str]
    job_title: Optional[str]


class AdminCreate(UserCreate):
    pass


class DoctorCreate(UserCreate):
    pass


class PatientCreate(UserCreate):
    pass


class CreateCheckup(BaseModel):
    description: str
    doctor_id: int
    patient_id: int


class CreateDrug(BaseModel):
    drug_name: str


class CreateRay(BaseModel):
    name: str


class CreateDiagnose(BaseModel):
    diagnose_name: str


class CreateCheckupDrugs(BaseModel):
    quantity: str
    times_per_day: int
    checkup_id: int
    drug_id: int


class CreateCheckupDiagnose(BaseModel):
    checkup_id: int
    diagnose_id: int


# update
class UserUpdate(BaseModel):
    first_name: str
    last_name: str
    phone_number: str
    job_title: str
    gender: str
    age: str


class AdminUpdate(UserUpdate):
    pass


class DoctorUpdate(UserUpdate):
    pass


class PatientUpdate(UserUpdate):
    pass


class CheckupUpdate(BaseModel):
    description: str
    patient_id: Optional[int]


class UpdateDrug(BaseModel):
    drug_name: str


class UpdateRays(BaseModel):
    name: str


class UpdateDiagnose(BaseModel):
    diagnose_name: str


# responses
class UserResponse(User):
    class Config:
        orm_mode = True


class AdminResponse(User):
    class Config:
        orm_mode = True


class UserLevel(BaseModel):
    user_level_id: int
    user_level: str

    class Config:
        orm_mode = True


class GetAdmins(BaseModel):
    User: AdminResponse
    UserLevel: UserLevel

    class Config:
        orm_mode = True


class DoctorResponse(UserResponse):
    pass


class PatientResponse(UserResponse):
    pass


# class Token(BaseModel):
#     access_token: str
#     token_type: str


class LoginResponse(BaseModel):
    access_token: str
    token_type: str
    user: UserResponse


class CheckupResponse(BaseModel):
    id: int
    description: str
    created_at: datetime
    updated_at: datetime
    doctor: DoctorResponse
    patient: PatientResponse

    class Config:
        orm_mode = True


class DrugResponse(BaseModel):
    id: int
    drug_name: str

    class Config:
        orm_mode = True


class RaysResponse(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True


class DiagnoseResponse(BaseModel):
    id: int
    diagnose_name: str

    class Config:
        orm_mode = True


class CheckupAnalysisAndRaysResponse(BaseModel):
    id: int
    checkup_id: int
    analysis_id: int

    image: Image
    checkup: CheckupResponse
    analysis: RaysResponse

    class Config:
        orm_mode = True


class CheckupDrugsResponse(BaseModel):
    id: int
    quantity: int
    times_per_day: int
    checkup: CheckupResponse
    drug: DrugResponse

    class Config:
        orm_mode = True


class CheckupDiagnoseResponse(BaseModel):
    id: int

    checkup_id: int
    diagnose_id: int

    checkup: CheckupResponse
    diagnose: DiagnoseResponse

    class Config:
        orm_mode = True


# token schemas

class TokenData(BaseModel):
    id: Optional[str] = None
