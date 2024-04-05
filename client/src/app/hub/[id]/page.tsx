"use client";
import { IconGoRight, IconPlay } from "@/assets/icons";
import { getListAlbumsByGenre } from "@/services/discovery/discovery-api";
import { Album } from "@/services/discovery/discovery-helpers";
import Image from "next/image";
import { useEffect, useState } from "react";
import { useParams } from "next/navigation";
import { Genre } from "@/services/hub/hub-helpers";
import { getGenreById } from "@/services/hub/hub-api";
import Link from "next/link";

export default function Home() {
  const params = useParams();
  const id = params.id;
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);
  const [albums, setAlbums] = useState<Album[]>([]);
  const [genre, setGenre] = useState<Genre>();

  const getAlbums = async () => {
    if (id) {
      const res = await getListAlbumsByGenre(+id);
      setAlbums(res.data);
    }
  };

  const getGenre = async () => {
    if (id) {
      const res = await getGenreById(+id);
      setGenre(res.data);
    }
  };

  useEffect(() => {
    getGenre();
    getAlbums();
  }, []);
  return (
    <div className="h-[calc(100%_-_84px)] overflow-auto">
      {genre && <div className="p-4 text-xl text-header">{genre.name}</div>}
      <div className="flex flex-wrap justify-center items-center px-4 gap-5">
        {albums.map((item, index) => (
          <div
            onMouseEnter={() => setHoveredButton(item.id)}
            onMouseLeave={() => setHoveredButton(null)}
            key={item.id}
            className="flex flex-col justify-center items-center p-2 gap-5 max-w-3xl rounded cursor-default"
            style={{ width: "20%" }}
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
            <div className="text-xs font-bold tracking-tight opacity-50 text-center">
              {item.title}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
