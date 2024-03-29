import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getAllPlaylist = () => {
  return axios.get("/playlist/all");
};
export const getPlaylistById = (playlistId: number) => {
  return axios.get(`/playlist/${playlistId}`);
};
export const getSongsByPlaylistId = (playlistId: number) => {
  return axios.get(`/playlist/${playlistId}/songs`);
};
