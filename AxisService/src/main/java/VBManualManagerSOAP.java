import com.mysql.cj.jdbc.MysqlDataSource;
import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
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

    private final RequestValidatorConverter requestValidatorConverter;
    private final VBManualManagerImpl vbManualManager;

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
    }

    public List<Author> getAuthor(String authorID) {
        List<Author> res = new ArrayList<>();
        for (core.model.Author author : vbManualManager.getAuthors()) {
            res.add(requestValidatorConverter.convertFrom(author));
        }
        return res;
    }

    public void addAuthor(Author author) {
        vbManualManager.addAuthor(requestValidatorConverter.validateAuthor(requestValidatorConverter.convertFrom(author)));
    }

    public List<Topic> getTopics() {
        try {
            List<Topic> result = new ArrayList<>();
            Set<core.model.Topic> topics = vbManualManager.getTopics();
            for (core.model.Topic topic : topics) {
                result.add(requestValidatorConverter.convertFrom(topic));
            }
            return result;
        } catch (ExecutionException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    public List<Article> getArticles(String topicId) {
        requestValidatorConverter.validateTopicId(topicId);
        Set<core.model.Article> articles = vbManualManager.getArticles(topicId);
        List<Article> res = new ArrayList<>();
        try {
            for (core.model.Article article : articles) {
                res.add(requestValidatorConverter.convertFrom(article));
            }
            return res;
        } catch (ExecutionException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    public void deleteArticle(String topicId, String articleId) {
        requestValidatorConverter.validateArticleId(articleId);
        requestValidatorConverter.validateArticleId(topicId);
        vbManualManager.deleteArticle(topicId, articleId);
    }

    public void updateArticle(String topicID, Article article) {
        core.model.Article articleP = requestValidatorConverter.validateArticle(requestValidatorConverter.convertFrom(topicID, article));
        requestValidatorConverter.validateArticleId(article.getId());
        vbManualManager.updateArticle(articleP);
    }

    public void addArticle(String topicID, Article article) {
        vbManualManager.addArticle(requestValidatorConverter.validateArticle(requestValidatorConverter.convertFrom(topicID, article)));
    }

    public void addTopic(Topic topic) {
        try {
            vbManualManager.addTopic(requestValidatorConverter.validateTopic(requestValidatorConverter.convertFrom(topic)));
        } catch (ExecutionException e) {
            LOG.error(e);
        }
    }

    public void deleteTopic(String topicId, Author author) {
        core.model.Author authorP = requestValidatorConverter.validateAuthor(requestValidatorConverter.convertFrom(author));
        requestValidatorConverter.validateAuthorId(author.getId());
        requestValidatorConverter.validateTopicId(topicId);
        vbManualManager.deleteTopic(topicId, authorP);
    }

}
