package core.services;

import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import utils.MockArticleDao;
import utils.MockAuthorDao;
import utils.MockTopicDao;

import javax.sql.DataSource;
import java.util.concurrent.ExecutionException;

public class VBManualManagerImplTest {

    private VBManualManager vbManualManager;
    private DataLoader dataLoader;

    @Before
    public void beforeUp() {
        ArticleDao articleDao = new MockArticleDao(Mockito.any(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.any(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.any(DataSource.class));
        dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
    }

    @Test
    public void addAuthorTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));

        Assert.assertEquals(1, vbManualManager.getAuthors(0, 100).size());
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lastName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
        Assert.assertEquals(author, dataLoader.loadAuthor(author.getId()));
    }

    @Test
    public void getAuthorTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));

        Assert.assertEquals(1, vbManualManager.getAuthors(0, 100).size());
        Assert.assertEquals(1, vbManualManager.getAuthorTotalNumber());
        Author author = vbManualManager.getAuthor("1");
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lastName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
        Assert.assertEquals(author, dataLoader.loadAuthor(author.getId()));
    }

    @Test
    public void addTopicTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);

        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));

        Assert.assertEquals(1, vbManualManager.getTopics(0, 100).size());
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();
        Assert.assertEquals("name", topic.getName());
        Assert.assertEquals(author.getId(), topic.getAuthorId());
        Assert.assertEquals(topic, dataLoader.loadTopic(topic.getId()));
    }

    @Test
    public void getTopicTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));

        Assert.assertEquals(1, vbManualManager.getTopics(0, 100).size());
        Assert.assertEquals(1, vbManualManager.getTopicTotalNumber());
        Topic topic = vbManualManager.getTopic("1");
        Assert.assertEquals("name", topic.getName());
        Assert.assertEquals(author.getId(), topic.getAuthorId());
        Assert.assertEquals(topic, dataLoader.loadTopic(topic.getId()));
    }

    @Test
    public void addArticleTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();

        vbManualManager.addArticle(new Article("NAN", "name", "content", author.getId(), topic.getId()));

        Assert.assertEquals(1, vbManualManager.getArticles(topic.getId(), 0, 100).size());
        Article article = vbManualManager.getArticles(topic.getId(), 0, 100).iterator().next();
        Assert.assertEquals("name", article.getName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(topic.getId(), article.getTopicId());
        Assert.assertEquals(topic.getAuthorId(), author.getId());
        Assert.assertEquals(article, dataLoader.loadArticle(article.getId()));
    }

    @Test
    public void getArticleTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();

        vbManualManager.addArticle(new Article("NAN", "name", "content", author.getId(), topic.getId()));

        Assert.assertEquals(1, vbManualManager.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, vbManualManager.getArticleTotalNumber(topic.getId()));
        Article article = vbManualManager.getArticle("1",topic.getId() );
        Assert.assertEquals("name", article.getName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(topic.getId(), article.getTopicId());
        Assert.assertEquals(topic.getAuthorId(), author.getId());
        Assert.assertEquals(article, dataLoader.loadArticle(article.getId()));
    }

    @Test
    public void updateArticleTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();
        vbManualManager.addArticle(new Article("NAN", "name", "content", author.getId(), topic.getId()));
        Article article = vbManualManager.getArticles(topic.getId(), 0, 100).iterator().next();

        vbManualManager.updateArticle(new Article(article.getId(), "name2", "content2", author.getId(), topic.getId()));

        Assert.assertEquals(1, vbManualManager.getArticles(topic.getId(), 0, 100).size());
        Article updatedArticle = vbManualManager.getArticles(topic.getId(), 0, 100).iterator().next();
        Assert.assertEquals("name2", updatedArticle.getName());
        Assert.assertEquals("content2", updatedArticle.getContent());
        Assert.assertEquals(topic.getId(), updatedArticle.getTopicId());
        Assert.assertEquals(topic.getAuthorId(), updatedArticle.getId());
        Assert.assertEquals(updatedArticle, dataLoader.loadArticle(article.getId()));
    }

    @Test
    public void deleteArticleTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();
        vbManualManager.addArticle(new Article("NAN", "name", "content", author.getId(), topic.getId()));
        Article article = vbManualManager.getArticles(topic.getId(), 0, 100).iterator().next();

        vbManualManager.deleteArticle(topic.getId(), article.getId());

        Assert.assertEquals(0, vbManualManager.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, vbManualManager.getTopics(0, 100).size());
        Assert.assertEquals(1, vbManualManager.getAuthors(0, 100).size());
    }

    @Test
    public void deleteTopicTest() {
        vbManualManager.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManager.getAuthors(0, 100).get(0);
        vbManualManager.addTopic(new Topic("NAN", "name", author.getId()));
        Topic topic = vbManualManager.getTopics(0, 100).iterator().next();
        vbManualManager.addArticle(new Article("NAN", "name", "content", author.getId(), topic.getId()));
        Article article = vbManualManager.getArticles(topic.getId(), 0, 100).iterator().next();

        vbManualManager.deleteTopic(topic.getId(), author);

        Assert.assertEquals(0, vbManualManager.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(0, vbManualManager.getTopics(0, 100).size());
        Assert.assertEquals(1, vbManualManager.getAuthors(0, 100).size());
    }

}