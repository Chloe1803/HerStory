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
}
