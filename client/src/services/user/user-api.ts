import axios from "axios";
import { UserLogin, UserRegister } from "./user-helpers";
axios.defaults.withCredentials = true;
axios.defaults.baseURL = "http://localhost:8000/api";

export const login = (data: UserLogin) => {
  return axios.post("/login", data);
};
export const register = (data: UserRegister) => {
  return axios.post("/register", data);
};
