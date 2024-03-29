"use client";
import { IconGoRight, IconPlay } from "@/assets/icons";
import { getListAlbumsByGenre } from "@/services/discovery/discovery-api";
import { Album, Playlist } from "@/services/discovery/discovery-helpers";
import { getAllGenre } from "@/services/hub/hub-api";
import { Genre } from "@/services/hub/hub-helpers";
import { getAllPlaylist } from "@/services/playlist/playlist-api";
import Image from "next/image";
import Link from "next/link";
import { useEffect, useState } from "react";

export default function Home() {
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);
  const [genresWithAlbums, setGenresWithAlbums] = useState<
    { genre: Genre; album: Album[] }[]
  >([]);
  const [genre, setGenre] = useState<Genre[]>([]);
  const [playlist, setPlaylist] = useState<Playlist[]>([]);

  const getPlaylists = async () => {
    const res = await getAllPlaylist();
    setPlaylist(res.data);
  };
  const getGenres = async () => {
    const res = await getAllGenre();
    setGenre(res.data);
  };
  useEffect(() => {
    getGenres();
    getPlaylists();
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
      <div className="w-full">
        <Image
          src={
            "https://photo-zmp3.zmdcdn.me/cover/c/9/b/3/c9b3c456eeabd9d4e3241666397d71aa.jpg"
          }
          width={600}
          height={200}
          alt="Image"
          className="w-full"
        />
      </div>
      {genresWithAlbums.map(({ genre, album }, index) => (
        <div key={index} className="mt-[48px]">
          <div className="flex justify-between p-4  text-xl">
            <div className="text-header">{genre.name}</div>
            <Link
              href={`/hub/${genre.id}`}
              className="flex items-center text-header text-primary-100 cursor-pointer hover:text-secondary"
            >
              Xem thêm
              <IconGoRight />
            </Link>
          </div>
          <div className="flex justify-center items-center px-4 gap-5">
            {album.map((item, index) => (
              <div
                onMouseEnter={() => setHoveredButton(item.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
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
      <div className="mt-[48px]">
        <div className="flex justify-between p-4  text-xl">
          <div className="text-header">Playlist</div>
          <Link
            href={`/playlist`}
            className="flex items-center text-header text-primary-100 cursor-pointer hover:text-secondary"
          >
            Xem thêm
            <IconGoRight />
          </Link>
        </div>
        <div className="flex justify-center items-center px-4 gap-5">
          {playlist.slice(0, 6).map((item, index) => (
            <div
              onMouseEnter={() => setHoveredButton(item.id)}
              onMouseLeave={() => setHoveredButton(null)}
              key={index}
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
                {item.name}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
