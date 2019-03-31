package core.services;

import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ExecutionException;

public class VBManualManagerImpl implements VBManualManager {

    private static final Logger LOG = LogManager.getLogger(VBManualManagerImpl.class);

    private final ArticleDao articleDao;
    private final TopicDao topicDao;
    private final AuthorDao authorDao;
    private final DataLoader dataLoader;

    public VBManualManagerImpl(ArticleDao articleDao, TopicDao topicDao, AuthorDao authorDao, DataLoader dataLoader) {
        this.articleDao = articleDao;
        this.topicDao = topicDao;
        this.authorDao = authorDao;
        this.dataLoader = dataLoader;
    }

    @Override
    public List<Author> getAuthors() {
        try {
            return authorDao.getAuthors();
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return null;
        }
    }

    @Override
    public boolean addAuthor(Author author) {
        try {
            boolean added = authorDao.addAuthor(author) > 0;
            LOG.info(added ? "Author {} was added" : "Author {} wasn't added", author);
            return added;
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return false;
        }
    }

    @Override
    public Set<Topic> getTopics() {
        try {
            return topicDao.getTopics();
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return Collections.emptySet();
        }
    }

    @Override
    public Set<Article> getArticles(String topicId) {
        try {
            return articleDao.getArticles(topicId);
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return Collections.emptySet();
        }
    }

    @Override
    public boolean deleteArticle(String topicId, String articleId) {
        try {
            return articleDao.deleteArticle(articleId, topicId) > 0;
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return false;
        }
    }

    @Override
    public boolean updateArticle(Article article) {
        try {
            return articleDao.updateArticle(article) > 1;
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return false;
        }
    }

    @Override
    public boolean addArticle(Article article) {
        try {
            return articleDao.addArticle(article) > 0;
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return false;
        }
    }

    @Override
    public boolean addTopic(Topic topic) {
        try {
            return topicDao.addTopic(topic) > 0;
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return false;
        }
    }

    @Override
    public boolean deleteTopic(String topicId, Author author) {
        try {
            //TODO races.
            articleDao.deleteArticles(topicId);
            return topicDao.deleteTopic(topicId, author.getId()) > 0;
        } catch (RuntimeException ex) {
            LOG.error(ex.getMessage(), ex);
            return false;
        }
    }

}
