package rpc.service;

import com.google.common.base.Preconditions;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import core.services.DataLoader;

import java.util.concurrent.ExecutionException;

class RequestResponseConverter {

    private final DataLoader dataLoader;

    RequestResponseConverter(DataLoader dataLoader) {
        this.dataLoader = dataLoader;
    }

    Article convertFrom(rpc.service.gen.Article article, String topicId) {
        return new Article(
                article.articleId,
                article.articleName,
                article.content,
                article.author.authorId,
                topicId
        );
    }

    void validateTopicId(String topicId) throws ExecutionException {
        Preconditions.checkNotNull(dataLoader.loadTopic(topicId), "Don't have topics with this ID.");
    }

    Article convertFromWithCheck(rpc.service.gen.Article article, String topicId) throws ExecutionException {
        Preconditions.checkNotNull(dataLoader.loadAuthor(article.author.authorId), "Don't have authors with this ID.");
        return convertFrom(article, topicId);
    }

    rpc.service.gen.Article convertFrom(Article article) throws ExecutionException {
        Author author = Preconditions.checkNotNull(dataLoader.loadAuthor(article.getAuthorId()));
        return new rpc.service.gen.Article()
                .setArticleName(article.getName()).setAuthor(convertFrom(author))
                .setContent(article.getContent()).setArticleId(article.getId());
    }

    Author convertFrom(rpc.service.gen.Author author) {
        return new Author(
                author.authorId,
                author.firstName,
                author.lastName,
                author.speciality
        );
    }

    Author convertFromWithCheck(rpc.service.gen.Author author) throws ExecutionException {
        Preconditions.checkNotNull(dataLoader.loadAuthor(author.authorId), "Don't have authors with this ID.");
        return convertFrom(author);
    }

    rpc.service.gen.Author convertFrom(Author author) {
        return new rpc.service.gen.Author()
                .setFirstName(author.getFirstName()).setLastName(author.getLastName())
                .setAuthorId(author.getId()).setSpeciality(author.getSpeciality());
    }

    Topic convertFrom(rpc.service.gen.Topic topic) {
        return new Topic(
                topic.topicId,
                topic.topicName,
                topic.author.authorId
        );
    }

    Topic convertFromWithCheck(rpc.service.gen.Topic topic) throws ExecutionException {
        Preconditions.checkNotNull(dataLoader.loadAuthor(topic.author.authorId), "Don't have authors with this ID.");
        return convertFrom(topic);
    }

    rpc.service.gen.Topic convertFrom(Topic topic) throws ExecutionException {
        Author author = Preconditions.checkNotNull(dataLoader.loadAuthor(topic.getAuthorId()));
        return new rpc.service.gen.Topic()
                .setTopicName(topic.getName()).setAuthor(convertFrom(author))
                .setTopicId(topic.getId());
    }

}
