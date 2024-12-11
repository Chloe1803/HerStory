import { Component } from '@angular/core';
import { AuthService } from '../../../services/authentification/auth.service';
import {ProfileUser} from '../../../interfaces/user'; 

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrl: './profile.component.css'
})
export class ProfileComponent {
  profile!: ProfileUser;
  constructor(private authService: AuthService) {}
  
  logout(): void {
    this.authService.logout();
  }

}
