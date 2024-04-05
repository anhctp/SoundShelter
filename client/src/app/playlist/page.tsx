"use client";
import { IconPlay } from "@/assets/icons";
import { Playlist } from "@/services/discovery/discovery-helpers";
import Image from "next/image";
import { useEffect, useState } from "react";
import Link from "next/link";
import { getAllPlaylist } from "@/services/playlist/playlist-api";

export default function Home() {
  const [hoveredButton, setHoveredButton] = useState<number | null>(null);
  const [playlist, setPlaylist] = useState<Playlist[]>([]);

  const getPlaylists = async () => {
    const res = await getAllPlaylist();
    setPlaylist(res.data);
  };
  useEffect(() => {
    getPlaylists();
  }, []);
  return (
    <div className="h-[calc(100%_-_84px)] overflow-auto">
      <div className="flex flex-wrap justify-center items-center px-4 gap-5">
        {playlist.map((item, index) => (
          <div
            onMouseEnter={() => setHoveredButton(item.id)}
            onMouseLeave={() => setHoveredButton(null)}
            key={item.id}
            className="flex flex-col justify-center items-center text-center p-2 gap-5 max-w-3xl rounded cursor-default"
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
                  href={`/playlist/${item.id}`}
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
  );
}
