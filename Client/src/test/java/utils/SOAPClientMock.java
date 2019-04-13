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
    public GetAuthorResponse getAuthor(GetAuthor getAuthor22) throws RemoteException {
        List<Author> authors = this.authors.stream().filter(val -> val.getId().equals(getAuthor22.getAuthorID())).collect(Collectors.toList());
        if (!authors.isEmpty()) {
            GetAuthorResponse getAuthorResponse = new GetAuthorResponse();
            getAuthorResponse.set_return(authors.get(0));
            return getAuthorResponse;
        }
        return new GetAuthorResponse();
    }

    @Override
    public GetArticleResponse getArticle(GetArticle getArticle20) throws RemoteException {
        List<Article> articles = this.articles.getOrDefault(getArticle20.getTopicId(), Collections.emptyList()).stream().filter(val -> val.getId().equals(getArticle20.getArticleId())).collect(Collectors.toList());
        if (!articles.isEmpty()) {
            GetArticleResponse getArticleResponse = new GetArticleResponse();
            getArticleResponse.set_return(articles.get(0));
            return getArticleResponse;
        }
        return new GetArticleResponse();
    }

    @Override
    public GetTopicResponse getTopic(GetTopic getTopic13) throws RemoteException {
        List<Topic> topics = this.topics.stream().filter(val -> val.getId().equals(getTopic13.getTopicId())).collect(Collectors.toList());
        if (!topics.isEmpty()) {
            GetTopicResponse getTopicResponse = new GetTopicResponse();
            getTopicResponse.set_return(topics.get(0));
            return getTopicResponse;
        }
        return new GetTopicResponse();
    }

    @Override
    public GetTopicTotalNumberResponse getTopicTotalNumber(GetTopicTotalNumber getTopicTotalNumber4) throws RemoteException {
        GetTopicTotalNumberResponse getTopicTotalNumberResponse = new GetTopicTotalNumberResponse();
        getTopicTotalNumberResponse.set_return(topics.size());
        return getTopicTotalNumberResponse;
    }

    @Override
    public GetArticleTotalNumberResponse getArticleTotalNumber(GetArticleTotalNumber getArticleTotalNumber0) throws RemoteException {
        GetArticleTotalNumberResponse getArticleTotalNumberResponse = new GetArticleTotalNumberResponse();
        getArticleTotalNumberResponse.set_return(articles.getOrDefault(getArticleTotalNumber0.getTopicId(), Collections.emptyList()).size());
        return getArticleTotalNumberResponse;
    }

    @Override
    public GetAuthorTotalNumberResponse getAuthorTotalNumber(GetAuthorTotalNumber getAuthorTotalNumber10) throws RemoteException {
        GetAuthorTotalNumberResponse getAuthorTotalNumberResponse = new GetAuthorTotalNumberResponse();
        getAuthorTotalNumberResponse.set_return(authors.size());
        return getAuthorTotalNumberResponse;
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
