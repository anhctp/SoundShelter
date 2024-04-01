import { mainAxiosClient } from "@/services/axios";
export const getNewestSongs = () => {
  return mainAxiosClient.get("/song/newest-songs");
};

export const getListAlbumsByGenre = (genreId: number) => {
  return mainAxiosClient.get(`/album/album-by-genre/${genreId}`);
};
