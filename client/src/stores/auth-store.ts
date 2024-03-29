import { create } from "zustand";

interface authState {
  authorized: boolean;
  setAuthorized: (authorized: boolean) => void;
  token: string;
  setToken: (token: string) => void;
  removeToken: () => void;
  logout: () => boolean;
}

const useAuthStore = create<authState>((set) => ({
  authorized: false,
  setAuthorized: (authorized) => set(() => ({ authorized })),
  token: "",
  setToken: (token) => set(() => ({ token })),
  removeToken: () => set({ token: "" }),
  logout: () => {
    // Logout for axios
    const token = localStorage.getItem("token");
    localStorage.removeItem("token");
    set({ token: "" });
    set({ authorized: false });
    return !!token;
  },
}));

export default useAuthStore;