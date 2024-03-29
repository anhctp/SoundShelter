from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import user_route
from database import Base, engine

Base.metadata.create_all(bind=engine)
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000/"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*", "sentry-trace", "baggage"],
)
app.include_router(user_route.router, prefix="/api/v1")
