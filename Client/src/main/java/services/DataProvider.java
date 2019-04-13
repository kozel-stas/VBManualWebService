package services;

import model.Article;
import model.Author;
import model.Topic;
import view.ErrorListener;

import java.util.List;

public interface DataProvider {

    void init(ErrorListener errorListener) throws Exception;

    List<Author> getAuthors(int offset, int limit);

    Author getAuthor(String authorId);

    int getAuthorTotalNumber();

    Author registerAuthor(Author author);

    List<Topic> getTopics(int offset, int limit);

    Topic getTopic(String topicID);

    int getTopicTotalNumber();

    List<Article> getArticles(String topicID, int offset, int limit);

    Article getArticle(String articleID, String topicID);

    int getArticleTotalNumber(String topicId);

    Topic addTopic(Topic topic);

    void deleteTopic(Topic topic);

    Article addArticle(String topicID, Article article);

    Article updateArticle(String topicID, Article article);

    void deleteArticle(String topicId, String articleId);

}
