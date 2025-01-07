import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserContributionViewComponent } from './user-contribution-view.component';

describe('UserContributionViewComponent', () => {
  let component: UserContributionViewComponent;
  let fixture: ComponentFixture<UserContributionViewComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [UserContributionViewComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UserContributionViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
