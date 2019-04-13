package soap.service;

import core.model.Article;
import core.model.Author;
import core.model.Topic;
import core.services.DataLoader;

import java.util.concurrent.ExecutionException;

class RequestValidatorConverter {

    private final DataLoader dataLoader;

    RequestValidatorConverter(DataLoader dataLoader) {
        this.dataLoader = dataLoader;
    }

    public Author validateAuthor(Author author) {
        return new Author(
                checkNotNull(author.getId(), "ID can't be NULL."),
                checkNotNull(author.getFirstName(), "Author should have name."),
                checkNotNull(author.getLastName(), "Author should have name."),
                checkNotNull(author.getSpeciality(), "Author should have speciality.")
        );
    }

    public Author convertFrom(soap.model.Author author) {
        return new Author(author.getId(), author.getFirstName(), author.getLastName(), author.getSpeciality());
    }

    public soap.model.Author convertFrom(Author author) {
        return new soap.model.Author(author.getId(), author.getFirstName(), author.getLastName(), author.getSpeciality());
    }

    public soap.model.Topic convertFrom(Topic topic) {
        return new soap.model.Topic(topic.getId(), topic.getName(), convertFrom(dataLoader.loadAuthor(topic.getAuthorId())));
    }

    public Topic convertFrom(soap.model.Topic topic) {
        return new Topic(topic.getId(), topic.getName(), topic.getAuthor().getId());
    }

    public soap.model.Article convertFrom(Article article) {
        return new soap.model.Article(article.getId(), article.getName(), article.getContent(), convertFrom(dataLoader.loadAuthor(article.getAuthorId())));
    }

    public Article convertFrom(String topicId, soap.model.Article article) {
        return new Article(article.getId(), article.getName(), article.getContent(), article.getAuthor().getId(), topicId);
    }

    public Article validateArticle(Article article) {
        return new Article(
                checkNotNull(article.getId(), "ID can't be NULL."),
                checkNotNull(article.getName(), "Article should have name."),
                checkNotNull(article.getContent(), "Article should have name."),
                checkNotNull(article.getAuthorId(), "Article should have speciality."),
                checkNotNull(article.getTopicId(), "Article should have speciality.")
        );
    }

    public Topic validateTopic(Topic topic) {
        return new Topic(
                checkNotNull(topic.getId(), "ID can't be NULL."),
                checkNotNull(topic.getName(), "Article should have name."),
                checkNotNull(topic.getAuthorId(), "Article should have speciality.")
        );
    }

    public void validateTopicId(String topicId) {
        if (topicId == null || topicId.isEmpty() || dataLoader.loadTopic(topicId) == null) {
            throw new IllegalStateException("Topic [" + topicId + "] is absent.");
        }
    }

    public void validateAuthorId(String authorId) {
        if (authorId == null || authorId.isEmpty() || dataLoader.loadAuthor(authorId) == null) {
            throw new IllegalStateException("Author is absent.");
        }
    }

    public void validateArticleId(String articleId) {
        if (articleId == null || articleId.isEmpty() || dataLoader.loadArticle(articleId) == null) {
            throw new IllegalStateException("Article is absent.");
        }
    }

    public static <T> T checkState(boolean ref, T t, String errorMsg) {
        if (!ref) {
            throw new IllegalStateException(errorMsg);
        }
        return t;
    }

    public static <T> T checkNotNull(T t, String errorMsg) {
        if (t == null) {
            throw new IllegalStateException(errorMsg);
        }
        return t;
    }

}
