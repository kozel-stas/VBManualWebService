package services;

import model.Article;
import model.Author;
import model.Topic;

public class RequestResponseConverter {

    Author convertFrom(rpc.service.gen.Author author) {
        return new Author(author.authorId, author.firstName, author.lastName, author.speciality);
    }

    rpc.service.gen.Author convertFrom(Author author) {
        return new rpc.service.gen.Author().setAuthorId(author.getId()).setFirstName(author.getFirstName())
                .setLastName(author.getLastName()).setSpeciality(author.getSpeciality());
    }

    Topic convertFrom(rpc.service.gen.Topic topic) {
        return new Topic(topic.topicId, topic.topicName, convertFrom(topic.author));
    }

    Article convertFrom(rpc.service.gen.Article article) {
        return new Article(article.articleId, article.articleName, article.content, convertFrom(article.author));
    }
}
