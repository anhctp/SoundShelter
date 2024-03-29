export interface UserLogin {
  email: string;
  password: string;
}
export interface UserRegister extends UserLogin {
  name: string;
}
export interface User extends UserRegister {
  id: number;
}
