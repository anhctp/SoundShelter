import { User } from "@/services/user/user-helpers";
import { create } from "zustand";

interface UserState {
  user: User | null;
  userID: number | null;
  setUser: (user: User) => void;
  removeUser: () => void;
}

export const useUserStore = create<UserState>((set) => ({
  user: null,
  userID: null,
  setUser: (user) => {
    set(() => ({ user }));
    if (user?.id) {
      set(() => ({ userID: user.id }));
    }
  },
  removeUser: () => set({ user: null, userID: null }),
}));
