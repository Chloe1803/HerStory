import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiService } from '../api/api.service';
import {NewContribution} from '../../interfaces/contribution'; 

@Injectable({
  providedIn: 'root'
})
export class ContributionService {

  constructor(private http: HttpClient, private api: ApiService) { }

  submitContribution(contribution: NewContribution): any {
    return this.http.post(this.api.apiUrl + '/Contribution', contribution);
  }


}
