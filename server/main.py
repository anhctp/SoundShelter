from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import Base, engine

Base.metadata.create_all(bind=engine)
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*", "sentry-trace", "baggage"],
)


@app.get("/api/ping")
def ping():
    return "pong"