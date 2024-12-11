import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import {ApiService} from '../api/api.service'; 

@Injectable({
  providedIn: 'root'
})
export class PortraitService {

  constructor(private http: HttpClient, private api: ApiService) { }

  getPortraits(): Observable<any> {
    return this.http.get(this.api.apiUrl + '/Portrait');
  }
}
