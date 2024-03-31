import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getNewestSongs = () => {
  return axios.get("/song/newest-songs");
};

export const getListAlbumsByGenre = (genreId: number) => {
  return axios.get(`/album/album-by-genre/${genreId}`);
};
