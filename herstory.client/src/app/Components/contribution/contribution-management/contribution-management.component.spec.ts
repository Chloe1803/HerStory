import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ContributionManagementComponent } from './contribution-management.component';

describe('ContributionManagementComponent', () => {
  let component: ContributionManagementComponent;
  let fixture: ComponentFixture<ContributionManagementComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ContributionManagementComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ContributionManagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
