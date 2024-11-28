import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PortraitDetailsComponent } from './portrait-details.component';

describe('PortraitDetailsComponent', () => {
  let component: PortraitDetailsComponent;
  let fixture: ComponentFixture<PortraitDetailsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [PortraitDetailsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PortraitDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
