import { Injectable } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';

@Injectable()
export class PersonService {

    constructor(private prisma: PrismaService) {}

    // person.service.ts

    async getModel(id: string) {
        return this.prisma.person.findUnique({
            where: { id },
        });
    }


    async createPersonWithNaturalPerson(data: {
    email?: string; // Se Person tiver email (ajuste conforme seu schema)
    name: string;
    CPF: string;
    birth: Date;
  }) {
    return this.prisma.person.create({
      data: {
        // Criação simultânea de NaturalPerson
        naturalPerson: {
          create: {
            name: data.name,
            CPF: data.CPF,
            birth: data.birth,
          },
        },
      },
      include: {
        naturalPerson: true, // Retorna a Person com NaturalPerson
      },
    });
  }
}
