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
  profile: ProfileUser = {
    id: 0,
    firstName: '',
    lastName: '',
    email: '',
    aboutMe: '',
    role: {
      id: 0,
      name: RoleName.Visitor, // Défaut : "Visitor"
    },
    createdAt: '',
    numberOfContributions: 0,
    numberOfReviews: 0,
    lastRoleChange: {
      id: 0,
      requestedRole: {
        id: 0,
        name: RoleName.Visitor, // Défaut pour le rôle demandé
      },
      status: '', // Défaut vide
    },
  };

  RoleConstants = RoleConstants;
  isLoading = true;
  errorMessage: string | null = null;
  constructor(private authService: AuthService, private userService: UserService) { }

  ngOnInit(): void {
    this.getProfile();
  }

  getProfile(): void {
    this.isLoading = true;  // Début du chargement
    this.errorMessage = null; // Réinitialiser le message d'erreur à chaque nouvelle requête

    this.userService.getProfile().subscribe({
      next: (profile) => {
        this.profile = profile;  // Assignation du profil récupéré
        console.log(this.profile.numberOfContributions);
        console.log(profile.numberOfContributions);
        this.isLoading = false;  // Fin du chargement
      },
      error: (err) => {
        this.isLoading = false;  // Fin du chargement
        if (err.status === 404) {
          this.errorMessage = "Profil non trouvé";  // Message d'erreur spécifique
        } else {
          this.errorMessage = "Une erreur est survenue";  // Message d'erreur générique
        }
      }
    });

   
  }
  
  logout(): void {
    this.authService.logout();
  }

  requestRoleChange(): void {
    this.userService.requestNextRole().subscribe(() => {
      this.getProfile();
    });
  }


}
