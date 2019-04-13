package services;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.UniformInterfaceException;
import config.Configs;
import model.Article;
import model.Author;
import model.Topic;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import view.ErrorListener;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Collections;
import java.util.List;

public class RESTDataProvider implements DataProvider {

    private static final Logger LOG = LogManager.getLogger(RESTDataProvider.class);

    private final Client client = Client.create();
    private final RESTRequestResponseConverter restRequestResponseConverter = new RESTRequestResponseConverter();
    private ErrorListener errorListener;

    @Override
    public void init(ErrorListener errorListener) throws Exception {
        this.errorListener = errorListener;
        ClientResponse clientResponse = client.resource(Configs.getRestUrl()).path("/ping").head();
        if (clientResponse.getStatusInfo().getFamily() != Response.Status.Family.SUCCESSFUL) {
            throw new Exception("No available.");
        }
    }

    @Override
    public List<Author> getAuthors(int offset, int limit) {
        try {
            return restRequestResponseConverter.getAuthors(client.resource(Configs.getRestUrl()).path("/author/getAuthors").queryParam("offset", String.valueOf(offset)).queryParam("limit", String.valueOf(limit)).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
    }

    @Override
    public Author getAuthor(String authorId) {
        try {
            return restRequestResponseConverter.convertToAuthor(client.resource(Configs.getRestUrl()).path("/author/getAuthor").queryParam("authorID", authorId).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return null;
    }

    @Override
    public int getAuthorTotalNumber() {
        try {
            return restRequestResponseConverter.getAuthorTotalNumber(client.resource(Configs.getRestUrl()).path("/author/getAuthorTotalNumber").accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return 0;
    }

    @Override
    public Author registerAuthor(Author author) {
        try {
            client.resource(Configs.getRestUrl()).path("/author/addAuthor").entity(restRequestResponseConverter.convertFrom(author).toString(), MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON).post();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return author;
    }

    @Override
    public List<Topic> getTopics(int offset, int limit) {
        try {
            return restRequestResponseConverter.getTopics(client.resource(Configs.getRestUrl()).path("/topic/getTopics").queryParam("limit", String.valueOf(limit)).queryParam("offset", String.valueOf(offset)).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
    }

    @Override
    public Topic getTopic(String topicID) {
        try {
            return restRequestResponseConverter.convertToTopic(client.resource(Configs.getRestUrl()).path("/topic/getTopic").queryParam("topicID", topicID).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return null;
    }

    @Override
    public int getTopicTotalNumber() {
        try {
            return restRequestResponseConverter.getTopicTotalNumber(client.resource(Configs.getRestUrl()).path("/topic/getTopicTotalNumber").accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return 0;
    }

    @Override
    public List<Article> getArticles(String topicID, int offset, int limit) {
        try {
            return restRequestResponseConverter.getArticles(client.resource(Configs.getRestUrl()).path("/article/getArticles").queryParam("topicID", topicID).queryParam("offset", String.valueOf(offset)).queryParam("limit", String.valueOf(limit)).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
    }

    @Override
    public Article getArticle(String articleID, String topicID) {
        try {
            return restRequestResponseConverter.convertToArticle(client.resource(Configs.getRestUrl()).path("/article/getArticle").queryParam("articleID", articleID).queryParam("topicID", topicID).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return null;
    }

    @Override
    public int getArticleTotalNumber(String topicId) {
        try {
            return restRequestResponseConverter.getArticleTotalNumber(client.resource(Configs.getRestUrl()).path("/article/getArticleTotalNumber").accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return 0;
    }

    @Override
    public Topic addTopic(Topic topic) {
        try {
            client.resource(Configs.getRestUrl()).path("/topic/addTopic").entity(restRequestResponseConverter.convertFrom(topic).toString(), MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON).post();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return topic;
    }

    @Override
    public void deleteTopic(Topic topic) {
        try {
            client.resource(Configs.getRestUrl()).path("/topic/deleteTopic").queryParam("topicID", topic.getId()).entity(restRequestResponseConverter.convertFrom(topic.getAuthor()).toString(), MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON).delete();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
    }

    @Override
    public Article addArticle(String topicID, Article article) {
        try {
            client.resource(Configs.getRestUrl()).path("/article/addArticle").queryParam("topicID", topicID).entity(restRequestResponseConverter.convertFrom(article).toString(), MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON).post();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return article;
    }

    @Override
    public Article updateArticle(String topicID, Article article) {
        try {
            client.resource(Configs.getRestUrl()).path("/article/updateArticle").queryParam("topicID", topicID).entity(restRequestResponseConverter.convertFrom(article).toString(), MediaType.APPLICATION_JSON).accept(MediaType.APPLICATION_JSON).put();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return article;
    }

    @Override
    public void deleteArticle(String topicId, String articleId) {
        try {
            client.resource(Configs.getRestUrl()).path("/article/deleteArticle").queryParam("topicID", topicId).queryParam("articleID", articleId).delete();
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
    }

    @Override
    public String toString() {
        return "REST";
    }

}
