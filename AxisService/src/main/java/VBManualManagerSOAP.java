import com.mysql.cj.jdbc.MysqlDataSource;
import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManagerImpl;

import javax.sql.DataSource;
import java.util.List;
import java.util.Set;

public class VBManualManagerSOAP {

    private final RequestValidator requestValidator;
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
        requestValidator = new RequestValidator(dataLoader);
    }

    public List<Author> getAuthor(String authorID) {
        return vbManualManager.getAuthors();
    }

    public void addAuthor(Author author) {
        vbManualManager.addAuthor(requestValidator.validateAuthor(author));
    }

    public Set<Topic> getTopics() {
        return vbManualManager.getTopics();
    }

    public Set<Article> getArticles(String topicId) {
        requestValidator.validateTopicId(topicId);
        return vbManualManager.getArticles(topicId);
    }

    public void deleteArticle(String topicId, String articleId) {
        requestValidator.validateArticleId(articleId);
        requestValidator.validateArticleId(topicId);
        vbManualManager.deleteArticle(topicId, articleId);
    }

    public void updateArticle(Article article) {
        Article articleP = requestValidator.validateArticle(article);
        requestValidator.validateArticleId(article.getId());
        vbManualManager.updateArticle(articleP);
    }

    public void addArticle(Article article) {
        vbManualManager.addArticle(requestValidator.validateArticle(article));
    }

    public void addTopic(Topic topic) {
        vbManualManager.addTopic(requestValidator.validateTopic(topic));
    }

    public void deleteTopic(String topicId, Author author) {
        Author authorP = requestValidator.validateAuthor(author);
        requestValidator.validateAuthorId(author.getId());
        requestValidator.validateTopicId(topicId);
        vbManualManager.deleteTopic(topicId, authorP);
    }

}
