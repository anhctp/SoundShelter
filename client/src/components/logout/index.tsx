"use client";
import useAuthStore from "@/stores/auth-store";
import { useEffect } from "react";
import { useRouter } from "next/navigation";

const Logout: React.FC = () => {
  const logout = useAuthStore((state) => state.logout);
  const router = useRouter();
  // logout manually to reset queries' key
  useEffect(() => {
    logout();
    router.push("/");
  }, []);

  return <></>;
};
export default Logout;
