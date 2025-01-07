import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiService } from '../api/api.service';
import { NewContribution, ContributionList, Contribution, ContributionReview, UserContributionList, UserContributionView } from '../../interfaces/contribution'; 

@Injectable({
  providedIn: 'root'
})
export class ContributionService {

  constructor(private http: HttpClient, private api: ApiService) { }

  submitContribution(contribution: NewContribution): any {
    return this.http.post(this.api.apiUrl + '/Contribution', contribution);
  }

  getUnassignedPendingContribution(): Observable<ContributionList[]> {
    return this.http.get<ContributionList[]>(this.api.apiUrl + '/Contribution/pending')
  }

  getPendingContributionAssignedToUser(): Observable<ContributionList[]> {
    return this.http.get<ContributionList[]>(this.api.apiUrl + '/Contribution/pendingAssigned')
  }

  assignSelfToContribution(contributionId: number): any {
    return this.http.post(this.api.apiUrl + '/Contribution/' + contributionId+'/reviewer', null)
  }

  unassignSelfToContribution(contributionId: number): any {
    return this.http.delete(this.api.apiUrl + '/Contribution/' + contributionId + '/reviewer')
  }

  getContribution(contributionId: number): Observable<Contribution> {
    return this.http.get<Contribution>(this.api.apiUrl + '/Contribution/' + contributionId)
  }

  reviewContribution(review: ContributionReview): any {
    return this.http.put(this.api.apiUrl + '/Contribution/review', review)
  }

  getAllUserContribution(): Observable<UserContributionList[]> {
    return this.http.get<UserContributionList[]>(this.api.apiUrl + '/Contribution/user')
  }

  getUserContributionById(id: number): Observable<UserContributionView> {
    return this.http.get<UserContributionView>(this.api.apiUrl + '/Contribution/user/'+ id)
  }
}
