package soap.service;

import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManagerImpl;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import soap.model.Article;
import soap.model.Author;
import soap.model.Topic;
import soap.service.VBManualManagerSOAP;
import utils.MockArticleDao;
import utils.MockAuthorDao;
import utils.MockTopicDao;

import javax.sql.DataSource;
import java.util.concurrent.ExecutionException;

public class VBManualManagerSOAPTest {

    private VBManualManagerSOAP vbManualManagerSOAP;
    private DataLoader dataLoader;

    @Before
    public void beforeUp() {
        ArticleDao articleDao = new MockArticleDao(Mockito.any(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.any(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.any(DataSource.class));
        dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        VBManualManagerImpl vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        vbManualManagerSOAP = new VBManualManagerSOAP();
        vbManualManagerSOAP.setDataForTest(vbManualManager, dataLoader);
    }

    @Test(expected = IllegalStateException.class)
    public void invalidTopicIdAddArticleTest() {
        vbManualManagerSOAP.addArticle("1", new Article());
    }

    @Test(expected = IllegalStateException.class)
    public void invalidTopicIdUpdateArticleTest() {
        vbManualManagerSOAP.updateArticle("1", new Article("NAN", "name", "content", new Author("NAN", "firstName", "lastName", "speciality")));
    }

    @Test
    public void addAuthorTest() {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));

        Assert.assertEquals(1, vbManualManagerSOAP.getAuthors().size());
        Author author = vbManualManagerSOAP.getAuthors().get(0);
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lastName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
    }

    @Test
    public void addTopicTest() {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManagerSOAP.getAuthors().get(0);

        vbManualManagerSOAP.addTopic(new Topic("NAN", "name", author));

        Assert.assertEquals(1, vbManualManagerSOAP.getTopics().size());
        Topic topic = vbManualManagerSOAP.getTopics().get(0);
        Assert.assertEquals("name", topic.getName());
        Assert.assertEquals(author.getId(), topic.getAuthor().getId());
        Assert.assertEquals(author.getFirstName(), topic.getAuthor().getFirstName());
        Assert.assertEquals(author.getLastName(), topic.getAuthor().getLastName());
        Assert.assertEquals(author.getSpeciality(), topic.getAuthor().getSpeciality());
    }

    @Test
    public void addArticleTest() {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManagerSOAP.getAuthors().get(0);
        vbManualManagerSOAP.addTopic(new Topic("NAN", "name", author));
        Topic topic = vbManualManagerSOAP.getTopics().get(0);


        vbManualManagerSOAP.addArticle(topic.getId(), new Article("NAN", "name", "content", author));

        Assert.assertEquals(1, vbManualManagerSOAP.getArticles(topic.getId()).size());
        Article article = vbManualManagerSOAP.getArticles(topic.getId()).get(0);
        Assert.assertEquals("name", article.getName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(author.getId(), article.getAuthor().getId());
        Assert.assertEquals(author.getFirstName(), article.getAuthor().getFirstName());
        Assert.assertEquals(author.getLastName(), article.getAuthor().getLastName());
        Assert.assertEquals(author.getSpeciality(), article.getAuthor().getSpeciality());
    }

    @Test
    public void deleteArticleTest() {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManagerSOAP.getAuthors().get(0);
        vbManualManagerSOAP.addTopic(new Topic("NAN", "name", author));
        Topic topic = vbManualManagerSOAP.getTopics().get(0);
        vbManualManagerSOAP.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = vbManualManagerSOAP.getArticles(topic.getId()).get(0);

        vbManualManagerSOAP.deleteArticle(topic.getId(), article.getId());

        Assert.assertEquals(0, vbManualManagerSOAP.getArticles(topic.getId()).size());
        Assert.assertEquals(1, vbManualManagerSOAP.getAuthors().size());
    }

    @Test
    public void deleteTopicTest() throws ExecutionException {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        Author author = vbManualManagerSOAP.getAuthors().get(0);
        vbManualManagerSOAP.addTopic(new Topic("NAN", "name", author));
        Topic topic = vbManualManagerSOAP.getTopics().get(0);
        vbManualManagerSOAP.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = vbManualManagerSOAP.getArticles(topic.getId()).get(0);

        vbManualManagerSOAP.deleteTopic(topic.getId(), author);

        Assert.assertNull(dataLoader.loadArticle(article.getId()));
        Assert.assertEquals(1, vbManualManagerSOAP.getAuthors().size());
        Assert.assertEquals(0, vbManualManagerSOAP.getTopics().size());
    }

    @Test
    public void updateArticleTest() {
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        vbManualManagerSOAP.addAuthor(new Author("NAN", "firstName2", "lastName2", "speciality2"));
        Author author = vbManualManagerSOAP.getAuthors().get(0);
        Author author2 = vbManualManagerSOAP.getAuthors().get(1);
        vbManualManagerSOAP.addTopic(new Topic("NAN", "name", author));
        Topic topic = vbManualManagerSOAP.getTopics().get(0);
        vbManualManagerSOAP.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = vbManualManagerSOAP.getArticles(topic.getId()).get(0);

        vbManualManagerSOAP.updateArticle(topic.getId(), new Article(article.getId(), "name2", "content2", author2));

        Assert.assertEquals(1, vbManualManagerSOAP.getArticles(topic.getId()).size());
        Article updatedArticle = vbManualManagerSOAP.getArticles(topic.getId()).get(0);
        Assert.assertEquals("name2", updatedArticle.getName());
        Assert.assertEquals("content2", updatedArticle.getContent());
        Assert.assertEquals(author2.getId(), updatedArticle.getAuthor().getId());
        Assert.assertEquals(author2.getFirstName(), updatedArticle.getAuthor().getFirstName());
        Assert.assertEquals(author2.getLastName(), updatedArticle.getAuthor().getLastName());
        Assert.assertEquals(author2.getSpeciality(), updatedArticle.getAuthor().getSpeciality());
    }


}