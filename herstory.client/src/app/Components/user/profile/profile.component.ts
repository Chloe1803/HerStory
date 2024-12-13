import { Component } from '@angular/core';
import { AuthService } from '../../../services/authentification/auth.service';
import { ProfileUser } from '../../../interfaces/user';
import { UserService } from '../../../services/user/user.service'; 

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css'
})
export class ProfileComponent {
  profile!: ProfileUser;
  constructor(private authService: AuthService, private userService: UserService) { }

  ngOnInit(): void {
    this.userService.getProfile().subscribe((profile: ProfileUser) => {
      console.log(profile);
      this.profile = profile;
    });
    }
  
  logout(): void {
    this.authService.logout();
  }

}
