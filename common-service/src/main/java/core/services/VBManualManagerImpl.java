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
    public List<Author> getAuthors(int offset, int number) {
        try {
            return authorDao.getAuthors(offset, number);
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return null;
        }
    }

    @Override
    public Author getAuthor(String authorID) {
        return dataLoader.loadAuthor(authorID);
    }

    @Override
    public int getAuthorTotalNumber() {
        return authorDao.getAuthorTotalNumber();
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
    public Set<Topic> getTopics(int offset, int number) {
        try {
            return topicDao.getTopics(offset, number);
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return Collections.emptySet();
        }
    }

    @Override
    public Topic getTopic(String topicID) {
        return dataLoader.loadTopic(topicID);
    }

    @Override
    public int getTopicTotalNumber() {
        return topicDao.getTopicTotalNumber();
    }

    @Override
    public Set<Article> getArticles(String topicId, int offset, int limit) {
        try {
            return articleDao.getArticles(topicId, offset, limit);
        } catch (RuntimeException e) {
            LOG.error(e.getMessage(), e);
            return Collections.emptySet();
        }
    }

    @Override
    public Article getArticle(String articleID, String topicID) {
        return dataLoader.loadArticle(articleID);
    }

    @Override
    public int getArticleTotalNumber(String topicId) {
        return articleDao.getArticleTotalNumber(topicId);
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
