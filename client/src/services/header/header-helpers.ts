import { IconInfo, IconLogout, IconTheme, IconUpload1 } from "@/assets/icons";

export enum AccountItem {
  Upload = "upload",
  Logout = "logout",
}
export enum SettingItem {
  Theme = "theme",
  Introduce = "introduce",
}

export const headerAccountItem = [
  {
    id: AccountItem.Upload,
    label: "Tải lên",
    IconComponent: IconUpload1,
    link: "/library/upload",
  },
  {
    id: AccountItem.Logout,
    label: "Đăng xuất",
    IconComponent: IconLogout,
    link: "/logout",
  },
];
export const headeSettingItem = [
  {
    id: SettingItem.Theme,
    label: "Giao diện",
    IconComponent: IconTheme,
  },
  {
    id: SettingItem.Introduce,
    label: "Giới thiệu",
    IconComponent: IconInfo,
  },
];