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

  constructor(
    private contributionService: ContributionService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.contributionService.getAllUserContribution().subscribe({
      next: (data) => {
        this.userContributions = data;
        console.log(this.userContributions);
      },
      error: () => {
        console.log("Une erreur est survenue");
      },
    });
  }

  navigateToView(id: number): void {
    this.router.navigate(['my-contribution', id]);
  }
}
