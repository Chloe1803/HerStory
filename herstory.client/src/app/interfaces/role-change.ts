import {Role } from './role';

export interface RoleChange {
  id: number;
  requestedRole: Role;
  status: string;
}

export interface RoleChangeRequest {
  id: number;
  userFirstName: string;
  userLastName: string;
  userId: number;
  requestedRole: Role;
  
}
