import { mainAxiosClient } from "@/services/axios";
const GENRE_URL = "genre";

export const getAllGenre = () => {
  return mainAxiosClient.get(`/${GENRE_URL}/all`);
};
export const getGenreById = (genreId: number) => {
  return mainAxiosClient.get(`/${GENRE_URL}/${genreId}`);
};
