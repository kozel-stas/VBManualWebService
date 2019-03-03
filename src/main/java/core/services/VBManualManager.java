package core.services;

import core.model.Article;
import core.model.Author;
import core.model.Topic;

import java.util.Set;

public interface VBManualManager {

    Author getAuthor(String authorID);

    boolean addAuthor(Author author);

    Set<Topic> getTopics();

    Set<Article> getArticles(String topicId);

    boolean deleteArticle(String topicId, String articleId);

    boolean updateArticle(Article article);

    boolean addArticle(Article article);

    boolean addTopic(Topic topic);

    boolean deleteTopic(String topicId, Author author);

}
