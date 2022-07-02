from fastapi import FastAPI
from starlette.responses import RedirectResponse
from fastapi.middleware.cors import CORSMiddleware
from . import models
from .database import engine
from .routers import auth, admin, doctor, patient, checkup, drug, ray, diagnose, profile

# sqlalchemy create models
models.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="xHealth",
)


origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get('/', tags=['root'])
def get_docs():
    return RedirectResponse('/docs')


# 1
app.include_router(auth.router)
# 2
app.include_router(profile.router)
# 3
app.include_router(admin.router)
# 4
app.include_router(doctor.router)
# 5
app.include_router(patient.router)
# 6
app.include_router(checkup.router)
# 7
app.include_router(drug.router)
# 8
app.include_router(ray.router)
# 9
app.include_router(diagnose.router)
