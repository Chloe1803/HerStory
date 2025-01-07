import { Component, Input } from '@angular/core';
import {CommonModule} from '@angular/common'; 
import { PortraitCard } from '../../../interfaces/portrait';
import { Router } from '@angular/router';

@Component({
  selector: 'app-portrait-card',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './portrait-card.component.html',
  styleUrl: './portrait-card.component.css'
})
export class PortraitCardComponent {
  
  @Input() portrait!: PortraitCard;

  constructor(private router: Router) { }

  viewPortrait(): void {
    this.router.navigate(['/portrait', this.portrait.id]);
  }

  getLifeSpan(birthDate: string | Date | null, deathDate: string | Date | null): string {
    const invalidDateString = "01/01/1"; // Valeur par défaut invalide
    const parseDate = (date: string | Date | null): Date | null => {
      if (!date) return null;
      if (typeof date === "string") date = new Date(date);
      return date instanceof Date && !isNaN(date.getTime()) ? date : null;
    };

    const isValidDate = (date: Date | null): boolean => {
      if (!date) return false;
      const formattedDate = `${String(date.getDate()).padStart(2, '0')}/${String(date.getMonth() + 1).padStart(2, '0')}/${date.getFullYear()}`;
      return formattedDate !== invalidDateString;
    };

    const birth = parseDate(birthDate);
    const death = parseDate(deathDate);

    if (!isValidDate(birth)) return "Date de naissance inconnue"; // Si la date de naissance est invalide
    const birthYear = birth!.getFullYear();

    if (isValidDate(death)) {
      const deathYear = death!.getFullYear();
      return `${birthYear} - ${deathYear}`;
    }

    return `${birthYear}`; // Retourne uniquement l'année de naissance si pas de décès valide
  }


}
