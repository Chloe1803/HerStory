import { Component } from '@angular/core';
import { UserService } from '../../../services/user/user.service';
import { RoleChangeRequest, RoleChangeResponse } from '../../../interfaces/role-change';
import { RoleConstants } from '../../../constants/role-constants';
import { Router } from '@angular/router'

@Component({
  selector: 'app-role-management',
  templateUrl: './role-management.component.html',
  styleUrl: './role-management.component.css'
})
export class RoleManagementComponent {
  pendingRequests: RoleChangeRequest[] = [];
  RoleConstants = RoleConstants;
  isLoading = true;
  errorMessage: string | null = null;

  constructor(private userService: UserService, private router : Router) { }

  ngOnInit(): void {
    this.getPendingRequests();
  }

  getPendingRequests(): void {
    this.isLoading = true;  // Début du chargement
    this.errorMessage = null; // Réinitialiser le message d'erreur

    this.userService.getPendingRoleRequest().subscribe({
      next: (data) => {
        this.pendingRequests = data; // Assignation des données
        this.isLoading = false; // Fin du chargement
      },
      error: (err) => {
        this.isLoading = false; // Fin du chargement
        if (err.status === 404) {
          this.errorMessage = "Aucune demande en attente trouvée."; // Message spécifique pour 404
        } else {
          this.errorMessage = "Une erreur est survenue lors de la récupération des demandes."; // Message générique
        }
      }
    });
  }

  acceptRequest(request: RoleChangeRequest): void {
    let response: RoleChangeResponse = {
      action: 'accept'
    };

    this.userService.respondRoleRequest(request.id, response).subscribe({
      next: () => {
        this.getPendingRequests(); // Rafraîchir les demandes après succès
      },
      error: (err) => {
        console.error(err);
        this.router.navigate(['error']);
      }
    });
  }

  rejectRequest(request: RoleChangeRequest): void {
    let response: RoleChangeResponse = {
      action: 'reject'
    };

    this.userService.respondRoleRequest(request.id, response).subscribe({
      next: () => {
        this.getPendingRequests(); // Rafraîchir les demandes après succès
      },
      error: (err) => {
        console.error(err);
        this.router.navigate(['error']);
      }
    });
  }
}
