package services;

import model.Author;

public class RequestResponseConverter {

    Author convertFrom(rpc.service.gen.Author author) {
        return new Author(author.authorId, author.firstName, author.lastName, author.speciality);
    }

    rpc.service.gen.Author convertFrom(Author author) {
        return new rpc.service.gen.Author().setAuthorId(author.getId()).setFirstName(author.getFirstName())
                .setLastName(author.getLastName()).setSpeciality(author.getSpeciality());
    }

}
