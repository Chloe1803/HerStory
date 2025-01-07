import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ContributionService } from '../../../services/contribution/contribution.service';
import { UserContributionView } from '../../../interfaces/contribution';
import { ContributionDetailFieldName } from '../../../constants/contribution-field-name';
import { StatusConstants } from '../../../constants/contribution-status';

@Component({
  selector: 'app-user-contribution-view',
  templateUrl: './user-contribution-view.component.html',
  styleUrls: ['./user-contribution-view.component.css']
})
export class UserContributionViewComponent implements OnInit {
  userContribution!: UserContributionView ;
  userId: number | undefined;
  isNewPortrait = true;
  field = ContributionDetailFieldName;
  status = StatusConstants;

  constructor(
    private userContributionService: ContributionService,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    // Récupérer l'ID de l'URL
    this.route.params.subscribe(params => {
      this.userId = +params['id'];
      if (this.userId) {
        this.getUserContributionDetails(this.userId);
      }
    });
  }

  // Appel du service pour obtenir les détails de la contribution
  getUserContributionDetails(id: number): void {
    this.userContributionService.getUserContributionById(id).subscribe({
      next: (data : UserContributionView) => {
        this.userContribution = data;
        if (this.userContribution.portrait) {
          this.isNewPortrait = false;
        }
      },
      error: (err : Error) => {
        console.error(err);
      }
    });
  }

  getContributionDetail(fieldName: ContributionDetailFieldName): string | null {
    const detail = this.userContribution.details.find(d => d.fieldName === fieldName);
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

  
}

