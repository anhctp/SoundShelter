import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "../../public/globals.css";
import Sidebar from "@/components/sidebar";
import Header from "@/components/header";
import AuthWatcher from "@/components/authwatcher";
import AudioPlayer from "@/components/audio/audio-player";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "SoundShelter",
  description: "Music app",
  icons: "/soundshelter-favicon-color.png",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <AuthWatcher />
      <body className={inter.className}>
        <main className="h-screen flex flex-col justify-between text-secondary bg-primary-200">
          <div className="h-[calc(100%_-_84px)] flex">
            <Sidebar />
            <div className="w-[calc(100%_-_240px)] h-full">
              <Header />
              {children}
            </div>
          </div>
          <div className="h-[84px]">
            <AudioPlayer />
          </div>
        </main>
      </body>
    </html>
  );
}
