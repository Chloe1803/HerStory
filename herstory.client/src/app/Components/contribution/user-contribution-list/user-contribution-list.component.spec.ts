import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserContributionListComponent } from './user-contribution-list.component';

describe('UserContributionListComponent', () => {
  let component: UserContributionListComponent;
  let fixture: ComponentFixture<UserContributionListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [UserContributionListComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UserContributionListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
