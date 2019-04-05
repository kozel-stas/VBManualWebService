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
    public List<Author> getAuthors() {
        try {
            return restRequestResponseConverter.getAuthors(client.resource(Configs.getRestUrl()).path("/author/getAuthors").accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
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
    public List<Topic> getTopics() {
        try {
            return restRequestResponseConverter.getTopics(client.resource(Configs.getRestUrl()).path("/topic/getTopics").accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
    }

    @Override
    public List<Article> getArticles(String topicID) {
        try {
            return restRequestResponseConverter.getArticles(client.resource(Configs.getRestUrl()).path("/article/getArticles").queryParam("topicID", topicID).accept(MediaType.APPLICATION_JSON).get(String.class));
        } catch (UniformInterfaceException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getResponse().getEntity(String.class));
        }
        return Collections.emptyList();
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
