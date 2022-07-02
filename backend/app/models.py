from sqlalchemy import Column, Integer, String, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.sql.expression import text
from sqlalchemy.sql.sqltypes import TIMESTAMP

from .database import Base


class Image(Base):
    __tablename__ = 'images'

    id = Column(Integer, nullable=False, primary_key=True)
    url = Column(String, nullable=True, default='')
    is_deleted = Column(Boolean, nullable=True, default=False)


class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, nullable=False, primary_key=True)
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    email = Column(String, nullable=False, unique=True)
    password = Column(String, nullable=False)
    phone_number = Column(String, nullable=True, default='')
    age = Column(String, nullable=True, default='')
    job_title = Column(String, nullable=True, default='')
    gender = Column(String, nullable=True, default='')
    img_url = Column(Integer, ForeignKey('images.id'), nullable=True, default='1')
    # account_id = Column(Integer, ForeignKey('accounts.account_id', ondelete='CASCADE'), nullable=False, )
    user_level_id = Column(Integer, ForeignKey('userlevels.user_level_id'), nullable=False)
    created_at = Column(TIMESTAMP(timezone=True), nullable=False, server_default=text('NOW()'))
    updated_at = Column(TIMESTAMP(timezone=True), server_default=text('NOW()'), onupdate=text('NOW()'))

    user_level_name = relationship("UserLevel", foreign_keys=[user_level_id])
    image = relationship("Image", foreign_keys=[img_url])





class UserLevel(Base):
    __tablename__ = 'userlevels'

    user_level_id = Column(Integer, nullable=False, primary_key=True)
    user_level = Column(String, nullable=False)


class Drugs(Base):
    __tablename__ = 'drugs'

    id = Column(Integer, nullable=False, primary_key=True)
    drug_name = Column(String, nullable=False, unique=True)


class AnalysisAndRays(Base):
    __tablename__ = 'analysis_and_rays'

    id = Column(Integer, nullable=False, primary_key=True)
    name = Column(String, nullable=False)


class Diagnose(Base):
    __tablename__ = 'diagnoses'

    id = Column(Integer, nullable=False, primary_key=True)
    diagnose_name = Column(String, nullable=False, unique=True)


class Checkup(Base):
    __tablename__ = 'checkups'

    id = Column(Integer, nullable=False, primary_key=True)
    description = Column(String, nullable=False)

    # if the doctor is deleted we should not allow deleting the checkup
    # but if the patient is deleted it's ok to delete the checkups related to him
    doctor_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    patient_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
    created_at = Column(TIMESTAMP(timezone=True), nullable=False, server_default=text('NOW()'))
    updated_at = Column(TIMESTAMP(timezone=True), server_default=text('NOW()'), onupdate=text('NOW()'))

    doctor = relationship("User", foreign_keys=[doctor_id])
    patient = relationship("User", foreign_keys=[patient_id])


class CheckupDrugs(Base):
    __tablename__ = 'checkup_drugs'

    id = Column(Integer, nullable=False, primary_key=True)
    quantity = Column(Integer, nullable=False)
    times_per_day = Column(Integer, nullable=False)

    checkup_id = Column(Integer, ForeignKey('checkups.id', ondelete='CASCADE'), nullable=False)
    drug_id = Column(Integer, ForeignKey('drugs.id'), nullable=False)

    checkup = relationship('Checkup', foreign_keys=[checkup_id])
    drug = relationship('Drugs', foreign_keys=[drug_id])


class CheckupAnalysisAndRays(Base):
    __tablename__ = 'checkup_analysis_and_rays'

    id = Column(Integer, nullable=False, primary_key=True)
    checkup_id = Column(Integer, ForeignKey('checkups.id', ondelete='CASCADE'), nullable=False)
    analysis_id = Column(Integer, ForeignKey('analysis_and_rays.id'), nullable=False)
    img_url = Column(Integer, ForeignKey('images.id'), nullable=False)

    checkup = relationship('Checkup', foreign_keys=[checkup_id])
    analysis = relationship('AnalysisAndRays', foreign_keys=[analysis_id])
    image = relationship("Image", foreign_keys=[img_url])


class CheckupDiagnoses(Base):
    __tablename__ = 'checkup_diagnoses'

    id = Column(Integer, nullable=False, primary_key=True)
    checkup_id = Column(Integer, ForeignKey('checkups.id', ondelete='CASCADE'), nullable=False)
    diagnose_id = Column(Integer, ForeignKey('diagnoses.id'), nullable=False)

    checkup = relationship('Checkup', foreign_keys=[checkup_id])
    diagnose = relationship('Diagnose', foreign_keys=[diagnose_id])

