import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "../../public/globals.css";

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
      <body className={inter.className}>{children}</body>
    </html>
  );
}
