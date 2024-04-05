"use client";
import { useSongStore } from "@/stores/song-store";
import React, { useState, useRef, useEffect, use } from "react";
import { FaPlay, FaPause, FaVolumeUp, FaVolumeDown } from "react-icons/fa";
import {
  IoShuffleOutline,
  IoPlayCircleOutline,
  IoRepeat,
  IoPauseCircleOutline,
} from "react-icons/io5";
import { MdSkipPrevious, MdSkipNext } from "react-icons/md";

import Image from "next/image";

const AudioPlayer = () => {
  const audioRef = useRef<HTMLAudioElement>(null);
  const {
    song,
    songID,
    isPlaying,
    volume,
    songTime,
    setSong,
    setIsPlaying,
    setVolume,
    setSongTime,
  } = useSongStore();
  const playPauseHandler = () => {
    if (audioRef.current) {
      if (isPlaying) {
        audioRef.current.pause();
      } else {
        audioRef.current.play();
      }
      setIsPlaying(!isPlaying);
    }
  };

  const volumeChangeHandler = (newVolume: number) => {
    if (newVolume >= 0 && newVolume <= 1) {
      setVolume(newVolume);
      if (audioRef.current) {
        audioRef.current.volume = newVolume;
      }
    }
  };
  const handleSongTimeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const newSongTime = parseFloat(e.target.value);
    setSongTime(newSongTime);
    if (audioRef.current) {
      audioRef.current.currentTime = newSongTime;
    }
  };
  const formatTime = (seconds: number): string => {
    if (seconds === 0 || Number.isNaN(seconds)) {
      return "00:00";
    }
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    const formattedMinutes = String(minutes).padStart(2, "0");
    const formattedSeconds = String(remainingSeconds).padStart(2, "0");
    return `${formattedMinutes}:${formattedSeconds}`;
  };
  useEffect(() => {
    const updateSongTime = () => {
      if (audioRef.current) {
        setSongTime(audioRef.current.currentTime);
      }
    };

    if (audioRef.current) {
      if (isPlaying) {
        audioRef.current.play();
      }
      audioRef.current.addEventListener("timeupdate", updateSongTime);
    }

    return () => {
      if (audioRef.current) {
        audioRef.current.removeEventListener("timeupdate", updateSongTime);
      }
    };
  }, []);

  useEffect(() => {
    const newSong = {
      id: 1,
      album_id: 1,
      playlist_id: 1,
      title: "Làm lành chữa tình",
      artist: "Tlinh",
      audio_file_path:
        "https://vnno-vn-6-tf-a320-z3.zmdcdn.me/cdd820c38675fb98ccca4d125a2c8697?authen=exp=1711893017~acl=/cdd820c38675fb98ccca4d125a2c8697/*~hmac=ad8874a23ffc887490b949a90512d8aa",
      image_file_path:
        "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/0/1/3/7/0137422e6a4e4f375c058c4d260db396.jpg",
      release_date: "2023/11/2",
      views: 0,
    };
    setSong(newSong);
  }, []);
  return (
    <div className="h-full flex justify-between border rounded-white shadow-md">
      <div
        className="flex items-center p-2 gap-5 max-w-3xl rounded focus:bg-primary hover:bg-primary cursor-default w-1/3"
        style={{ position: "relative" }}
      >
        <div className="w-[60px] h-[60px] flex items-center">
          {song && (
            <Image
              src={song.image_file_path}
              width={60}
              height={60}
              alt="Image"
            />
          )}
        </div>
        <div className="text-xs tracking-tight">
          <div className="font-bold">{song?.title}</div>
          <div className="font-light opacity-50">{song?.artist}</div>
        </div>
      </div>

      <div className="flex flex-col justify-center gap w-full">
        <audio ref={audioRef} src={song?.audio_file_path} />
        <div className="flex justify-center items-center gap-4">
          <IoShuffleOutline className="w-8 h-8" />
          <MdSkipPrevious className="w-8 h-8" />
          <button onClick={playPauseHandler}>
            {isPlaying ? (
              <IoPauseCircleOutline className="w-12 h-12" />
            ) : (
              <IoPlayCircleOutline className="w-12 h-12" />
            )}
          </button>
          <MdSkipNext className="w-8 h-8" />
          <IoRepeat className="w-8 h-8" />
        </div>
        <div className="flex items-center justify-center gap-2">
          <span>{formatTime(songTime)}</span>
          <input
            type="range"
            min={0}
            max={audioRef.current ? audioRef.current.duration : 0}
            step={1}
            value={songTime}
            onChange={handleSongTimeChange}
            className="w-[300px] slider"
          />
          <span>
            {formatTime(audioRef.current ? audioRef.current.duration : 0)}
          </span>
        </div>
      </div>
      <div className="flex items-center justify-center gap-2 p-2 w-1/4">
        <div className="flex items-center gap-2 w-3/4">
          <FaVolumeDown
            className="cursor-pointer"
            onClick={() => volumeChangeHandler(volume - 0.1)}
          />
          <input
            type="range"
            className="slider"
            min={0}
            max={1}
            step={0.01}
            value={volume}
            onChange={(event) =>
              volumeChangeHandler(parseFloat(event.target.value))
            }
          />
          <FaVolumeUp
            className="cursor-pointer"
            onClick={() => volumeChangeHandler(volume + 0.1)}
          />
        </div>
      </div>
    </div>
  );
};

export default AudioPlayer;
