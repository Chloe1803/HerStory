import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PortraitService {

  private apiUrl = 'http://localhost:5103/api/Portrait';
  constructor(private http: HttpClient) { }

  getPortraits(): Observable<any> {
    return this.http.get(this.apiUrl);
  }
}
