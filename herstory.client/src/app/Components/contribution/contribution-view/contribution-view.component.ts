import { Component } from '@angular/core';
import { Location } from '@angular/common';
import { Contribution, ContributionViewConfig } from '../../../interfaces/contribution';
import { ContributionService } from '../../../services/contribution/contribution.service';
import { ContributionDetailFieldName } from '../../../constants/contribution-field-name';
import { ContributionActionComponent } from '../contribution-action/contribution-action.component';
import {Router } from '@angular/router'


@Component({
  selector: 'app-contribution-view',
  templateUrl: './contribution-view.component.html',
  styleUrl: './contribution-view.component.css'
})
export class ContributionViewComponent {
  config!: ContributionViewConfig;
  contribution !: Contribution;
  field = ContributionDetailFieldName;
  isLoading = true;
  errorMessage: string | null = null;
  constructor(private contributionService: ContributionService, private location: Location, private router : Router) { }

  ngOnInit() {
   
    this.config = this.location.getState() as ContributionViewConfig;
 

    this.contributionService.getContribution(this.config.id).subscribe({
      next: (data) => {
        this.contribution = data;
        this.isLoading = false;
      },
      error: (err) => {
        console.log(err)
        this.isLoading = false;
        this.errorMessage = "Une erreur est survenue";
      }
    });
  }

  getContributionDetail(fieldName: ContributionDetailFieldName): string | null {
    const detail = this.contribution.details.find(d => d.fieldName === fieldName);
    return detail ? detail.newValue : null;
  }

  parseJsonArray(jsonString: string): string[] {
    try {
      return JSON.parse(jsonString) as string[];
    } catch (error) {
      console.error('Invalid JSON array:', jsonString);
      return [];
    }
  }

  updateConfig(new_config: ContributionViewConfig) {
    this.config = new_config;
  }

}
