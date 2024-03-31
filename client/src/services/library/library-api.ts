import axios from "axios";
import { Favorite, History } from "./library-helpers";
axios.defaults.withCredentials = true;

export const getRecentlyHeardSongs = (userId: number) => {
  return axios.get(`/history/recently-heard-songs/${userId}`);
};

export const setRecentlyHeardSongs = (history: History) => {
  return axios.post(`/history/create-heard-song`, history);
};

export const getFavoriteSongs = (userId: number) => {
  return axios.get(`/all/${userId}`);
};
export const setFavoriteSongs = (favorite: Favorite) => {
  return axios.post(`/add`, favorite);
};
export const deleteFavoriteSongs = (userId: number, songId: number) => {
  return axios.delete(`/delete?userId=${userId}&songId=${songId}`);
};

export const updateSongView = (songId: number) => {
  return axios.get(`/song/update-view/${songId}`);
};
