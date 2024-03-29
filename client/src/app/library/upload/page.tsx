import Image from "next/image";
export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center gap-4 p-4 text-neutral-400 text-xl">
      <Image
        src={
          "https://zmp3-static.zmdcdn.me/skins/zmp3-v6.1/images/icons/empty-fav-song-dark.png"
        }
        alt="empty-fav-song"
        width={200}
        height={200}
      />
      Tính năng tải nhạc lên đang phát triển!
    </div>
  );
}
