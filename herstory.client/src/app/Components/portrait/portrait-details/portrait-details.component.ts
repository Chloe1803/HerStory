import { Component } from '@angular/core';

@Component({
  selector: 'app-portrait-details',
  templateUrl: './portrait-details.component.html',
  styleUrl: './portrait-details.component.css'
})
export class PortraitDetailsComponent {
  portrait = {
    ID: 1,
    FirstName: 'Ada',
    LastName: 'Lovelace',
    BirthDate: '1815-1852',
    DeathDate: '',
    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Ada_Lovelace_portrait.jpg',
    BiographyAbstract: 'Ada Lovelace was an English mathematician and writer, chiefly known for her work on Charles Babbage\'s early mechanical general-purpose computer, the Analytical Engine.',
    Biography: 'Ada Lovelace was an English mathematician and writer, chiefly known for her work on Charles Babbage\'s early mechanical general-purpose computer, the Analytical Engine. Her notes on the engine include what is recognised as the first algorithm intended to be processed by a machine. Because of this, she is often considered the first computer programmer.'
  }
}
