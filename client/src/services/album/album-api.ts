import { mainAxiosClient } from "@/services/axios";
const ALBUM_URL = "album";

export const getAllAlbums = () => {
  return mainAxiosClient.get(`/${ALBUM_URL}/all`);
};
export const getAlbumById = (albumId: number) => {
  return mainAxiosClient.get(`/${ALBUM_URL}/${albumId}`);
};
export const getSongsByAlbumId = (albumId: number) => {
  return mainAxiosClient.get(`/${ALBUM_URL}/${albumId}/songs`);
};
