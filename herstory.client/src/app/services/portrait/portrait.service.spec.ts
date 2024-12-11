import { TestBed } from '@angular/core/testing';

import { PortraitService } from './portrait.service';

describe('PortraitService', () => {
  let service: PortraitService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(PortraitService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
