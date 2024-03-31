from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import user_route, genre_route, album_route, playlist_route, song_route, history_route, favorite_route
from models.playlist_model import PlaylistModel
from database import Base, engine, get_database

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


@app.get("/api/data")
async def save_data(db: Session = Depends(get_database)):
    try:
        file_path = "data/playlists.json"
        with open(file_path, "r") as file:
            data = json.load(file)
        for item in data:
            playlist = PlaylistCreate(
                name=item.get("name"),
                code=item.get("code"),
                image_file_path=item.get("image_file_path"),
            )
            PlaylistController.createPlaylist(playlist=playlist, db=db)

        file_path = "data/genres.json"
        with open(file_path, "r") as file:
            data = json.load(file)
        for item in data:
            genre = GenreCreate(
                name=item.get("name"),
                code=item.get("id"),
            )
            GenreController.createGenre(genre=genre, db=db)

        file_path = "data/songs.json"
        with open(file_path, "r") as file:
            data = json.load(file)
        for item in data:
            date_object = datetime.strptime(
                item.get("album").get("release_date"), "%d/%m/%Y"
            )
            formatted_date = date_object.strftime("%Y-%m-%dT%H:%M:%S")

            for genre in item.get("album").get("genre"):
                db_genre = db.query(GenreModel).filter(
                    GenreModel.code == genre).first()
                if db_genre:
                    album = AlbumCreate(
                        title=item.get("album").get("title"),
                        code=item.get("album").get("code"),
                        image_file_path=item.get(
                            "album").get("image_file_path"),
                        release_date=formatted_date,
                        artist=item.get("album").get("artist"),
                        genre_id=db_genre.id,
                    )
                    album = AlbumController.createAlbum(album=album, db=db)
                    break

            for playlist in item.get("playlist_id"):
                db_playlist = (
                    db.query(PlaylistModel)
                    .filter(PlaylistModel.code == playlist)
                    .first()
                )
                if db_playlist:
                    song = SongCreate(
                        code=item.get("code"),
                        title=item.get("title"),
                        artist=item.get("artist"),
                        audio_file_path=item.get("audio_file_path"),
                        image_file_path=item.get("image_file_path"),
                        album_id=album.id,
                        playlist_id=db_playlist.id,
                        release_date=item.get("release_date"),
                        views=0,
                    )
                    SongController.createSong(song=song, db=db)
                    break

        return {"msg": "Data saved successfully"}

    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Error saving data: {str(e)}")
