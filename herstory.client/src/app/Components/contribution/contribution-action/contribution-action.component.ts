import { Component, Input, EventEmitter, Output } from '@angular/core';
import {Router } from '@angular/router'
import { ContributionViewConfig } from '../../../interfaces/contribution'
import {ContributionService } from '../../../services/contribution/contribution.service'


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
      error: () =>{
        console.error("Erreur lors de l'affectation ");      
        this.router.navigate(['contribution-management']);
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
    if (action === 'accept') {
   // Désactive le champ de commentaire si l'action est acceptée
    }
  }

  handleModalAction(confirm: boolean) {
    if (confirm) {
      if (this.action === 'accept') {
        // Logique pour accepter la contribution
        console.log('Contribution acceptée');
      } else if (this.action === 'reject') {
        // Logique pour refuser la contribution avec le commentaire
        console.log('Contribution refusée avec commentaire :', this.comment);
      }
    }

    this.isModalOpen = false; // Ferme la modale

  }

}
