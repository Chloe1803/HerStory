import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ApiService } from '../api/api.service';
import { Observable } from 'rxjs';
import { ProfileUser } from '../../interfaces/user';
import { RoleChangeResponse } from '../../interfaces/role-change';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private api: ApiService, private http: HttpClient) { }

  getProfile(): Observable<ProfileUser>{
    return this.http.get<ProfileUser>(this.api.apiUrl + '/User/profile');

  }

  getPendingRoleRequest(): Observable<any>{
    return this.http.get<any>(this.api.apiUrl + '/RoleChange/pending');
  }

  respondRoleRequest(id: number, response: RoleChangeResponse): Observable<any> {
  return this.http.post<any>(this.api.apiUrl + '/RoleChange/' + id +'/response', response);
  }

  requestNextRole(): Observable<any> {
    return this.http.post<any>(this.api.apiUrl + '/RoleChange/request-next', {});
  }
}
