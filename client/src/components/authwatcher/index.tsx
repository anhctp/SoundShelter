"use client";
import useAuthStore from "@/stores/auth-store";
import { useUserStore } from "@/stores/user-store";
import { useEffect, useState } from "react";
import { usePathname } from "next/navigation";
import { useRouter } from "next/navigation";

const AuthWatcher = () => {
  // wait until user info api is available
  const pathname = usePathname();
  const router = useRouter();

  const [firstLoad, setFirstLoad] = useState(true);
  const { authorized, setAuthorized, token, setToken } = useAuthStore();

  const setUser = useUserStore((state) => state.setUser);
  const removeUser = useUserStore((state) => state.removeUser);

  const [authCheck, setAuthCheck] = useState(false);

  const triggerAuthCheck = () => {
    setAuthCheck(!authCheck);
  };
  useEffect(() => {
    setFirstLoad(false);
    if (token) {
      // check if expired
      /* 
      if(expired) {
        // check if refresh token is expired
        if(refreshTokenExpired) {
          setAuthorized(false);
        } else {
          // refresh token
          // set new token
        }
      } else {
        setAuthorized(true);
      }
      */
      setAuthorized(true);
      triggerAuthCheck();
    } else {
      const localToken = localStorage.getItem("token");
      if (localToken) {
        setToken(localToken);
      } else {
        setAuthorized(false);
        triggerAuthCheck();
      }
    }
  }, [token]);
  useEffect(() => {
    const user = localStorage.getItem("user");
    if (user) {
      setUser(JSON.parse(user));
    }
  }, []);

  useEffect(() => {
    if (!authorized && !firstLoad) {
      removeUser();
      localStorage.removeItem("user");
    }
  }, [authorized, authCheck]);

  return <></>;
};
export default AuthWatcher;
