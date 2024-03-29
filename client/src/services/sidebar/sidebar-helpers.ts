import {
  IconDiscovery,
  IconLibrary,
  IconListMusic,
  IconLove,
  IconRecently,
  IconZingchart,
  IconTopic,
  IconTop100,
  IconUpload,
} from "@/assets/icons";

export enum SelectedOptionSidebar {
  Discovery = "discovery",
  Chart = "chart",
  Theme = "theme",
  History = "history",
  Favorite = "favorite",
  Playlist = "playlist",
  Upload = "upload",
}

export const sidebarItems = [
  {
    id: SelectedOptionSidebar.Discovery,
    lable: "Khám phá",
    IconComponent: IconDiscovery,
    link: "/",
  },
  {
    id: SelectedOptionSidebar.Chart,
    lable: "Bảng xếp hạng",
    IconComponent: IconZingchart,
    link: "/chart",
  },
  {
    id: SelectedOptionSidebar.Theme,
    lable: "Chủ đề & Thể loại",
    IconComponent: IconTopic,
    link: "/hub",
  },
];

export const sidebarItemsLibrary = [
  {
    id: SelectedOptionSidebar.History,
    lable: "Nghe gần đây",
    IconComponent: IconRecently,
    link: "/library/history",
  },
  {
    id: SelectedOptionSidebar.Favorite,
    lable: "Bài hát yêu thích",
    IconComponent: IconLove,
    link: "/library/favorite",
  },
  {
    id: SelectedOptionSidebar.Playlist,
    lable: "Playlist",
    IconComponent: IconListMusic,
    link: "/library/playlist",
  },
  {
    id: SelectedOptionSidebar.Upload,
    lable: "Đã tải lên",
    IconComponent: IconUpload,
    link: "/library/upload",
  },
];
