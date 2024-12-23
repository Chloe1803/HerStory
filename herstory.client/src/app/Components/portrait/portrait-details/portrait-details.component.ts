import { Component } from '@angular/core';
import {Router, ActivatedRoute, ParamMap} from '@angular/router'; 
import { PortraitDetail } from '../../../interfaces/portrait';
import { PortraitService } from '../../../services/portrait/portrait.service';
import {AuthService} from '../../../services/authentification/auth.service'; 

@Component({
  selector: 'app-portrait-details',
  templateUrl: './portrait-details.component.html',
  styleUrl: './portrait-details.component.css'
})
export class PortraitDetailsComponent {
  portrait!: PortraitDetail;
  portraitId: number | undefined;

  constructor(private portraitService: PortraitService, private route: ActivatedRoute, private router : Router ,private authService: AuthService) { }

  ngOnInit(): void {
    this.portraitId = this.route.snapshot.params['id'];

    if (this.portraitId) {
      this.portraitService.getPortraitById(this.portraitId).subscribe({
        next: (portrait) => {
          this.portrait = portrait;
        },
        error: (err) => {
          console.error('Erreur lors de la récupération du portrait:', err);
        },
      });
    }
  }

  autorizeContributorsAndUp(): boolean {
    return this.authService.authorizeContributorAndUp();
  }

  navigateToEdit(portrait: PortraitDetail): void {
    this.router.navigate(['new-contribution'], {
      state: { edit: true, portrait }
    });
  }

}
