import { Fragment, useRef, useState } from "react";
import { Dialog, Transition } from "@headlessui/react";
import { NextPage } from "next";
import { register } from "@/services/user/user-api";
import useAuthStore from "@/stores/auth-store";
import { useUserStore } from "@/stores/user-store";

interface Props {
  openSignupModal: boolean;
  setOpenSignupModal: React.Dispatch<React.SetStateAction<boolean>>;
}

const Signup: NextPage<Props> = (props) => {
  const { openSignupModal, setOpenSignupModal } = props;
  const [name, setName] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [email, setEmail] = useState<string>("");
  const cancelButtonRef = useRef(null);
  const handleRegister = async () => {
    setOpenSignupModal(false);
    if (email && name && password) {
      const res = await register({
        email: email,
        name: name,
        password: password,
      });
      useAuthStore.getState().setToken(res.data.jwtToken);
      useAuthStore.getState().setAuthorized(true);
      const newUser = res.data.user;
      localStorage.setItem("user", JSON.stringify(newUser));
      useUserStore.getState().setUser(newUser);
      localStorage.setItem("token", res.data.jwtToken);
    }
  };
  return (
    <Transition.Root show={openSignupModal} as={Fragment}>
      <Dialog
        as="div"
        className="relative z-10"
        initialFocus={cancelButtonRef}
        onClose={setOpenSignupModal}
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
                        Đăng ký
                      </Dialog.Title>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          <label htmlFor="name">Họ và tên: </label>
                          <input
                            value={name}
                            onChange={(event) => {
                              setName(event.target.value);
                            }}
                            id="name"
                            type="text"
                            className="border"
                          />
                        </p>
                      </div>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          <label htmlFor="name">Email: </label>
                          <input
                            value={email}
                            onChange={(event) => {
                              setEmail(event.target.value);
                            }}
                            id="email"
                            type="text"
                            className="border"
                          />
                        </p>
                      </div>
                      <div className="mt-2">
                        <p className="text-sm text-gray-500">
                          <label htmlFor="name">Mật khẩu: </label>
                          <input
                            value={password}
                            onChange={(event) => {
                              setPassword(event.target.value);
                            }}
                            id="password"
                            type="password"
                            className="border"
                          />
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                  <button
                    type="button"
                    className="inline-flex w-full justify-center rounded-md bg-[#8d22c3] px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-red-500 sm:ml-3 sm:w-auto"
                    onClick={handleRegister}
                  >
                    Đăng ký
                  </button>
                  <button
                    type="button"
                    className="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                    onClick={() => setOpenSignupModal(false)}
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

export default Signup;
