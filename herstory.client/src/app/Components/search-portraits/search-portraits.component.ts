import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PortraitCardComponent } from '../portrait/portrait-card/portrait-card.component';
import { PortraitCard } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';
import { SpinnerComponent } from '../spinner/spinner.component';
import { HttpErrorResponse } from '@angular/common/http';


@Component({
  selector: 'app-search-portraits',
  standalone: true,
  imports: [PortraitCardComponent, CommonModule, SpinnerComponent],
  templateUrl: './search-portraits.component.html',
  styleUrl: './search-portraits.component.css'
})
export class SearchPortraitsComponent {
  resultPortraits: PortraitCard[] = [];
  isLoading = false;
  errorMessage: string | null = null;
  constructor(private portraitService: PortraitService) { }

  onSearch(term: string) {
    if (!term.trim()) {
      this.resultPortraits = [];
      return;
    }

    this.isLoading = true;

    this.portraitService.searchPortrait(term).subscribe({
      next: (portraits) => {
        this.resultPortraits = portraits;
        this.isLoading = false;
      },
      error: (error: HttpErrorResponse) => {
        this.resultPortraits = [];
        this.isLoading = false;

        if (error.status !== 404) {
          this.errorMessage = "Une erreur est survenue. Veuillez réessayer plus tard.";
        }
      }
    });
  }
}
