import { Controller, Get, Param } from '@nestjs/common';
import { NaturalPersonService } from './natural-person.service';

@Controller('pessoa-fisica')
export class NaturalPersonController {

    constructor(private readonly naturalPersonService: NaturalPersonService) {}
    
        // Rota para buscar um usuário por id
        @Get(':id')
        async findById(@Param('id') id: string) {
            return this.naturalPersonService.getModel(id);
        }

            // Rota para buscar um usuário por id
        @Get('/cpf/:id')
        async findBySerialNumber(@Param('id') id: string) {
            return this.naturalPersonService.getPersonCpf(id);
        }
}
