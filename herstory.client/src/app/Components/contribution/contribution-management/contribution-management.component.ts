import { Component } from '@angular/core';
import { Router } from '@angular/router'
import { ContributionList, ContributionViewConfig } from '../../../interfaces/contribution'
import { ContributionService } from '../../../services/contribution/contribution.service'
declare var bootstrap: any;



@Component({
  selector: 'app-contribution-management',
  templateUrl: './contribution-management.component.html',
  styleUrl: './contribution-management.component.css'
})
export class ContributionManagementComponent {
  userPendingReviews: ContributionList[] = [];
  unassignedPendingReviews: ContributionList[] = [];
  isLoading = true;
  errorMessage: string | null = null;

  constructor(private router: Router, private contributionService: ContributionService) { }

  ngOnInit() {
    this.getunassignedPendingReviews();
    this.getUserPendingReviews();
    this.isLoading = false;
  }

  getUserPendingReviews() {
    this.contributionService.getPendingContributionAssignedToUser().subscribe({
      next: (data) => {
        this.userPendingReviews = data;
      },
      error: (err) => {
        console.log(err)
        this.isLoading = false;
        this.errorMessage = "Une erreur est survenue";
      }
    })
  }

  getunassignedPendingReviews() {
    this.contributionService.getUnassignedPendingContribution().subscribe({
      next: (data) => {
        this.unassignedPendingReviews = data;
      },
      error: (err) => {
        console.log(err)
        this.isLoading = false;
        this.errorMessage = "Une erreur est survenue";
      }
    })
  }

  reviewContribution(contribution : ContributionList) {
    const contributionViewConfig: ContributionViewConfig = {
      id: contribution.contributionId,
      isReview: true,
      isNewPortrait: contribution.isNewPortrait
    }

    this.router.navigate(['view-contribution'], { state: contributionViewConfig })
  }

  viewContribution(contribution: ContributionList) {
    const contributionViewConfig: ContributionViewConfig = {
      id: contribution.contributionId,
      isReview: false,
      isNewPortrait: contribution.isNewPortrait
    }

    this.router.navigate(['view-contribution'], { state: contributionViewConfig })
  }

  unAssignUser(id: number) {
    this.contributionService.unassignSelfToContribution(id).subscribe({
      next: () => {
        this.getunassignedPendingReviews();
        this.getUserPendingReviews();
      },
      error: (err: Error) => {
        console.log(err)
        this.showErrorToast()
      }
    });
  }

  assignUser(id: number) {
    this.contributionService.assignSelfToContribution(id).subscribe({
      next: () => {
        this.getunassignedPendingReviews();
        this.getUserPendingReviews();
      },
      error: (err: Error) => {
        console.log(err)
        this.showErrorToast()
      }
    });;
  }


  showErrorToast(message: string = 'Une erreur est survenue.'): void {
    const toastElement = document.getElementById('errorToast');
    if (toastElement) {
      const toastBody = toastElement.querySelector('.toast-body');
      if (toastBody) {
        toastBody.textContent = message; // Personnalise le message
      }
      const toast = new bootstrap.Toast(toastElement); // Initialise le toast Bootstrap
      toast.show(); // Affiche le toast
    }
  }

}
