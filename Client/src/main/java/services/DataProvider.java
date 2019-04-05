package services;

import model.Article;
import model.Author;
import model.Topic;
import view.ErrorListener;

import java.util.List;

public interface DataProvider {

    void init(ErrorListener errorListener) throws Exception;

    List<Author> getAuthors();

    Author registerAuthor(Author author);

    List<Topic> getTopics();

    List<Article> getArticles(String topicID);

    Topic addTopic(Topic topic);

    void deleteTopic(Topic topic);

    Article addArticle(String topicID, Article article);

    Article updateArticle(String topicID, Article article);

    void deleteArticle(String topicId, String articleId);

}
