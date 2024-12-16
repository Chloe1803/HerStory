import { Role } from "./role";
import { RoleChange } from "./role-change";

export interface RegisterUser {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  aboutMe: string;
}

export interface ProfileUser {
  id: number;
  firstName: string;
  lastName: string;
  email: string;
  aboutMe: string;
  role: Role;
  createdAt: string;
  numberOfContributions: number;
  numberOfReviews: number;
  lastRoleChange: RoleChange;
}
