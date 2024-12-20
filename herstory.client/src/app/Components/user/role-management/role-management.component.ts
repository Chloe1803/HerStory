import { Component } from '@angular/core';
import { UserService } from '../../../services/user/user.service';
import { RoleChangeRequest, RoleChangeResponse } from '../../../interfaces/role-change';
import { RoleConstants } from '../../../constants/role-constants';

@Component({
  selector: 'app-role-management',
  templateUrl: './role-management.component.html',
  styleUrl: './role-management.component.css'
})
export class RoleManagementComponent {
  pendingRequests: RoleChangeRequest[] = [];
  RoleConstants = RoleConstants;

  constructor(private userService: UserService) {
  }

  ngOnInit(): void {
    this.getPendingRequests();
  }

  getPendingRequests() {
    this.userService.getPendingRoleRequest().subscribe(
      (data) => {
        this.pendingRequests = data;
      }
    );
  }


  acceptRequest(request: RoleChangeRequest) {
    let response: RoleChangeResponse = {
      action: 'accept'
    };

    this.userService.respondRoleRequest(request.id, response).subscribe(
      () => {
        this.getPendingRequests();
      }
    );
  }

  rejectRequest(request: RoleChangeRequest) {
    let response: RoleChangeResponse = {
      action: 'reject'
    };

    this.userService.respondRoleRequest(request.id, response).subscribe(
      () => {
        this.getPendingRequests();
      }
    );
  }
}
