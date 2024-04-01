import { UserLogin, UserRegister } from "./user-helpers";
import { mainAxiosClient } from "@/services/axios";

export const login = (data: UserLogin) => {
  return mainAxiosClient.post("/login", data);
};
export const register = (data: UserRegister) => {
  return mainAxiosClient.post("/register", data);
};
