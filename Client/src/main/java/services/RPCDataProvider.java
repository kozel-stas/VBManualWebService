package services;

import com.google.common.annotations.VisibleForTesting;
import config.Configs;
import model.Article;
import model.Author;
import model.Topic;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import rpc.service.gen.VBManualService;
import view.ErrorListener;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class RPCDataProvider implements DataProvider {

    private Logger LOG = LogManager.getLogger(RPCDataProvider.class);

    private TTransport transport;
    private TProtocol protocol;
    private VBManualService.Client client;
    private RPCRequestResponseConverter RPCRequestResponseConverter;
    private ErrorListener errorListener;

    public RPCDataProvider() {
        transport = new TSocket(Configs.getRpcUrl(), Configs.getRpcPort());
        protocol = new TBinaryProtocol(transport);
        client = new VBManualService.Client(protocol);
        RPCRequestResponseConverter = new RPCRequestResponseConverter();
    }

    @VisibleForTesting
    public RPCDataProvider(TSocket transport, TBinaryProtocol protocol, VBManualService.Client client) throws TTransportException {
        this.transport = transport;
        this.protocol = protocol;
        this.client = client;
        transport.open();
        RPCRequestResponseConverter = new RPCRequestResponseConverter();
    }

    public void init(ErrorListener errorListener) throws Exception {
        this.errorListener = errorListener;
        transport.open();
    }

    @Override
    public List<Author> getAuthors(int offset, int limit) {
        try {
            return client.getAuthors(offset, limit).stream().map((val) -> RPCRequestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return Collections.emptyList();
    }

    @Override
    public Author getAuthor(String authorId) {
        try {
            return RPCRequestResponseConverter.convertFrom(client.getAuthor(authorId));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return null;
    }

    @Override
    public int getAuthorTotalNumber() {
        try {
            return client.getAuthorTotalNumber();
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return 0;
    }

    @Override
    public Author registerAuthor(Author author) {
        try {
            client.addAuthor(RPCRequestResponseConverter.convertFrom(author));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return author;
    }

    @Override
    public List<Topic> getTopics(int offset, int limit) {
        try {
            List<rpc.service.gen.Topic> topics = client.getTopics(offset, limit);
            return topics.stream().map(val -> RPCRequestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return Collections.emptyList();
    }

    @Override
    public Topic getTopic(String topicID) {
        try {
            return RPCRequestResponseConverter.convertFrom(client.getTopic(topicID));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return null;
    }

    @Override
    public int getTopicTotalNumber() {
        try {
            return client.getTopicTotalNumber();
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return 0;
    }

    @Override
    public List<Article> getArticles(String topicID, int offset, int limit) {
        try {
            List<rpc.service.gen.Article> articles = client.getArticles(topicID, offset, limit);
            return articles.stream().map(val -> RPCRequestResponseConverter.convertFrom(val)).collect(Collectors.toList());
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return Collections.emptyList();
    }

    @Override
    public Article getArticle(String articleID, String topicID) {
        try {
            return RPCRequestResponseConverter.convertFrom(client.getArticle(articleID, topicID));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return null;
    }

    @Override
    public int getArticleTotalNumber(String topicId) {
        try {
            return client.getArticleTotalNumber(topicId);
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return 0;
    }

    @Override
    public Topic addTopic(Topic topic) {
        try {
            client.addTopic(RPCRequestResponseConverter.convertFrom(topic));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return topic;
    }

    @Override
    public void deleteTopic(Topic topic) {
        try {
            client.deleteTopic(topic.getId(), RPCRequestResponseConverter.convertFrom(topic.getAuthor()));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
    }

    @Override
    public Article addArticle(String topicId, Article article) {
        try {
            client.addArticle(topicId, RPCRequestResponseConverter.convertFrom(article));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return article;
    }

    @Override
    public Article updateArticle(String topicID, Article article) {
        try {
            client.updateArticle(topicID, RPCRequestResponseConverter.convertFrom(article));
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
        return article;
    }

    @Override
    public void deleteArticle(String topicId, String articleId) {
        try {
            client.deleteArticle(topicId, articleId);
        } catch (TException e) {
            LOG.error(e);
            errorListener.translateExceptionToUI(e.getMessage());
        }
    }

    @Override
    public String toString() {
        return "RPC";
    }
}
