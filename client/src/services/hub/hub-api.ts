import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getAllGenre = () => {
  return axios.get("/genre/all");
};
export const getGenreById = (genreId: number) => {
  return axios.get(`/genre/${genreId}`);
};