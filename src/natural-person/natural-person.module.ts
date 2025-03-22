import { Module } from '@nestjs/common';
import { NaturalPersonService } from './natural-person.service';
import { NaturalPersonController } from './natural-person.controller';
import { PrismaModule } from 'prisma/prisma.module';

@Module({
  imports: [PrismaModule],
  providers: [NaturalPersonService],
  controllers: [NaturalPersonController]
})
export class NaturalPersonModule {}
