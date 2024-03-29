import { Song } from "@/services/discovery/discovery-helpers";
import { create } from "zustand";

interface SongState {
  song: Song | null;
  songID: number | null;
  isPlaying: boolean;
  volume: number;
  songTime: number;
  setSong: (song: Song) => void;
  setIsPlaying: (isPlaying: boolean) => void;
  setVolume: (volume: number) => void;
  setSongTime: (songTime: number) => void;
  removeSong: () => void;
}

export const useSongStore = create<SongState>((set) => ({
  song: null,
  songID: null,
  isPlaying: false,
  volume: 0.5,
  songTime: 0,
  setSong: (song) => {
    set(() => ({ song }));
    set({ isPlaying: true });
    if (song?.id) {
      set(() => ({ songID: song.id }));
    }
  },
  setIsPlaying: (isPlaying) => {
    set({ isPlaying: isPlaying });
  },
  setVolume: (volume) => {
    set({ volume: volume });
  },
  setSongTime: (songTime) => {
    set({ songTime: songTime });
  },
  removeSong: () => set({ song: null, songID: null }),
}));
