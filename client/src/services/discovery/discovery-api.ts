import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getNewestSongs = () => {
  return axios.get("/discovery/newest-songs");
};

export const getListAlbumsByGenre = (genreId: number) => {
  return axios.get(`/discovery/albumByGenre/${genreId}`);
};