package utils;

import org.apache.thrift.protocol.TProtocol;
import rpc.service.gen.Article;
import rpc.service.gen.Author;
import rpc.service.gen.Topic;
import rpc.service.gen.VBManualService;

import javax.annotation.concurrent.NotThreadSafe;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@NotThreadSafe
public class RPCClientMock extends VBManualService.Client {

    private long id = 0;
    private List<Author> authors = new ArrayList<>();
    private Map<String, List<Article>> articles = new HashMap<>();
    private List<Topic> topics = new ArrayList<>();

    public RPCClientMock(TProtocol prot) {
        super(prot);
    }

    public List<Topic> getTopics() {
        return topics;
    }

    public List<Article> getArticles(String topicId) {
        return articles.getOrDefault(topicId, Collections.emptyList());
    }

    public void deleteArticle(String topicId, String articleId) {
        List<Article> toDelete = articles.getOrDefault(topicId, Collections.emptyList()).stream().filter(val -> val.getArticleId().equals(articleId)).collect(Collectors.toList());
        if (!toDelete.isEmpty()) {
            articles.get(topicId).removeAll(toDelete);
            return;
        }
        throw new RuntimeException("No such article.");
    }

    public void updateArticle(String topicId, Article article) {
        List<Article> toUpdate = articles.getOrDefault(topicId, Collections.emptyList()).stream().filter(val -> val.getArticleId().equals(article.getArticleId())).collect(Collectors.toList());
        if (!toUpdate.isEmpty()) {
            articles.get(topicId).removeAll(toUpdate);
            articles.get(topicId).add(article);
            return;
        }
        throw new RuntimeException("No such article.");
    }

    public void addArticle(String topicId, Article article) {
        articles.computeIfAbsent(topicId, val -> new ArrayList<>());
        articles.get(topicId).add(article.setArticleId(++id + ""));
    }

    public void addTopic(Topic topic) {
        topics.add(topic.setTopicId(++id + ""));
    }

    public void deleteTopic(String topicId, Author author) {
        List<Topic> toDelete = topics.stream().filter(val -> val.getTopicId().equals(topicId)).filter(val -> val.getAuthor().getAuthorId().equals(author.getAuthorId())).collect(Collectors.toList());
        if (!toDelete.isEmpty()) {
            topics.removeAll(toDelete);
            toDelete.forEach(val -> {
                articles.remove(val.getTopicId());
            });
            return;
        }
        throw new RuntimeException("No such topic");
    }

    public void addAuthor(Author author) {
        authors.add(author.setAuthorId(++id + ""));
    }

    public List<Author> getAuthors() {
        return authors;
    }

}
