import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PortraitCardComponent } from '../portrait/portrait-card/portrait-card.component';
import { PortraitCard } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';

@Component({
  selector: 'app-search-portraits',
  standalone: true,
  imports: [PortraitCardComponent, CommonModule],
  templateUrl: './search-portraits.component.html',
  styleUrl: './search-portraits.component.css'
})
export class SearchPortraitsComponent {
  resultPortraits: PortraitCard[] = [];
  loading = false;
  constructor(private portraitService: PortraitService) { }

  onSearch(term: string) {
    if (!term.trim()) {
      this.resultPortraits = [];
      return;
    }

    this.loading = true;

    this.portraitService.searchPortrait(term).subscribe({
      next: (portraits) => {
        this.resultPortraits = portraits;
        this.loading = false;
      },
      error: () => {
        this.resultPortraits = [];
        this.loading = false;
      }
    });
  }
}
