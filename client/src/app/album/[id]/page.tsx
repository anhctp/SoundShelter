"use client";
import Image from "next/image";
import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { Album, Song } from "@/services/discovery/discovery-helpers";
import { getAlbumById, getSongsByAlbumId } from "@/services/album/album-api";
import {
  IconHeart,
  IconPlay,
  IconPlay1,
  FunnelIcon,
  MusicalNote,
} from "@/assets/icons";
import { useSongStore } from "@/stores/song-store";
import { SongChart } from "@/services/chart/chart-helpers";
import {
  setFavoriteSongs,
  setRecentlyHeardSongs,
  updateSongView,
} from "@/services/library/library-api";
import { useUserStore } from "@/stores/user-store";

export default function Home() {
  const params = useParams();
  const id = params.id;
  const [album, setAlbum] = useState<Album>();
  const [songs, setSongs] = useState<SongChart[]>([]);
  const [hoveredButtonAlbum, setHoveredButtonAlbum] = useState<boolean>(false);
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);

  const { setSong } = useSongStore();
  const { userID } = useUserStore();
  const getAlbum = async () => {
    if (id) {
      const res = await getAlbumById(+id);
      setAlbum(res.data);
    }
  };
  const getSongs = async () => {
    const res = await getSongsByAlbumId(+id);
    setSongs(res.data);
  };
  const handlePlaySong = async (song: Song) => {
    const currentDate = new Date();
    const formattedDate = currentDate.toISOString();
    if (userID) {
      await setRecentlyHeardSongs({
        play_date: formattedDate,
        user_id: userID,
        song_id: song.id,
      });
    } else {
      await updateSongView(song.id);
    }
    setSong(song);
  };
  const handleFavoriteSong = async (songId: number) => {
    if (userID)
      await setFavoriteSongs({ song_id: songId, user_id: userID }).catch(
        (err) => console.log(err)
      );
  };
  useEffect(() => {
    getAlbum();
    getSongs();
  }, []);
  return (
    <div className="w-full flex">
      {album && (
        <div
          onMouseEnter={() => setHoveredButtonAlbum(true)}
          onMouseLeave={() => setHoveredButtonAlbum(false)}
          className="flex flex-col justify-center items-center p-2 gap-5 w-[300px] rounded cursor-default"
          style={{ position: "relative" }}
        >
          <div className="flex flex-col justify-center items-center hover:scale-110 transition-transform duration-300">
            <Image
              src={album.image_file_path}
              width={100}
              height={100}
              alt="Image"
              className={`rounded w-[181px] h-[181px] ${
                hoveredButton && "opacity-50"
              }`}
            />
            {hoveredButtonAlbum && (
              <div className="absolute px-4 cursor-pointer">
                <IconPlay />
              </div>
            )}
          </div>
          <div className="text-xs font-bold tracking-tight opacity-50">
            {album.title}
          </div>
        </div>
      )}
      <div className="w-full">
        <div className="w-full flex items-center text-left p-2.5 text-xs font-light gap-4 rounded">
          <div className="flex items-center gap-10 w-1/2 mr-2.5">
            <FunnelIcon />
            <div className="text-xs tracking-tight">BÀI HÁT</div>
          </div>
          <div className={`w-1/2 opacity-50`}>ALBUM</div>
        </div>
        {songs.map((item, index) => (
          <button
            key={item.id}
            onMouseEnter={() => setHoveredButton(item.id)}
            onMouseLeave={() => setHoveredButton(null)}
            className="w-full flex items-center text-left p-2.5 text-xs font-light gap-4 rounded focus:bg-primary hover:bg-primary "
          >
            <div className="flex items-center gap-10 w-1/2 mr-2.5">
              <MusicalNote />
              <div
                className="flex items-center gap-5 max-w-3xlcursor-default"
                style={{ position: "relative" }}
              >
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
                    className="absolute px-4 cursor-pointer"
                    onClick={() => handlePlaySong(item)}
                  >
                    <IconPlay1 />
                  </div>
                )}
              </div>
            </div>
            <div className={`w-1/2 opacity-50`}>{item.albums_title}</div>
            <div className="flex gap-5 justify-end items-center mr-0 opacity-50">
              {hoveredButton === item.id ? (
                <div
                  className="px-3 cursor-pointer"
                  onClick={() => handleFavoriteSong(item.id)}
                >
                  <IconHeart />
                </div>
              ) : (
                <div className="w-12"></div>
              )}
            </div>
          </button>
        ))}
      </div>
    </div>
  );
}
