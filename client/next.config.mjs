/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: "photo-zmp3.zmdcdn.me",
        port: "",
      },
      {
        protocol: "https",
        hostname: "photo-resize-zmp3.zmdcdn.me",
        port: "",
      },
    ],
  },
  reactStrictMode: false,
};

export default nextConfig;
