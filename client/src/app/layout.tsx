import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "../../public/globals.css";
import Sidebar from "@/components/sidebar";
import Header from "@/components/header";

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
      <body className={inter.className}>
        <main className="h-screen flex bg-primary-200 text-secondary">
          <Sidebar />
          <div className="w-full h-full">
            <Header />
            {children}
          </div>
        </main>
      </body>
    </html>
  );
}
