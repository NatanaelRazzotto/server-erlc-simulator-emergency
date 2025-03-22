import { Controller, Get, Param } from '@nestjs/common';
import { PersonService } from './person.service';

@Controller('person')
export class PersonController {
 
    constructor(private readonly personService: PersonService) {}

    // Rota para buscar um usuário por id
    @Get(':id')
    async findById(@Param('id') id: string) {
        return this.personService.getModel(id);
    }
}
