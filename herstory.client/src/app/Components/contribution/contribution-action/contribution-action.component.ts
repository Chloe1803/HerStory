import { Component, Input, EventEmitter, Output } from '@angular/core';
import { Router } from '@angular/router'
import { ContributionViewConfig, ContributionReview } from '../../../interfaces/contribution'
import {ContributionService } from '../../../services/contribution/contribution.service'
import { config } from 'rxjs';


@Component({
  selector: 'app-contribution-action',
  templateUrl: './contribution-action.component.html',
  styleUrl: './contribution-action.component.css'
})
export class ContributionActionComponent {
  @Input() config !: ContributionViewConfig;
  @Output() updateConfig = new EventEmitter<ContributionViewConfig>()
  comment: string = '';
  isModalOpen: boolean = false;
  action: 'accept' | 'reject' = 'accept'; 

  constructor(private contributionService: ContributionService, private router :Router) { }


  assignSeltToContribution() {
    this.contributionService.assignSelfToContribution(this.config.id).subscribe({
      next: () => {
        this.config.isReview = true;
        this.sendConfigUpdate();
      },
      error: (err: Error) => {
        console.error("Erreur lors de l'affectation :", err);      
        this.router.navigate(['error']);
      }
    })
  }

  sendConfigUpdate() {
    this.updateConfig.emit(this.config)
  }

  openConfirmModal(action: 'accept' | 'reject') {
    if (action === 'reject' && !this.comment) {
      alert('Le commentaire est obligatoire lorsque la contribution est refusée.');
      return;
    }

    this.action = action;
    this.isModalOpen = true;
   
  }

  handleModalAction(confirm: boolean) {
    if (confirm) {
      let review: ContributionReview = {
        contributionId: this.config.id,
        isAccepted: false,
        comment: this.comment
      }
      if (this.action === 'accept') {
        review.isAccepted = true;
      }
     

      this.contributionService.reviewContribution(review).subscribe({
        next: () => {
          this.router.navigate(['contribution-management']);
        },
        error: (err : Error) => {
          console.error("Erreur lors de l'affectation :", err);
          this.router.navigate(['error']);
        }
      })
    }

    this.isModalOpen = false; // Ferme la modale

  }

}
