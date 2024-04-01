import axios, { CreateAxiosDefaults } from "axios";
export const baseURL = `http://localhost:8000/api`;

interface IAxiosClient {
  options: CreateAxiosDefaults<any>;
  getCurrentToken?: () => string | undefined;
  logout?: () => void;
}
export const setUpAxiosClient = ({
  options,
  getCurrentToken,
  logout,
}: IAxiosClient) => {
  const client = axios.create(options);

  client.interceptors.request.use(
    (config) => {
      if (config.headers && getCurrentToken) {
        const token = getCurrentToken();
        if (token) {
          config.headers.Authorization = "Bearer " + token;
        }
      }
      return config;
    },
    () => {
      console.log("Cannot connect to server!");
    }
  );
  client.interceptors.response.use(
    (response) => {
      return response;
    },
    function (error) {
      const res = error.response;
      if (res.status === 401) {
        if (logout) {
          logout();
        }
      } else if (res.status === 403) {
        console.log("Unauthorized!");
      } else if (res.status === 404) {
        console.log("Page not found!");
      } else {
        console.log("Error occurred!");
      }
      return Promise.reject(error);
    }
  );
  return client;
};
