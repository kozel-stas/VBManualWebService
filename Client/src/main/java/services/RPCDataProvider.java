package services;

import com.service.axis.manual.vb.VBManualManagerSOAPStub;
import model.Article;
import model.Author;
import model.Topic;
import org.apache.axis2.AxisFault;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import rpc.service.gen.VBManualService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class RPCDataProvider implements DataProvider {

    private Logger LOG = LogManager.getLogger(RPCDataProvider.class);

    private TTransport transport;
    private TProtocol protocol;
    private VBManualService.Client client;
    private RequestResponseConverter requestResponseConverter;

    public RPCDataProvider() throws TTransportException {
        transport = new TSocket("localhost", 9090);
        protocol = new TBinaryProtocol(transport);
        client = new VBManualService.Client(protocol);
        transport.open();
        requestResponseConverter = new RequestResponseConverter();
    }

    @Override
    public List<Author> getAuthors() {
        try {
            return client.getAuthors().stream().map((val) -> requestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public Author registerAuthor(Author author) {
        try {
            client.addAuthor(requestResponseConverter.convertFrom(author));
        } catch (TException e) {
            LOG.error(e);
        }
        return author;
    }

    @Override
    public List<Topic> getTopics() {
        try {
            List<rpc.service.gen.Topic> topics = client.getTopics();
            return topics.stream().map(val -> requestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public List<Article> getArticles(String topicID) {
        try {
            List<rpc.service.gen.Article> articles = client.getArticles(topicID);
            return articles.stream().map(val -> requestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public Topic addTopic(Topic topic) {
        try {
            client.addTopic(requestResponseConverter.convertFrom(topic));
        } catch (TException e) {
            LOG.error(e);
        }
        return topic;
    }

    @Override
    public void deleteTopic(Topic topic) {
        try {
            client.deleteTopic(topic.getId(), requestResponseConverter.convertFrom(topic.getAuthor()));
        } catch (TException e) {
            LOG.error(e);
        }
    }

    @Override
    public Article addArticle(String topicId, Article article) {
        try {
            client.addArticle(topicId, requestResponseConverter.convertFrom(article));
        } catch (TException e) {
            LOG.error(e);
        }
        return article;
    }

    @Override
    public Article updateArticle(String topicID, Article article) {
        try {
            client.updateArticle(topicID, requestResponseConverter.convertFrom(article));
        } catch (TException e) {
            LOG.error(e);
        }
        return article;
    }

    @Override
    public String toString() {
        return "RPC";
    }
}
