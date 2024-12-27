import { Component } from '@angular/core';
import { Location } from '@angular/common';
import { Contribution, ContributionViewConfig } from '../../../interfaces/contribution';
import { ContributionService } from '../../../services/contribution/contribution.service';
import { ContributionDetailFieldName } from '../../../constants/contribution-field-name';


@Component({
  selector: 'app-contribution-view',
  templateUrl: './contribution-view.component.html',
  styleUrl: './contribution-view.component.css'
})
export class ContributionViewComponent {
  config!: ContributionViewConfig;
  contribution !: Contribution;
  field = ContributionDetailFieldName;
  constructor(private contributionService: ContributionService, private location: Location) { }

  ngOnInit() {
    this.config = this.location.getState() as ContributionViewConfig;

    this.contributionService.getContribution(this.config.id).subscribe({
      next: (data) => {
        this.contribution = data;
      },
      error: (err) => {
        console.log(err)
      }
    });
  }

  getContributionDetail(fieldName: ContributionDetailFieldName): string | null {
    const detail = this.contribution.details.find(d => d.fieldName === fieldName);
    return detail ? detail.newValue : null;
  }
}
