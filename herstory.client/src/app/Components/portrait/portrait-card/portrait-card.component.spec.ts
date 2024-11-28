import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PortraitCardComponent } from './portrait-card.component';

describe('PortraitCardComponent', () => {
  let component: PortraitCardComponent;
  let fixture: ComponentFixture<PortraitCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [PortraitCardComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PortraitCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
