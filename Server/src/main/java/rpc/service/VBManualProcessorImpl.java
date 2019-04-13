package rpc.service;

import core.services.DataLoader;
import core.services.VBManualManager;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.TException;
import rpc.service.gen.Article;
import rpc.service.gen.Author;
import rpc.service.gen.Topic;
import rpc.service.gen.VBManualService;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

public class VBManualProcessorImpl implements VBManualService.Iface {

    private static final Logger LOG = LogManager.getLogger(VBManualProcessorImpl.class);

    private final VBManualManager vbManualManager;
    private final RequestResponseConverter requestResponseConverter;

    public VBManualProcessorImpl(VBManualManager vbManualManager, DataLoader dataLoader) {
        this.vbManualManager = vbManualManager;
        this.requestResponseConverter = new RequestResponseConverter(dataLoader);
    }

    @Override
    public List<Topic> getTopics(int offset, int number) throws TException {
        LOG.info("List of topics requested.");
        List<Topic> result = new ArrayList<>();
        for (core.model.Topic topic : vbManualManager.getTopics(offset, number)) {
            result.add(requestResponseConverter.convertFrom(topic));
        }
        return result;
    }

    @Override
    public int getAuthorTotalNumber() throws TException {
        return vbManualManager.getAuthorTotalNumber();
    }

    @Override
    public int getTopicTotalNumber() throws TException {
        return vbManualManager.getTopicTotalNumber();
    }

    @Override
    public int getArticleTotalNumber(String topicId) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        return vbManualManager.getArticleTotalNumber(topicId);
    }

    @Override
    public Topic getTopic(String topicId) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        return requestResponseConverter.convertFrom(vbManualManager.getTopic(topicId));
    }

    @Override
    public Article getArticle(String topicId, String articleId) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        requestResponseConverter.validateArticleId(articleId);
        return requestResponseConverter.convertFrom(vbManualManager.getArticle(articleId, topicId));
    }

    @Override
    public Author getAuthor(String authorId) throws TException {
        requestResponseConverter.validateAuthorId(authorId);
        return requestResponseConverter.convertFrom(vbManualManager.getAuthor(authorId));
    }

    @Override
    public List<Article> getArticles(String topicId, int offset, int number) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        LOG.info("List of articles requested for topicID {}.", topicId);
        List<Article> result = new ArrayList<>();
        for (core.model.Article article : vbManualManager.getArticles(topicId, offset, number)) {
            result.add(requestResponseConverter.convertFrom(article));
        }
        return result;
    }

    @Override
    public void deleteArticle(String topicId, String articleId) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        requestResponseConverter.validateArticleId(articleId);
        vbManualManager.deleteArticle(topicId, articleId);
    }

    @Override
    public void updateArticle(String topicId, Article article) throws TException {
        requestResponseConverter.validateArticleId(article.getArticleId());
        requestResponseConverter.validateTopicId(topicId);
        vbManualManager.updateArticle(requestResponseConverter.convertFromWithCheck(article, topicId));
    }

    @Override
    public void addArticle(String topicId, Article article) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        vbManualManager.addArticle(requestResponseConverter.convertFromWithCheck(article, topicId));
    }

    @Override
    public void addTopic(Topic topic) throws TException {
        vbManualManager.addTopic(requestResponseConverter.convertFromWithCheck(topic));
    }

    @Override
    public void deleteTopic(String topicId, Author author) throws TException {
        requestResponseConverter.validateTopicId(topicId);
        vbManualManager.deleteTopic(topicId, requestResponseConverter.convertFromWithCheck(author));
    }

    @Override
    public void addAuthor(Author author) throws TException {
        vbManualManager.addAuthor(requestResponseConverter.convertFrom(author));
    }

    @Override
    public List<Author> getAuthors(int offset, int number) throws TException {
        LOG.info("List of authors requested.");
        List<Author> result = new ArrayList<>();
        for (core.model.Author author : vbManualManager.getAuthors(offset, number)) {
            result.add(requestResponseConverter.convertFrom(author));
        }
        return result;
    }

}
