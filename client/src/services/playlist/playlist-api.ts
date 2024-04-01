import { mainAxiosClient } from "@/services/axios";

export const getAllPlaylist = () => {
  return mainAxiosClient.get("/playlist/all");
};
export const getPlaylistById = (playlistId: number) => {
  return mainAxiosClient.get(`/playlist/${playlistId}`);
};
export const getSongsByPlaylistId = (playlistId: number) => {
  return mainAxiosClient.get(`/playlist/${playlistId}/songs`);
};
