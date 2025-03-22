import { Injectable } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';

@Injectable()
export class NaturalPersonService {

    
        constructor(private prisma: PrismaService) {}

        async getModel(id: string) {
            return this.prisma.naturalPerson.findUnique({
                where: { id },
            });
        }

            async getPersonCpf(cpf: string) {
                return this.prisma.naturalPerson.findUnique({
                    where: { CPF : cpf},
                });
    }
    
}
