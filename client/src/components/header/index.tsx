"use client";
import { IconSearch, IconSetting, IconUser } from "@/assets/icons";
import {
  headeSettingItem,
  headerAccountItem,
} from "@/services/header/header-helpers";
import Link from "next/link";
import { useState } from "react";
import Login from "../login";
import Signup from "../signup";
import useAuthStore from "@/stores/auth-store";

const Header = () => {
  const { authorized } = useAuthStore();
  const [openLoginModal, setOpenLoginModal] = useState(false);
  const [openSignupModal, setOpenSignupModal] = useState(false);
  const [clickedAccount, setClickedAccount] = useState(false);
  const [clickedSetting, setClickedSetting] = useState(false);
  return (
    <div className="px-16 py-4 w-full h-[84px] flex items-center justify-between">
      <form className="w-full px-5">
        <div className="relative">
          <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <IconSearch />
          </div>
          <input
            type="search"
            className="block w-1/2 p-4 pl-10 text-sm text-secondary rounded-full bg-primary"
            placeholder="Tìm kiếm bài hát"
          />
        </div>
      </form>
      <div className="flex gap-4 items-center">
        <div className="w-10 h-10 flex items-center justify-center border border-secondary rounded-full">
          <div
            className="cursor-pointer"
            onClick={() => {
              setClickedAccount(false);
              setClickedSetting(!clickedSetting);
            }}
          >
            <IconSetting />
          </div>
          <div
            onMouseLeave={() => setClickedSetting(false)}
            className={`${
              !clickedSetting && "hidden"
            } absolute flex flex-col justify-between right-16 z-10 mt-32 w-56 origin-top-right rounded-md bg-primary  shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none`}
          >
            {headeSettingItem.map((item, index) => (
              <div
                key={index}
                className="flex items-center text-secondary block px-2 py-2 gap-2 text-sm cursor-pointer"
              >
                <item.IconComponent />
                {item.label}
              </div>
            ))}
          </div>
        </div>
        <div>
          <div
            className="cursor-pointer"
            onClick={() => {
              setClickedSetting(false);
              setClickedAccount(!clickedAccount);
            }}
          >
            {authorized ? (
              <IconUser />
            ) : (
              <div onClick={() => setOpenLoginModal(true)}>
                <div className="w-40 flex items-center justify-center text-center rounded-xl border border-secondary py-2 px-1 text-xs text-secondary bg-primary font-medium">
                  Đăng nhập
                </div>
              </div>
            )}
          </div>
          <div
            onMouseLeave={() => setClickedAccount(false)}
            className={`${
              !clickedAccount && "hidden"
            } absolute flex flex-col justify-between right-16 z-10 mt-2 w-56 origin-top-right rounded-md bg-primary shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none`}
          >
            {authorized && (
              <div>
                {headerAccountItem.map((item, index) => (
                  <div key={index} className="flex items-center">
                    <item.IconComponent />
                    <Link
                      href={item.link}
                      className="text-secondary block px-4 py-2 text-sm gap-2"
                    >
                      {item.label}
                    </Link>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>
      {openLoginModal && (
        <Login
          openLoginModal={openLoginModal}
          setOpenLoginModal={setOpenLoginModal}
          openSignupModal={openSignupModal}
          setOpenSignupModal={setOpenSignupModal}
        />
      )}

      {openSignupModal && (
        <Signup
          openSignupModal={true}
          setOpenSignupModal={setOpenSignupModal}
        />
      )}
    </div>
  );
};

export default Header;
