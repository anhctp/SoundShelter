"use client";
import { IconGoRight, IconPlay } from "@/assets/icons";
import Image from "next/image";
import { useState } from "react";

export default function Home() {
  const [hoveredButton, setHoveredButton] = useState<string | null>(null);
  const travels = [
    {
      id: "trip1",
      title: "Alo",
      imgUrl: "/logo-no-background.png",
      artist: "Vu",
      createdAt: "50 phut",
    },
    {
      id: "trip2",
      title: "Blo",
      imgUrl: "/logo-no-background.png",
      artist: "Vu",
      createdAt: "3 ngay truoc",
    },
  ];
  const albums = [
    {
      id: "test",
      desc: "Ngày lễ hoàn hảo để tận hưởng cái ôm từ ai đó",
      imgUrl: "/logo-no-background.png",
    },
    {
      id: "test2",
      desc: "Ngày lễ hoàn hảo để tận hưởng cái ôm từ ai đó",
      imgUrl: "/logo-no-background.png",
    },
    {
      id: "test3",
      desc: "Ngày lễ hoàn hảo để tận hưởng cái ôm từ ai đó",
      imgUrl: "/logo-no-background.png",
    },
  ];
  const themes = [
    {
      id: 1,
      title: "Những ngày đông ấm áp",
    },
    {
      id: 2,
      title: "Nhạc này siêu nhiệt",
    },
  ];
  return (
    <div className="h-[calc(100%_-_84px)] overflow-auto">
      <div className="mt-[48px]">
        <div className="flex justify-between p-4  text-xl">
          <div className="text-header">Gần đây</div>
          <div className="flex items-center text-header text-primary-100 cursor-pointer hover:text-secondary">
            Xem thêm
            <IconGoRight />
          </div>
        </div>
        <div className="flex justify-center items-center px-4 gap-5">
          <div className="w-1/2 flex flex-col gap-4">
            {travels.map((trip, index) => (
              <div
                onMouseEnter={() => setHoveredButton(trip.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={trip.imgUrl}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === trip.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{trip.title}</div>
                  <div className="font-light opacity-50">{trip.artist}</div>
                  <div className="font-light opacity-50">{trip.createdAt}</div>
                </div>
                {hoveredButton === trip.id && (
                  <div className="absolute px-4 cursor-pointer">
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className="w-1/2 flex flex-col gap-4">
            {travels.map((trip, index) => (
              <div
                onMouseEnter={() => setHoveredButton(trip.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={trip.imgUrl}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === trip.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{trip.title}</div>
                  <div className="font-light opacity-50">{trip.artist}</div>
                  <div className="font-light opacity-50">{trip.createdAt}</div>
                </div>
                {hoveredButton === trip.id && (
                  <div className="absolute px-4 cursor-pointer">
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      </div>
      <div className="mt-[48px]">
        <div className="flex justify-between p-4  text-xl">
          <div className="text-header">Mới phát hành</div>
          <div className="flex items-center text-primary-100 text-header cursor-pointer hover:text-secondary">
            Xem thêm
            <IconGoRight />
          </div>
        </div>
        <div className="flex justify-center items-center px-4 gap-5">
          <div className="w-1/2 flex flex-col gap-4">
            {travels.map((trip, index) => (
              <div
                onMouseEnter={() => setHoveredButton(trip.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={trip.imgUrl}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === trip.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{trip.title}</div>
                  <div className="font-light opacity-50">{trip.artist}</div>
                  <div className="font-light opacity-50">{trip.createdAt}</div>
                </div>
                {hoveredButton === trip.id && (
                  <div className="absolute px-4 cursor-pointer">
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className="w-1/2 flex flex-col gap-4">
            {travels.map((trip, index) => (
              <div
                onMouseEnter={() => setHoveredButton(trip.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
                className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default"
                style={{ position: "relative" }}
              >
                <Image
                  src={trip.imgUrl}
                  width={60}
                  height={60}
                  alt="Image"
                  className={`rounded-lg w-[60px] h-[60px] ${
                    hoveredButton === trip.id && "opacity-50"
                  }`}
                />
                <div className="text-xs tracking-tight">
                  <div className="font-bold">{trip.title}</div>
                  <div className="font-light opacity-50">{trip.artist}</div>
                  <div className="font-light opacity-50">{trip.createdAt}</div>
                </div>
                {hoveredButton === trip.id && (
                  <div className="absolute px-4 cursor-pointer">
                    <IconPlay />
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      </div>
      {themes.map((item, index) => (
        <div key={index} className="mt-[48px]">
          <div className="flex justify-between p-4  text-xl">
            <div className="text-header">{item.title}</div>
            <div className="flex items-center text-primary-100 text-header cursor-pointer hover:text-secondary">
              Xem thêm
              <IconGoRight />
            </div>
          </div>
          <div className="flex justify-center items-center px-4 gap-5">
            {albums.map((item, index) => (
              <div
                onMouseEnter={() => setHoveredButton(item.id)}
                onMouseLeave={() => setHoveredButton(null)}
                key={index}
                className="flex flex-col justify-center items-center p-2 gap-5 max-w-3xl rounded cursor-default"
                style={{ position: "relative" }}
              >
                <div className="flex flex-col justify-center items-center hover:scale-110 transition-transform duration-300">
                  <Image
                    src={item.imgUrl}
                    width={100}
                    height={100}
                    alt="Image"
                    className={`rounded w-[181px] h-[181px] ${
                      hoveredButton === item.id && "opacity-50"
                    }`}
                  />
                  {hoveredButton === item.id && (
                    <div className="absolute px-4 cursor-pointer">
                      <IconPlay />
                    </div>
                  )}
                </div>
                <div className="text-xs font-bold tracking-tight opacity-50">
                  {item.desc}
                </div>
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}