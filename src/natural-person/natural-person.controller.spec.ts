import { Test, TestingModule } from '@nestjs/testing';
import { NaturalPersonController } from './natural-person.controller';

describe('NaturalPersonController', () => {
  let controller: NaturalPersonController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [NaturalPersonController],
    }).compile();

    controller = module.get<NaturalPersonController>(NaturalPersonController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
