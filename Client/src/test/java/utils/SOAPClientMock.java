package utils;

import com.service.axis.manual.vb.VBManualManagerSOAPStub;
import org.apache.axis2.AxisFault;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class SOAPClientMock extends VBManualManagerSOAPStub {
    private long id = 0;
    private List<Author> authors = new ArrayList<>();
    private Map<String, List<Article>> articles = new HashMap<>();
    private List<Topic> topics = new ArrayList<>();

    public SOAPClientMock() throws AxisFault {
    }

    @Override
    public GetTopicsResponse getTopics(GetTopics getTopics5) throws RemoteException {
        GetTopicsResponse topicsResponse = new GetTopicsResponse();
        topicsResponse.set_return(topics.toArray(new Topic[0]));
        return topicsResponse;
    }

    @Override
    public GetAuthorsResponse getAuthors(GetAuthors getAuthors9) throws RemoteException {
        GetAuthorsResponse authorsResponse = new GetAuthorsResponse();
        authorsResponse.set_return(authors.toArray(new Author[0]));
        return authorsResponse;
    }

    @Override
    public GetArticlesResponse getArticles(GetArticles getArticles0) throws RemoteException {
        GetArticlesResponse articlesResponse = new GetArticlesResponse();
        articlesResponse.set_return(articles.getOrDefault(getArticles0.getTopicId(), Collections.emptyList()).toArray(new Article[0]));
        return articlesResponse;
    }

    @Override
    public void addArticle(AddArticle addArticle7) throws RemoteException {
        articles.computeIfAbsent(addArticle7.getTopicID(), val -> new ArrayList<>());
        addArticle7.getArticle().setId(++id + "");
        articles.get(addArticle7.getTopicID()).add(addArticle7.getArticle());
    }

    @Override
    public void addAuthor(AddAuthor addAuthor2) throws RemoteException {
        addAuthor2.getAuthor().setId(++id + "");
        authors.add(addAuthor2.getAuthor());
    }

    @Override
    public void addTopic(AddTopic addTopic11) throws RemoteException {
        addTopic11.getTopic().setId(++id + "");
        topics.add(addTopic11.getTopic());
    }

    @Override
    public void deleteArticle(DeleteArticle deleteArticle3) throws RemoteException {
        List<Article> toDelete = articles.getOrDefault(deleteArticle3.getTopicId(), Collections.emptyList()).stream().filter(val -> val.getId().equals(deleteArticle3.getArticleId())).collect(Collectors.toList());
        if (!toDelete.isEmpty()) {
            articles.get(deleteArticle3.getTopicId()).removeAll(toDelete);
            return;
        }
        throw new RuntimeException("No such article");
    }

    @Override
    public void deleteTopic(DeleteTopic deleteTopic8) throws RemoteException {
        List<Topic> toDelete = topics.stream().filter(val -> val.getId().equals(deleteTopic8.getTopicId())).collect(Collectors.toList());
        if (!toDelete.isEmpty()) {
            topics.removeAll(toDelete);
            articles.remove(deleteTopic8.getTopicId());
            return;
        }
        throw new RuntimeException("No such topic");
    }

    @Override
    public void updateArticle(UpdateArticle updateArticle4) throws RemoteException {
        List<Article> toUpdate = articles.getOrDefault(updateArticle4.getTopicID(), Collections.emptyList()).stream().filter(val -> val.getId().equals(updateArticle4.getArticle().getId())).collect(Collectors.toList());
        if (!toUpdate.isEmpty()) {
            articles.get(updateArticle4.getTopicID()).removeAll(toUpdate);
            articles.get(updateArticle4.getTopicID()).add(updateArticle4.getArticle());
            return;
        }
        throw new RuntimeException("No such article");
    }

}
