package soap.service;

import com.mysql.cj.jdbc.MysqlDataSource;
import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManager;
import core.services.VBManualManagerImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import soap.model.Article;
import soap.model.Author;
import soap.model.Topic;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ExecutionException;

public class VBManualManagerSOAP {

    private static final Logger LOG = LogManager.getLogger(VBManualManagerSOAP.class);

    private RequestValidatorConverter requestValidatorConverter;
    private VBManualManager vbManualManager;

    public VBManualManagerSOAP() {
        super();
        DataSource dataSource = new MysqlDataSource();
        ((MysqlDataSource) dataSource).setPassword(ConfigConstants.DB_PASSWORD);
        ((MysqlDataSource) dataSource).setUser(ConfigConstants.DB_LOGIN);
        ((MysqlDataSource) dataSource).setURL(ConfigConstants.DB_URL);
        ArticleDao articleDao = new ArticleDao(dataSource);
        TopicDao topicDao = new TopicDao(dataSource);
        AuthorDao authorDao = new AuthorDao(dataSource);
        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        requestValidatorConverter = new RequestValidatorConverter(dataLoader);
        LOG.info("Mysql configuration {url=" + ((MysqlDataSource) dataSource).getURL() + ", login=" + ((MysqlDataSource) dataSource).getUser() + "}");
    }

    public List<Author> getAuthors(int offset, int limit) {
        LOG.info("List of authors requested. {}, {}", offset, limit);
        List<Author> res = new ArrayList<>();
        for (core.model.Author author : vbManualManager.getAuthors(offset, limit)) {
            res.add(requestValidatorConverter.convertFrom(author));
        }
        return res;
    }

    public void addAuthor(Author author) {
        vbManualManager.addAuthor(requestValidatorConverter.validateAuthor(requestValidatorConverter.convertFrom(author)));
        LOG.info("New author was added, {}", author);
    }

    public List<Topic> getTopics(int offset, int limit) {
        LOG.info("List of topics requested. {}, {}", offset, limit);
        List<Topic> result = new ArrayList<>();
        Set<core.model.Topic> topics = vbManualManager.getTopics(offset, limit);
        for (core.model.Topic topic : topics) {
            result.add(requestValidatorConverter.convertFrom(topic));
        }
        return result;
    }

    public List<Article> getArticles(String topicId, int offset, int limit) {
        LOG.info("List of articles requested. {}, {}, {}", topicId, offset, limit);
        requestValidatorConverter.validateTopicId(topicId);
        Set<core.model.Article> articles = vbManualManager.getArticles(topicId, offset, limit);
        List<Article> res = new ArrayList<>();
        for (core.model.Article article : articles) {
            res.add(requestValidatorConverter.convertFrom(article));
        }
        return res;
    }

    public int getArticleTotalNumber(String topicId) {
        requestValidatorConverter.validateTopicId(topicId);
        LOG.info("ArticleTotalNumber requested, {}", topicId);
        return vbManualManager.getArticleTotalNumber(topicId);
    }

    public int getAuthorTotalNumber() {
        LOG.info("AuthorTotalNumber requested");
        return vbManualManager.getAuthorTotalNumber();
    }

    public int getTopicTotalNumber() {
        LOG.info("TopicTotalNumber requested");
        return vbManualManager.getTopicTotalNumber();
    }

    public Topic getTopic(String topicId) {
        requestValidatorConverter.validateTopicId(topicId);
        LOG.info("Topic requested, {}", topicId);
        return requestValidatorConverter.convertFrom(vbManualManager.getTopic(topicId));
    }

    public Article getArticle(String topicId, String articleId) {
        requestValidatorConverter.validateTopicId(topicId);
        requestValidatorConverter.validateArticleId(articleId);
        LOG.info("Article requested, {}, {}", topicId, articleId);
        return requestValidatorConverter.convertFrom(vbManualManager.getArticle(articleId, topicId));
    }

    public Author getAuthor(String authorID) {
        requestValidatorConverter.validateAuthorId(authorID);
        LOG.info("Author requested, {}", authorID);
        return requestValidatorConverter.convertFrom(vbManualManager.getAuthor(authorID));
    }

    public void deleteArticle(String topicId, String articleId) {
        requestValidatorConverter.validateArticleId(articleId);
        requestValidatorConverter.validateTopicId(topicId);
        LOG.info("Request for deleting article, {}, {}", topicId, articleId);
        vbManualManager.deleteArticle(topicId, articleId);
    }

    public void updateArticle(String topicID, Article article) {
        core.model.Article articleP = requestValidatorConverter.validateArticle(requestValidatorConverter.convertFrom(topicID, article));
        requestValidatorConverter.validateArticleId(article.getId());
        requestValidatorConverter.validateTopicId(topicID);
        LOG.info("Request for updating article, {}, {}", topicID, article);
        vbManualManager.updateArticle(articleP);
    }

    public void addArticle(String topicID, Article article) {
        requestValidatorConverter.validateTopicId(topicID);
        LOG.info("Request for putting new article, {}, {}", topicID, article);
        vbManualManager.addArticle(requestValidatorConverter.validateArticle(requestValidatorConverter.convertFrom(topicID, article)));
    }

    public void addTopic(Topic topic) {
        LOG.info("Request for putting topic, {}", topic);
        vbManualManager.addTopic(requestValidatorConverter.validateTopic(requestValidatorConverter.convertFrom(topic)));
    }

    public void deleteTopic(String topicId, Author author) {
        core.model.Author authorP = requestValidatorConverter.validateAuthor(requestValidatorConverter.convertFrom(author));
        requestValidatorConverter.validateAuthorId(author.getId());
        requestValidatorConverter.validateTopicId(topicId);
        LOG.info("Request for deleting topic, {}, {}", topicId, author);
        vbManualManager.deleteTopic(topicId, authorP);
    }


    protected void setDataForTest(VBManualManager vbManualManager, DataLoader dataLoader) {
        this.vbManualManager = vbManualManager;
        this.requestValidatorConverter = new RequestValidatorConverter(dataLoader);
    }

}
