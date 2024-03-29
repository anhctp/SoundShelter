import { Fragment, useRef, useState } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { NextPage } from "next";
import useAuthStore from "@/stores/auth-store";
import { login } from "@/services/user/user-api";
import { useUserStore } from "@/stores/user-store";
interface Props {
  openLoginModal: boolean;
  setOpenLoginModal: React.Dispatch<React.SetStateAction<boolean>>;
  openSignupModal: boolean;
  setOpenSignupModal: React.Dispatch<React.SetStateAction<boolean>>;
}

const Login: NextPage<Props> = (props) => {
  const {
    openLoginModal,
    setOpenLoginModal,
    openSignupModal,
    setOpenSignupModal,
  } = props;

  const [password, setPassword] = useState<string>("");
  const [email, setEmail] = useState<string>("");
  const cancelButtonRef = useRef(null);
  const token = useAuthStore((state) => state.token);

  const handleLogin = async () => {
    setOpenLoginModal(false);
    if (email && password) {
      const res = await login({
        email: email,
        password: password,
      });
      useAuthStore.getState().setToken(res.data.jwtToken);
      useAuthStore.getState().setAuthorized(true);
      const newUser = res.data.user;
      localStorage.setItem("user", JSON.stringify(newUser));
      useUserStore.getState().setUser(newUser);
      localStorage.setItem("accessToken ", res.data.jwtToken);
    }
  };
  return (
    <Transition.Root show={openLoginModal} as={Fragment}>
      <Dialog
        as="div"
        className="relative z-10"
        initialFocus={cancelButtonRef}
        onClose={setOpenLoginModal}
      >
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" />
        </Transition.Child>

        <div className="fixed inset-0 z-10 w-screen overflow-y-auto">
          <div className="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
              enterTo="opacity-100 translate-y-0 sm:scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 translate-y-0 sm:scale-100"
              leaveTo="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            >
              <Dialog.Panel className="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
                <div className="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                  <div className="sm:flex sm:items-start">
                    <div className="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                      <Dialog.Title
                        as="h3"
                        className="text-base font-semibold leading-6 text-gray-900"
                      >
                        Đăng nhập
                      </Dialog.Title>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          <label htmlFor="name">Email: </label>
                          <input
                            id="name"
                            type="text"
                            value={email}
                            onChange={(event) => {
                              setEmail(event.target.value);
                            }}
                            className="border"
                          />
                        </p>
                      </div>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          <label htmlFor="password">Mật khẩu: </label>
                          <input
                            id="password"
                            type="password"
                            value={password}
                            onChange={(event) => {
                              setPassword(event.target.value);
                            }}
                            className="border"
                          />
                        </p>
                      </div>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          Chưa có tài khoản?{" "}
                          <span
                            className="text-[#8d22c3] cursor-pointer"
                            onClick={() => {
                              setOpenLoginModal(false);
                              setOpenSignupModal(true);
                            }}
                          >
                            Đăng ký
                          </span>{" "}
                          ngay!
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                  <button
                    type="button"
                    className="inline-flex w-full justify-center rounded-md bg-[#8d22c3] px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto"
                    onClick={handleLogin}
                  >
                    Đăng nhập
                  </button>
                  <button
                    type="button"
                    className="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                    onClick={() => setOpenLoginModal(false)}
                    ref={cancelButtonRef}
                  >
                    Huỷ
                  </button>
                </div>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition.Root>
  );
};

export default Login;
