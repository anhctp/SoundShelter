import { mainAxiosClient } from "@/services/axios";

export const getRankSongs = () => {
  return mainAxiosClient.get("song/rank");
};
