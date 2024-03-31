import { ZingMp3 } from "zingmp3-api-full";
import fs from "fs";

const songs = [];
const genres = [];
await ZingMp3.getChartHome().then((data) => {
  const arr = data.data.RTChart.items;
  for (let i = 0; i < arr.length; i++) {
    if (arr[i].album) {
      const playlist_id = [];
      for (let j = 0; j < arr[i].artists.length; j++) {
        playlist_id.push(arr[i].artists[j].playlistId);
      }
      const item = {
        code: arr[i].encodeId,
        title: arr[i].title,
        artist: arr[i].artistsNames,
        image_file_path: arr[i].thumbnailM,
        album: {
          code: arr[i].album.encodeId,
          title: arr[i].album.title,
          release_date: arr[i].album.releaseDate,
          artist: arr[i].album.artistsNames,
          image_file_path: arr[i].album.thumbnail,
          genre: arr[i].album.genreIds,
        },
        playlist_id: playlist_id,
        release_date: arr[i].releaseDate,
      };
      songs.push(item);
    }
  }
});

const playlists = [];
const songsPlaylist = [];
for (let i = 0; i < songs.length; i++) {
  const id_playlists = songs[i].playlist_id;
  for (let j = 0; j < id_playlists.length; j++) {
    await ZingMp3.getDetailPlaylist(id_playlists[j]).then((res) => {
      if (res.data) {
        const playlist = {
          code: res.data.encodeId,
          name: res.data.title,
          image_file_path: res.data.thumbnailM,
          genreIds: res.data.genreIds,
        };
        for (let a = 0; a < res.data.genres.length; a++) {
          const isUnique = !genres.some(
            (item) => item.id === res.data.genres[a].id
          );
          if (isUnique && res.data.genres[a]) {
            genres.push(res.data.genres[a]);
          }
        }
        playlists.push(playlist);
        const arr = res.data.song.items;
        for (let i = 0; i < arr.length; i++) {
          const item = {
            code: arr[i].encodeId,
            title: arr[i].title,
            artist: arr[i].artistsNames,
            image_file_path: arr[i].thumbnailM,
            album: arr[i].album
              ? {
                  code: arr[i].album.encodeId,
                  title: arr[i].album.title,
                  release_date: arr[i].album.releaseDate,
                  artist: arr[i].album.artistsNames,
                  image_file_path: arr[i].album.thumbnail,
                  genre: arr[i].album.genreIds,
                }
              : {},
            playlist_id: id_playlists[j],
            release_date: arr[i].releaseDate,
          };
          songsPlaylist.push(item);
        }
      }
      if (i === songs.length - 1) {
        const jsonData = JSON.stringify(playlists, null, 2);
        const filePath = "playlists.json";
        fs.writeFileSync(filePath, jsonData);
        console.log(`Object has been exported to ${filePath}`);
      }
    });
  }
}

const allSongs = [...songs, ...songsPlaylist];

for (let index = 0; index < allSongs.length; index++) {
  await ZingMp3.getSong(allSongs[index].code).then((response) => {
    if (response.data) {
      const audio_file_path = response.data["128"];
      allSongs[index].audio_file_path = audio_file_path;
    }
    if (index === allSongs.length - 1) {
      const jsonData = JSON.stringify(allSongs, null, 2);
      const filePath = "songs.json";
      fs.writeFileSync(filePath, jsonData);
      console.log(`Object has been exported to ${filePath}`);
    }
  });

  await ZingMp3.getInfoSong(allSongs[index].code).then((response) => {
    if (response.data) {
      const genre = response.data.genres;
      for (let a = 0; a < genre.length; a++) {
        const isUnique = !genres.some((item) => item.id === genre[a].id);
        if (isUnique && genre[a]) {
          genres.push(genre[a]);
        }
      }
    }
    if (index === allSongs.length - 1) {
      const jsonData = JSON.stringify(genres, null, 2);
      const filePath = "genres.json";
      fs.writeFileSync(filePath, jsonData);
      console.log(`Object has been exported to ${filePath}`);
    }
  });
}
