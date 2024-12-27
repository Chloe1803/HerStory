import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContributionActionComponent } from './contribution-action.component';

describe('ContributionActionComponent', () => {
  let component: ContributionActionComponent;
  let fixture: ComponentFixture<ContributionActionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ContributionActionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContributionActionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
