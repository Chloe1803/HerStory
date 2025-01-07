import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FilterPortraitsComponent } from './filter-portraits.component';

describe('FilterPortraitsComponent', () => {
  let component: FilterPortraitsComponent;
  let fixture: ComponentFixture<FilterPortraitsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [FilterPortraitsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FilterPortraitsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
