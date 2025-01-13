import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { FilterCriteria } from '../../interfaces/portrait';

@Injectable({
  providedIn: 'root'
})
export class FilterService {
  // Un BehaviorSubject partage l'état des filtres sous forme de FilterCriteria
  private filtersSubject = new BehaviorSubject<FilterCriteria>({
    categories: [],  
    fields: []       
  });
  // Gestion de l'état "isFilterActive"
  private isFilterActiveSubject = new BehaviorSubject<boolean>(false);
  isFilterActive$ = this.isFilterActiveSubject.asObservable();

  // Observable pour que les composants puissent s'abonner aux filtres
  filters$ = this.filtersSubject.asObservable();

  constructor() { }

  // Applique de nouveaux filtres
  applyFilters(filterCriteria: FilterCriteria) {
    this.filtersSubject.next(filterCriteria);

    const isActive = this.isFilterCriteriaActive(filterCriteria);
    this.isFilterActiveSubject.next(isActive);
  }

  // Réinitialise les filtres
  resetFilters() {
    this.filtersSubject.next({
      categories: [],
      fields: []
    });
    this.isFilterActiveSubject.next(false);
  }

  // Méthode pour vérifier si un filtre est actif
  private isFilterCriteriaActive(filterCriteria: FilterCriteria): boolean {
    return (
      (filterCriteria.categories && filterCriteria.categories.length > 0) ||
      (filterCriteria.fields && filterCriteria.fields.length > 0)
    );
  }
}
