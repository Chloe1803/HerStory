import { Component } from '@angular/core';
import { AuthService } from '../../../services/authentification/auth.service';
import { ProfileUser } from '../../../interfaces/user';
import { UserService } from '../../../services/user/user.service';
import { RoleConstants, RoleName } from '../../../constants/role-constants'; 

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css'
})
export class ProfileComponent {
  profile!: ProfileUser;
  RoleConstants = RoleConstants;
  constructor(private authService: AuthService, private userService: UserService) { }

  ngOnInit(): void {
    this.userService.getProfile().subscribe((profile: ProfileUser) => {
      this.profile = profile;
    });
    }
  
  logout(): void {
    this.authService.logout();
  }

  requestRoleChange(): void {
    console.log('Requesting role change');
  }


}
