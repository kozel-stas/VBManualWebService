package services;

import model.Article;
import model.Author;
import model.Topic;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import utils.SOAPClientMock;

import java.rmi.RemoteException;

public class SOAPDataProviderTest {

    private SOAPDataProvider soapDataProvider;

    @Before
    public void beforeUp() throws RemoteException {
        soapDataProvider = new SOAPDataProvider(new SOAPClientMock());
    }

    @Test
    public void addAuthorTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));

        Assert.assertEquals(1, soapDataProvider.getAuthors(0, 100).size());
        Assert.assertEquals(1, soapDataProvider.getAuthorTotalNumber());
        Author author = soapDataProvider.getAuthor("1");
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lsatName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
    }

    @Test
    public void addTopicTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = soapDataProvider.getAuthors(0, 100).get(0);

        soapDataProvider.addTopic(new Topic("NAN", "name", author));

        Assert.assertEquals(1, soapDataProvider.getTopics(0, 100).size());
        Assert.assertEquals(1, soapDataProvider.getTopicTotalNumber());
        Topic topic = soapDataProvider.getTopic("2");
        Assert.assertEquals("name", topic.getName());
        Assert.assertEquals(author, topic.getAuthor());
    }

    @Test
    public void addArticleTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = soapDataProvider.getAuthors(0, 100).get(0);
        soapDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = soapDataProvider.getTopics(0, 100).get(0);

        soapDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));

        Assert.assertEquals(1, soapDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, soapDataProvider.getArticleTotalNumber(topic.getId()));
        Article article = soapDataProvider.getArticle("3", topic.getId());
        Assert.assertEquals("name", article.getName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(author, article.getAuthor());
    }

    @Test
    public void updateArticleTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        soapDataProvider.registerAuthor(new Author("NAN", "firstName2", "lsatName2", "speciality2"));
        Author author = soapDataProvider.getAuthors(0, 100).get(0);
        Author author2 = soapDataProvider.getAuthors(0, 100).get(1);
        soapDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = soapDataProvider.getTopics(0, 100).get(0);
        soapDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = soapDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        soapDataProvider.updateArticle(topic.getId(), new Article(article.getId(), "name2", "content2", author2));

        Assert.assertEquals(1, soapDataProvider.getArticles(topic.getId(), 0, 100).size());
        Article updatedArticle = soapDataProvider.getArticles(topic.getId(), 0, 100).get(0);
        Assert.assertEquals("name2", updatedArticle.getName());
        Assert.assertEquals("content2", updatedArticle.getContent());
        Assert.assertEquals(author2.getId(), updatedArticle.getAuthor().getId());
        Assert.assertEquals(author2.getFirstName(), updatedArticle.getAuthor().getFirstName());
        Assert.assertEquals(author2.getLastName(), updatedArticle.getAuthor().getLastName());
        Assert.assertEquals(author2.getSpeciality(), updatedArticle.getAuthor().getSpeciality());
    }

    @Test
    public void deleteArticleTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = soapDataProvider.getAuthors(0, 100).get(0);
        soapDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = soapDataProvider.getTopics(0, 100).get(0);
        soapDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = soapDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        soapDataProvider.deleteArticle(topic.getId(), article.getId());

        Assert.assertEquals(0, soapDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, soapDataProvider.getAuthors(0, 100).size());
    }

    @Test
    public void deleteTopicTest() {
        soapDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = soapDataProvider.getAuthors(0, 100).get(0);
        soapDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = soapDataProvider.getTopics(0, 100).get(0);
        soapDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = soapDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        soapDataProvider.deleteTopic(topic);

        Assert.assertEquals(0, soapDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, soapDataProvider.getAuthors(0, 100).size());
        Assert.assertEquals(0, soapDataProvider.getTopics(0, 100).size());
    }


}