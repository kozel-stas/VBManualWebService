package services;

import model.Article;
import model.Author;
import model.Topic;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransportException;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import utils.RPCClientMock;

public class RPCDataProviderTest {

    private RPCDataProvider rpcDataProvider;

    @Before
    public void beforeUp() throws TTransportException {
        TSocket tSocket = Mockito.mock(TSocket.class);
        Mockito.doNothing().when(tSocket).open();
        rpcDataProvider = new RPCDataProvider(tSocket, Mockito.mock(TBinaryProtocol.class), new RPCClientMock(Mockito.mock(TBinaryProtocol.class)));
    }

    @Test
    public void addAuthorTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));

        Assert.assertEquals(1, rpcDataProvider.getAuthors(0, 100).size());
        Assert.assertEquals(1, rpcDataProvider.getAuthorTotalNumber());
        Author author = rpcDataProvider.getAuthor("1");
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lsatName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
    }

    @Test
    public void addTopicTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = rpcDataProvider.getAuthors(0, 100).get(0);

        rpcDataProvider.addTopic(new Topic("NAN", "name", author));

        Assert.assertEquals(1, rpcDataProvider.getTopics(0, 100).size());
        Assert.assertEquals(1, rpcDataProvider.getTopicTotalNumber());
        Topic topic = rpcDataProvider.getTopic("2");
        Assert.assertEquals("name", topic.getName());
        Assert.assertEquals(author, topic.getAuthor());
    }

    @Test
    public void addArticleTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = rpcDataProvider.getAuthors(0, 100).get(0);
        rpcDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = rpcDataProvider.getTopics(0, 100).get(0);

        rpcDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));

        Assert.assertEquals(1, rpcDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, rpcDataProvider.getArticleTotalNumber(topic.getId()));
        Article article = rpcDataProvider.getArticle("3", topic.getId());
        Assert.assertEquals("name", article.getName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(author, article.getAuthor());
    }

    @Test
    public void updateArticleTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName2", "lsatName2", "speciality2"));
        Author author = rpcDataProvider.getAuthors(0, 100).get(0);
        Author author2 = rpcDataProvider.getAuthors(0, 100).get(1);
        rpcDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = rpcDataProvider.getTopics(0, 100).get(0);
        rpcDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = rpcDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        rpcDataProvider.updateArticle(topic.getId(), new Article(article.getId(), "name2", "content2", author2));

        Assert.assertEquals(1, rpcDataProvider.getArticles(topic.getId(), 0, 100).size());
        Article updatedArticle = rpcDataProvider.getArticles(topic.getId(), 0, 100).get(0);
        Assert.assertEquals("name2", updatedArticle.getName());
        Assert.assertEquals("content2", updatedArticle.getContent());
        Assert.assertEquals(author2.getId(), updatedArticle.getAuthor().getId());
        Assert.assertEquals(author2.getFirstName(), updatedArticle.getAuthor().getFirstName());
        Assert.assertEquals(author2.getLastName(), updatedArticle.getAuthor().getLastName());
        Assert.assertEquals(author2.getSpeciality(), updatedArticle.getAuthor().getSpeciality());
    }

    @Test
    public void deleteArticleTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = rpcDataProvider.getAuthors(0, 100).get(0);
        rpcDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = rpcDataProvider.getTopics(0, 100).get(0);
        rpcDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = rpcDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        rpcDataProvider.deleteArticle(topic.getId(), article.getId());

        Assert.assertEquals(0, rpcDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, rpcDataProvider.getAuthors(0, 100).size());
    }

    @Test
    public void deleteTopicTest() {
        rpcDataProvider.registerAuthor(new Author("NAN", "firstName", "lsatName", "speciality"));
        Author author = rpcDataProvider.getAuthors(0, 100).get(0);
        rpcDataProvider.addTopic(new Topic("NAN", "name", author));
        Topic topic = rpcDataProvider.getTopics(0, 100).get(0);
        rpcDataProvider.addArticle(topic.getId(), new Article("NAN", "name", "content", author));
        Article article = rpcDataProvider.getArticles(topic.getId(), 0, 100).get(0);

        rpcDataProvider.deleteTopic(topic);

        Assert.assertEquals(0, rpcDataProvider.getArticles(topic.getId(), 0, 100).size());
        Assert.assertEquals(1, rpcDataProvider.getAuthors(0, 100).size());
        Assert.assertEquals(0, rpcDataProvider.getTopics(0, 100).size());
    }


}