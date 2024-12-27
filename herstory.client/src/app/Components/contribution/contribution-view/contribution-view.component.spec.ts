import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContributionViewComponent } from './contribution-view.component';

describe('ContributionViewComponent', () => {
  let component: ContributionViewComponent;
  let fixture: ComponentFixture<ContributionViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ContributionViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContributionViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
