"use client";
import { useEffect, useState } from "react";
import ButtonSidebar from "./button-sidebar";
import {
  SelectedOptionSidebar,
  sidebarItems,
  sidebarItemsLibrary,
} from "@/services/sidebar/sidebar-helpers";
import Link from "next/link";
import { usePathname } from "next/navigation";
import Image from "next/image";
import { IconAdd } from "@/assets/icons";
// import useAuthStore from "@/stores/authStore";

const Sidebar = () => {
  const [selectedOption, setSelectedOption] = useState<SelectedOptionSidebar>(
    SelectedOptionSidebar.Discovery
  );
  const logoUrl = "/logo-no-background.png";
  const currentURL = usePathname();
  // const { authorized } = useAuthStore();
  useEffect(() => {
    if (currentURL.includes("chart")) {
      setSelectedOption(SelectedOptionSidebar.Chart);
    } else if (currentURL.includes("hub")) {
      setSelectedOption(SelectedOptionSidebar.Theme);
    } else if (currentURL.includes("history")) {
      setSelectedOption(SelectedOptionSidebar.History);
    } else if (currentURL.includes("favorite")) {
      setSelectedOption(SelectedOptionSidebar.Favorite);
    } else if (currentURL.includes("playlist")) {
      setSelectedOption(SelectedOptionSidebar.Playlist);
    } else if (currentURL.includes("upload")) {
      setSelectedOption(SelectedOptionSidebar.Upload);
    } else {
      setSelectedOption(SelectedOptionSidebar.Discovery);
    }
  }, [currentURL]);
  return (
    <div className="h-full w-[240px] flex flex-col bg-primary">
      <Link
        href={"/"}
        className="flex items-center justify-center px-5 h-[70px] w-[240px]"
      >
        <Image src={logoUrl} width={300} height={40} alt="logo" />
      </Link>
      <div className="overflow-auto">
        {sidebarItems.map((item, index) => (
          <Link key={index} href={item.link}>
            <ButtonSidebar
              IconComponent={item.IconComponent}
              selected={selectedOption === item.id}
              onClick={() => setSelectedOption(item.id)}
            >
              {item.lable}
            </ButtonSidebar>
          </Link>
        ))}
        {
          // authorized &&
          sidebarItemsLibrary.map((item, index) => (
            <Link key={index} href={item.link}>
              <ButtonSidebar
                IconComponent={item.IconComponent}
                selected={selectedOption === item.id}
                onClick={() => setSelectedOption(item.id)}
              >
                {item.lable}
              </ButtonSidebar>
            </Link>
          ))
        }
      </div>
      {/* <div className="fixed w-[240px] h-[70px] bottom-0 flex items-center border-t px-6 bottom-0 cursor-pointer">
        <IconAdd />
        <div className="text-white font-medium">Tạo playlist mới</div>
      </div> */}
    </div>
  );
};

export default Sidebar;
