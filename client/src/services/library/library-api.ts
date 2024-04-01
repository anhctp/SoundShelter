import { Favorite, History } from "./library-helpers";
import { mainAxiosClient } from "@/services/axios";

export const getRecentlyHeardSongs = (userId: number) => {
  return mainAxiosClient.get(`/history/recently-heard-songs/${userId}`);
};

export const setRecentlyHeardSongs = (history: History) => {
  return mainAxiosClient.post(`/history/create-heard-song`, history);
};

export const getFavoriteSongs = (userId: number) => {
  return mainAxiosClient.get(`/all/${userId}`);
};
export const setFavoriteSongs = (favorite: Favorite) => {
  return mainAxiosClient.post(`/add`, favorite);
};
export const deleteFavoriteSongs = (userId: number, songId: number) => {
  return mainAxiosClient.delete(`/delete?userId=${userId}&songId=${songId}`);
};

export const updateSongView = (songId: number) => {
  return mainAxiosClient.get(`/song/update-view/${songId}`);
};
