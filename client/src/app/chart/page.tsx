"use client";
import { IconHeart, IconPlay1 } from "@/assets/icons";
// import { getRankSongs } from "@/services/chart/chartApi";
import { SongChart } from "@/services/chart/chart-helpers";
// import { Song } from "@/services/discovery/discoveryHelpers";
// import {
//   setFavoriteSongs,
//   setRecentlyHeardSongs,
//   updateSongView,
// } from "@/services/library/libraryApi";
// import { useSongStore } from "@/stores/songStore";
// import { useUserStore } from "@/stores/userStore";
import Image from "next/image";
import { useEffect, useState } from "react";

export default function Home() {
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);
  const [songs, setSongs] = useState<SongChart[]>([]);
  //   const { setSong } = useSongStore();
  //   const { userID } = useUserStore();

  //   const getSongs = async () => {
  //     const res = await getRankSongs();
  //     setSongs(res.data);
  //   };

  //   const handlePlaySong = async (song: Song) => {
  //     const currentDate = new Date();
  //     const formattedDate = currentDate.toISOString();
  //     if (userID) {
  //       await setRecentlyHeardSongs({
  //         play_date: formattedDate,
  //         user_id: userID,
  //         song_id: song.id,
  //       });
  //     } else {
  //       await updateSongView(song.id);
  //     }
  //     setSong(song);
  //   };
  //   const handleFavoriteSong = async (songId: number) => {
  //     if (userID) await setFavoriteSongs({ song_id: songId, user_id: userID });
  //   };
  //   useEffect(() => {
  //     getSongs();
  //   }, []);
  return (
    <div className="w-full h-[calc(100%_-_84px)] overflow-auto p-10">
      <div className="w-full flex items-center gap-3 mb-8 capitalize text-4xl font-bold">
        Bảng xếp hạng
        <div className="cursor-pointer">
          <IconPlay1 />
        </div>
      </div>
      {songs.map((item, index) => (
        <button
          key={index}
          onMouseEnter={() => setHoveredButton(item.id)}
          onMouseLeave={() => setHoveredButton(null)}
          className="w-full flex items-center text-left p-2.5 text-xs font-light gap-4 rounded focus:bg-primary hover:bg-primary border-b "
        >
          <div className="flex items-center gap-10 w-1/2 mr-2.5">
            <div
              className={`font-black text-4xl ${
                index + 1 === 1
                  ? "text-red-500"
                  : index + 1 === 2
                  ? "text-lime-500"
                  : index + 1 === 3
                  ? "text-cyan-500"
                  : "text-white"
              }`}
            >
              {index + 1}
            </div>
            <div className="flex items-center gap-5 max-w-3xlcursor-default">
              <Image
                src={item.image_file_path}
                width={60}
                height={60}
                alt="Image"
                className={`rounded-lg w-[60px] h-[60px] ${
                  hoveredButton === item.id && "opacity-50"
                }`}
              />
              <div className="text-xs tracking-tight">
                <div className="font-bold">{item.title}</div>
                <div className="font-light opacity-50">{item.artist}</div>
              </div>
              {hoveredButton === item.id && (
                <div
                  className="px-4 cursor-pointer"
                  //   onClick={() => handlePlaySong(item)}
                >
                  <IconPlay1 />
                </div>
              )}
            </div>
          </div>
          <div className={`w-1/2 opacity-50`}>{item.albums_title}</div>
          <div className="flex justify-end items-center mr-0 opacity-50 px-12">
            {hoveredButton === item.id ? (
              <div
                className="cursor-pointer"
                // onClick={() => handleFavoriteSong(item.id)}
              >
                <IconHeart />
              </div>
            ) : (
              <div className="w-6"></div>
            )}
          </div>
        </button>
      ))}
    </div>
  );
}
