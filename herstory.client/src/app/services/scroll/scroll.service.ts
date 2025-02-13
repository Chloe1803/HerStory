import { Injectable } from '@angular/core';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ScrollService {
  // Utilisation d'un Subject pour émettre l'événement de scroll
  private scrollSubject = new Subject<Event>();
  scroll$ = this.scrollSubject.asObservable();

  // Méthode pour émettre l'événement de scroll
  emitScrollEvent(event: Event): void {
    this.scrollSubject.next(event);
  }
}
