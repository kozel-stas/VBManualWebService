package services;

import model.Article;
import model.Author;
import model.Topic;
import org.apache.thrift.TException;

import java.util.List;

public interface DataProvider {

    Author getAuthor(String id) throws Exception;

    Author registerAuthor(Author author) throws Exception;

    List<Topic> getTopics() throws Exception;

    List<Article> getArticles(String topicID) throws Exception;

}
