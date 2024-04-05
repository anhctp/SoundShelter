"use client";
import { IconGoRight, IconPlay } from "@/assets/icons";
import {
  getListAlbumsByGenre,
  getNewestSongs,
} from "@/services/discovery/discovery-api";
import { Album, Playlist, Song } from "@/services/discovery/discovery-helpers";
import { getAllGenre } from "@/services/hub/hub-api";
import { Genre } from "@/services/hub/hub-helpers";
import useAuthStore from "@/stores/auth-store";
import { useUserStore } from "@/stores/user-store";
import Image from "next/image";
import { useEffect, useState } from "react";
import Link from "next/link";
import { useSongStore } from "@/stores/song-store";
import { getAllPlaylist } from "@/services/playlist/playlist-api";
import {
  getRecentlyHeardSongs,
  setRecentlyHeardSongs,
  updateSongView,
} from "@/services/library/library-api";

export default function Home() {
  const { authorized } = useAuthStore();
  const { userID } = useUserStore();
  const { setSong } = useSongStore();
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);
  const [newestSongs, setNewestSongs] = useState<Song[]>([]);
  const [playlist, setPlaylist] = useState<Playlist[]>([]);
  const [genresWithAlbums, setGenresWithAlbums] = useState<
    { genre: Genre; album: Album[] }[]
  >([]);

  const [genre, setGenre] = useState<Genre[]>([]);
  const [recentlySongs, setRecentlySongs] = useState<Song[]>([]);

  const getRecentlySongs = async () => {
    const res = await getRecentlyHeardSongs(userID!);
    setRecentlySongs(res.data);
  };
  const getGenres = async () => {
    const res = await getAllGenre();
    setGenre(res.data);
  };

  const getPlaylists = async () => {
    const res = await getAllPlaylist();
    setPlaylist(res.data);
  };

  const getSongs = async () => {
    const res = await getNewestSongs();
    setNewestSongs(res.data.newest_songs);
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

  useEffect(() => {
    getGenres();
    getPlaylists();
    getSongs();
    authorized && getRecentlySongs();
  }, []);

  useEffect(() => {
    const fetchAlbums = async () => {
      const genresWithAlbumsData: { genre: Genre; album: Album[] }[] = [];

      for (const genreItem of genre) {
        try {
          const response = await getListAlbumsByGenre(genreItem.id);
          const albumsData = response.data.slice(0, 6);

          if (albumsData.length > 0) {
            genresWithAlbumsData.push({
              genre: genreItem,
              album: albumsData,
            });
          }
        } catch (error) {
          console.error(
            `Error fetching albums for genre ${genreItem.id}: ${error}`
          );
        }
      }

      setGenresWithAlbums(genresWithAlbumsData);
    };

    fetchAlbums();
  }, [genre]);
  return (
    <div className="h-[calc(100%_-_84px)] overflow-auto">
      <div className="p-4 flex w-full justify-between">
        {playlist.slice(0, 3).map((item, index) => (
          <Link
            key={item.id}
            href={`/playlist/${item.id}`}
            className="w-80 transition-transform duration-500 cursor-pointer hover:scale-110"
          >
            <Image
              src={item.image_file_path}
              alt={`carousel-item-${item.id}`}
              priority
              width={400}
              height={100}
            />
          </Link>
        ))}
      </div>
      {authorized && (
        <div className="mt-[48px]">
          <div className="flex justify-between p-4  text-xl">
            <div className="text-header">Gần đây</div>
            <Link
              href={"/library/history"}
              className="flex items-center text-header text-primary-100 cursor-pointer hover:text-secondary"
            >
              Xem thêm
              <IconGoRight />
            </Link>
          </div>
          <div className="flex justify-center items-center px-4 gap-5">
            <div className="w-1/2 flex flex-col gap-4">
              {recentlySongs.slice(0, 4).map((song, index) => (
                <div
                  onMouseEnter={() => setHoveredButton(song.id)}
                  onMouseLeave={() => setHoveredButton(null)}
                  key={song.id}
                  className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                  style={{ position: "relative" }}
                >
                  <Image
                    src={song.image_file_path}
                    width={60}
                    height={60}
                    alt="Image"
                    className={`rounded-lg w-[60px] h-[60px] ${
                      hoveredButton === song.id && "opacity-50"
                    }`}
                  />
                  <div className="text-xs tracking-tight">
                    <div className="font-bold">{song.title}</div>
                    <div className="font-light opacity-50">{song.artist}</div>
                    <div className="font-light opacity-50">
                      {song.release_date}
                    </div>
                  </div>
                  {hoveredButton === song.id && (
                    <div
                      className="absolute px-4 cursor-pointer"
                      onClick={() => handlePlaySong(song)}
                    >
                      <IconPlay />
                    </div>
                  )}
                </div>
              ))}
            </div>
            <div className="w-1/2 flex flex-col gap-4">
              {recentlySongs.slice(4, 8).map((song, index) => (
                <div
                  onMouseEnter={() => setHoveredButton(song.id)}
                  onMouseLeave={() => setHoveredButton(null)}
                  key={song.id}
                  className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                  style={{ position: "relative" }}
                >
                  <Image
                    src={song.image_file_path}
                    width={60}
                    height={60}
                    alt="Image"
                    className={`rounded-lg w-[60px] h-[60px] ${
                      hoveredButton === song.id && "opacity-50"
                    }`}
                  />
                  <div className="text-xs tracking-tight">
                    <div className="font-bold">{song.title}</div>
                    <div className="font-light opacity-50">{song.artist}</div>
                    <div className="font-light opacity-50">
                      {song.release_date}
                    </div>
                  </div>
                  {hoveredButton === song.id && (
                    <div
                      className="absolute px-4 cursor-pointer"
                      onClick={() => handlePlaySong(song)}
                    >
                      <IconPlay />
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
      <div className="mt-[48px]">
        <div className="flex justify-between p-4  text-xl">
          <div className="text-header">Mới phát hành</div>
          <Link
            href={"/new-release"}
            className="flex items-center text-header text-primary-100 cursor-pointer hover:text-secondary"
          >
            Xem thêm
            <IconGoRight />
          </Link>
        </div>
        <div className="flex justify-center items-center px-4 gap-5">
          <div className="w-1/2 flex flex-col gap-4">
            {newestSongs.slice(0, 4).map((song, index) => (
              <div
                onMouseEnter={() => setHoveredButton(song.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={song.id}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={song.image_file_path}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === song.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{song.title}</div>
                  <div className="font-light opacity-50">{song.artist}</div>
                  <div className="font-light opacity-50">
                    {song.release_date}
                  </div>
                </div>
                {hoveredButton === song.id && (
                  <div
                    className="absolute px-4 cursor-pointer"
                    onClick={() => handlePlaySong(song)}
                  >
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className="w-1/2 flex flex-col gap-4">
            {newestSongs.slice(4, 8).map((song, index) => (
              <div
                onMouseEnter={() => setHoveredButton(song.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={song.id}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={song.image_file_path}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === song.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{song.title}</div>
                  <div className="font-light opacity-50">{song.artist}</div>
                  <div className="font-light opacity-50">
                    {song.release_date}
                  </div>
                </div>
                {hoveredButton === song.id && (
                  <div
                    className="absolute px-4 cursor-pointer"
                    onClick={() => handlePlaySong(song)}
                  >
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      </div>
      {genresWithAlbums.map(({ genre, album }, index) => (
        <div key={genre.id} className="mt-[48px]">
          <div className="flex justify-between p-4  text-xl">
            <div className="text-header">{genre.name}</div>
            <Link
              href={`/hub/${genre.id}`}
              className="flex items-center text-primary-100 text-header cursor-pointer hover:text-secondary"
            >
              Xem thêm
              <IconGoRight />
            </Link>
          </div>
          <div className="flex justify-center items-center px-4 gap-5">
            {album.map((item, albumIndex) => (
              <div
                onMouseEnter={() => setHoveredButton(item.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={item.id}
                className="flex flex-col justify-center items-center p-2 gap-5 max-w-3xl rounded cursor-default"
                style={{ position: "relative" }}
              >
                <div className="flex flex-col justify-center items-center hover:scale-110 transition-transform duration-300">
                  <Image
                    src={item.image_file_path}
                    width={100}
                    height={100}
                    alt="Image"
                    className={`rounded w-[181px] h-[181px] ${
                      hoveredButton === item.id && "opacity-50"
                    }`}
                  />
                  {hoveredButton === item.id && (
                    <Link
                      href={`/album/${item.id}`}
                      className="absolute px-4 cursor-pointer"
                    >
                      <IconPlay />
                    </Link>
                  )}
                </div>
                <div className="text-xs font-bold tracking-tight opacity-50">
                  {item.title}
                </div>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}
