import { Component } from '@angular/core';
import { AuthService } from '../../../services/authentification/auth.service';
import { ProfileUser } from '../../../interfaces/user';
import { UserService } from '../../../services/user/user.service';
import { RoleConstants, RoleName } from '../../../constants/role-constants';
import { Router, ActivatedRoute, ParamMap } from '@angular/router'; 

@Component({
  selector: 'app-other-user-profile',
  templateUrl: './other-user-profile.component.html',
  styleUrl: './other-user-profile.component.css'
})
export class OtherUserProfileComponent {
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
  profileId!: number;
  constructor(private authService: AuthService, private userService: UserService, private route: ActivatedRoute, private router: Router) { }

  ngOnInit(): void {
    this.profileId = this.route.snapshot.params['userId'];
    this.getProfile();
  }

  getProfile(): void {
    this.isLoading = true;  // Début du chargement
    this.errorMessage = null; // Réinitialiser le message d'erreur à chaque nouvelle requête

    this.userService.getOtherUserProfile(this.profileId).subscribe({
      next: (profile) => {
        this.profile = profile;  // Assignation du profil récupéré

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

}
