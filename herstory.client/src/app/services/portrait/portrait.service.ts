import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiService } from '../api/api.service';
import { PortraitCard, PortraitDetail, Category, Field, FilterCriteria } from '../../interfaces/portrait';

@Injectable({
  providedIn: 'root'
})
export class PortraitService {

  constructor(private http: HttpClient, private api: ApiService) { }

  getPortraits(): Observable<PortraitCard[]> {
    return this.http.get<PortraitCard[]>(this.api.apiUrl + '/Portrait');
  }

  getPortraitById(id: number): Observable<PortraitDetail> {
    return this.http.get<PortraitDetail>(this.api.apiUrl + '/Portrait/' + id);
  }

  getCategories(): Observable<Category[]> {
    return this.http.get<Category[]>(this.api.apiUrl + '/Portrait/categories');
  }

  getFields(): Observable<Field[]> {
    return this.http.get<Field[]>(this.api.apiUrl + '/Portrait/fields');
  }

  searchPortrait(term: string): Observable<PortraitCard[]> {
    const params = new HttpParams().set('term', term);

    return this.http.get<PortraitCard[]>(this.api.apiUrl + '/Portrait/search', { params });
  }

  getFilteredPortraits(criteria: FilterCriteria): Observable<PortraitCard[]> {
    return this.http.post<PortraitCard[]>(`${this.api.apiUrl}/Portrait/filtre`, criteria);
  }
}
