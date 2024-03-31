import axios from "axios";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const getRankSongs = () => {
  return axios.get("song/rank");
};
