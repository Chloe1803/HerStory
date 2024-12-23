import { Component } from '@angular/core';
import {CommonModule} from '@angular/common'; 
import { PortraitCardComponent } from '../portrait/portrait-card/portrait-card.component';
import { PortraitCard } from '../../interfaces/portrait';
import { PortraitService } from '../../services/portrait/portrait.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [PortraitCardComponent, CommonModule],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  portraits: PortraitCard[] = [];
  constructor(private portraitService: PortraitService) { }

  ngOnInit(): void {
    this.portraitService.getPortraits().subscribe({
      next: (portraits) => {

        this.portraits = portraits;
      },
      error: (err) => {
        console.error('Erreur lors de la récupération des portraits:', err);
      },
    });
  }

 


  //Portraits fictifs
  //portraits: Portrait[] = [
  //  {
  //    ID: 1,
  //    FirstName: 'Ada',
  //    LastName: 'Lovelace',
  //    BirthDate: '1815-1852',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Ada_Lovelace_portrait.jpg',
  //    BiographyAbstract: 'Ada Lovelace was an English mathematician and writer, chiefly known for her work on Charles Babbage\'s early mechanical general-purpose computer, the Analytical Engine.',
  //    Biography: 'Ada Lovelace was an English mathematician and writer, chiefly known for her work on Charles Babbage\'s early mechanical general-purpose computer, the Analytical Engine. Her notes on the engine include what is recognised as the first algorithm intended to be processed by a machine. Because of this, she is often considered the first computer programmer.'
  //  },
  //  {
  //    ID: 2,
  //    FirstName: 'Grace',
  //    LastName: 'Hopper',
  //    BirthDate: '1906-1992',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/a/ad/Commodore_Grace_M._Hopper%2C_USN_%28covered%29.jpg',
  //    BiographyAbstract: 'Grace Brewster Murray Hopper was an American computer scientist and United States Navy rear admiral.',
  //    Biography: 'Grace Brewster Murray Hopper was an American computer scientist and United States Navy rear admiral. One of the first programmers of the Harvard Mark I computer, she was a pioneer of computer programming who invented one of the first compiler related tools. She popularized the idea of machine-independent programming languages, which led to the development of COBOL, an early high-level programming language still in use today.'
  //  },
  //  {
  //    ID: 3,
  //    FirstName: 'Margaret',
  //    LastName: 'Hamilton',
  //    BirthDate: '1936',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Margaret_Hamilton_1995.jpg/800px-Margaret_Hamilton_1995.jpg',
  //    BiographyAbstract: 'Margaret Heafield Hamilton is an American computer scientist, systems engineer, and business owner.',
  //    Biography: 'Margaret Heafield Hamilton is an American computer scientist, systems engineer, and business owner. She was director of the Software Engineering Division of the MIT Instrumentation Laboratory, which developed on-board flight software for the Apollo space program. She later founded two software companies—Higher Order Software in the mid-1970s and Hamilton Technologies in the early 1980s—based on her development work on the Universal Systems Language.'
  //  },
  //  {
  //    ID: 4,
  //    FirstName: 'Katherine',
  //    LastName: 'Johnson',
  //    BirthDate: '1918-2020',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Katherine_Johnson_in_2008.jpg',
  //    BiographyAbstract: 'Katherine Coleman Goble Johnson was an American mathematician whose calculations of orbital mechanics as a NASA employee were critical to the success of the first and subsequent U.S. crewed spaceflights.',
  //    Biography: 'Katherine Coleman Goble Johnson was an American mathematician whose calculations of orbital mechanics as a NASA employee were critical to the success of the first and subsequent U.S. crewed spaceflights. During her 35-year career at NASA and its predecessor, she earned a reputation for mastering complex manual calculations and helped pioneer the use of computers to perform the tasks. The space agency noted her "historical role as one of the first African ...."',
  //  },
  //  {
  //    ID: 5,
  //    FirstName: 'Radia',
  //    LastName: 'Perlman',
  //    BirthDate: '1951',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Radia_Perlman_2009.jpg/800px-Radia_Perlman_2009.jpg',
  //    BiographyAbstract: 'Radia Joy Perlman is an American computer programmer and network engineer.',
  //    Biography: 'Radia Joy Perlman is an American computer programmer and network engineer. She is most famous for her invention of the Spanning Tree Protocol (STP), which is fundamental to the operation of network bridges, while working for Digital Equipment Corporation. She also made large contributions to many other areas of network design and standardization, such as link-state protocols, including TRILL, which she invented to correct some of the shortcomings of spanning-trees.'
  //  },
  //  {
  //    ID: 6,
  //    FirstName: 'Shafi',
  //    LastName: 'Goldwasser',
  //    BirthDate: '1958',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/8/84/Shafi_Goldwasser.JPG',
  //    BiographyAbstract: 'Shafi Goldwasser is an American and Israeli computer scientist, and winner of the Turing Award in 2012.',
  //    Biography: 'Shafi Goldwasser is an American and Israeli computer scientist, and winner of the Turing Award in 2012. She is the RSA Professor of Electrical Engineering and Computer Science at MIT, a professor at the Weizmann Institute of Science, and a co-founder of the cryptography research group at MIT. Her research areas include computational complexity theory, cryptography and computational number theory. She is best known for her work in complexity theory and cryptography.'
  //  },
  //  {
  //    ID: 7,
  //    FirstName: 'Susan',
  //    LastName: 'Kare',
  //    BirthDate: '1954',
  //    DeathDate: '',
  //    PortraitURL: 'https://www.punktional.com/images/saga/article-19/cover.jpg',
  //    BiographyAbstract: 'Susan Kare is an artist and graphic designer who created many of the interface elements for the Apple Macintosh in the 1980s.',
  //    Biography: 'Susan Kare is an artist and graphic designer who created many of the interface elements for the Apple Macintosh in the 1980s. She was also Creative Director (and one of the original employees) at NeXT, the company formed by Steve Jobs after he left Apple in 1985. She is one of the original members of the Apple Macintosh team and is known for creating many of the interface elements for the original Macintosh in the 1980s.'
  //  },
  //  {
  //    ID: 8,
  //    FirstName: 'Sophie',
  //    LastName: 'Wilson',
  //    BirthDate: '1957',
  //    DeathDate: '',
  //    PortraitURL: 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Sophie_Wilson.jpg',
  //    BiographyAbstract: 'Sophie Wilson is a British computer scientist.',
  //    Biography: 'Sophie Wilson is a British computer scientist. She is known for designing the Acorn Micro-Computer, the first of a long line of computers sold by Acorn Computers Ltd, and the instruction set of the ARM processor. She is one of the most influential computer scientists in the UK, having designed the Acorn Micro-Computer, the first of a long line of computers sold by Acorn Computers Ltd, and the instruction set of the ARM processor.'
  //  }
  //];
}
