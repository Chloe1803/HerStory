import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ContributionService } from '../../../services/contribution/contribution.service';
import { UserContributionList } from '../../../interfaces/contribution';
import { StatusConstants } from '../../../constants/contribution-status';

@Component({
  selector: 'app-user-contribution-list',
  templateUrl: './user-contribution-list.component.html',
  styleUrls: ['./user-contribution-list.component.css']
})
export class UserContributionListComponent implements OnInit {
  userContributions: UserContributionList[] = [];
  status = StatusConstants;
  isLoading = true;
  errorMessage: string | null = null;

  constructor(
    private contributionService: ContributionService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.contributionService.getAllUserContribution().subscribe({
      next: (data) => {
        this.userContributions = data;
        this.isLoading = false;
      },
      error: (err : Error) => {
        console.log("Une erreur est survenue  :", err);
        this.isLoading = false;
        this.errorMessage = "Une erreur est survenue";
      },
    });
  }

  navigateToView(id: number): void {
    this.router.navigate(['my-contribution', id]);
  }
}
