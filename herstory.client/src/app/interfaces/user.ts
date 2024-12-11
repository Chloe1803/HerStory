export interface RegisterUser {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  aboutMe: string;
}

export interface ProfileUser {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  aboutMe: string;
  role: string;
  createdAt: string;
  numberOfContributions: number;
  numberOfReviews: number;
  requestedRole?: string;
  requestedRoleStatus?: string;
}
