import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { PrismaModule } from '../prisma/prisma.module';
import { UserModule } from './user/user.module';
import { PersonModule } from './person/person.module';
import { NaturalPersonModule } from './natural-person/natural-person.module';

@Module({
  imports: [PrismaModule, UserModule, PersonModule, NaturalPersonModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
