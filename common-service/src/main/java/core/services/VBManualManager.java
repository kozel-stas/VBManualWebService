package core.services;

import core.model.Article;
import core.model.Author;
import core.model.Topic;

import java.util.List;
import java.util.Set;

public interface VBManualManager {

    List<Author> getAuthors(int offset, int limit);

    Author getAuthor(String authorID);

    int getAuthorTotalNumber();

    boolean addAuthor(Author author);

    Set<Topic> getTopics(int offset, int limit);

    Topic getTopic(String topicID);

    int getTopicTotalNumber();

    Set<Article> getArticles(String topicId, int offset, int limit);

    Article getArticle(String articleID, String topicID);

    int getArticleTotalNumber(String topicId);

    boolean deleteArticle(String topicId, String articleId);

    boolean updateArticle(Article article);

    boolean addArticle(Article article);

    boolean addTopic(Topic topic);

    boolean deleteTopic(String topicId, Author author);

}
