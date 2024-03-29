import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getAllAlbums = () => {
  return axios.get("/album/all");
};
export const getAlbumById = (albumId: number) => {
  return axios.get(`/album/get/${albumId}`);
};
export const getSongsByAlbumId = (albumId: number) => {
  return axios.get(`/album/${albumId}/songs`);
};
