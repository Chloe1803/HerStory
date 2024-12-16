import { Component } from '@angular/core';
import { UserService } from '../../../services/user/user.service';
import { RoleChangeRequest } from '../../../interfaces/role-change';

@Component({
  selector: 'app-role-management',
  templateUrl: './role-management.component.html',
  styleUrl: './role-management.component.css'
})
export class RoleManagementComponent {
  pendingRequests: RoleChangeRequest[] = [];

  constructor(private userService: UserService) {
  }

  ngOnInit(): void {
    this.userService.getPendingRoleRequest().subscribe(
      (data) => {
        this.pendingRequests = data;
      }
    );
  }

  acceptRequest(request: RoleChangeRequest) {
    // Accepter la demande
  }

  rejectRequest(request: RoleChangeRequest) {
    // Rejeter la demande
  }
}
