import useAuthStore from "@/stores/auth-store";
import { baseURL, setUpAxiosClient } from "@/utils/setupAxios";
export interface IPaginatedResponse<T> {
  total: number;
  items: T[];
}
export const mainAxiosClient = setUpAxiosClient({
  options: {
    baseURL: baseURL,
    timeout: 120000,
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
  },
  getCurrentToken: () => {
    return useAuthStore.getState().token;
  },
  logout: () => {
    // only happen when token is expired, usually when user access the web after a long time
    // no need to reset queries' with logout.tsx
    if (useAuthStore.getState().logout()) {
      console.log("Logout!");
    }
  },
});
