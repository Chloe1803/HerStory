import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SearchPortraitsComponent } from './search-portraits.component';

describe('SearchPortraitsComponent', () => {
  let component: SearchPortraitsComponent;
  let fixture: ComponentFixture<SearchPortraitsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [SearchPortraitsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SearchPortraitsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
