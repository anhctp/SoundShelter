from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import Base, engine
from routes import user_route, genre_route, album_route, playlist_route, song_route, history_route, favorite_route, recommend_route, data_route, upload_route


Base.metadata.create_all(bind=engine)
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*", "sentry-trace", "baggage"],
)
app.include_router(user_route.router, prefix="/api")
app.include_router(genre_route.router, prefix="/api")
app.include_router(album_route.router, prefix="/api")
app.include_router(playlist_route.router, prefix="/api")
app.include_router(song_route.router, prefix="/api")
app.include_router(history_route.router, prefix="/api")
app.include_router(favorite_route.router, prefix="/api")
app.include_router(recommend_route.router, prefix="/api")
app.include_router(data_route.router, prefix="/api")
app.include_router(upload_route.router, prefix="/api")
