package rpc.service;


import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManagerImpl;
import org.apache.thrift.TException;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import rpc.service.gen.Article;
import rpc.service.gen.Author;
import rpc.service.gen.Topic;
import utils.MockArticleDao;
import utils.MockAuthorDao;
import utils.MockTopicDao;

import javax.sql.DataSource;

public class VBManualProcessorImplTest {

    private VBManualProcessorImpl vbManualProcessor;

    @Before
    public void beforeUp() {
        ArticleDao articleDao = new MockArticleDao(Mockito.any(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.any(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.any(DataSource.class));
        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        VBManualManagerImpl vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        vbManualProcessor = new VBManualProcessorImpl(vbManualManager, dataLoader);
    }

    @Test(expected = TException.class)
    public void invalidTopicIdAddArticleTest() throws TException {
        vbManualProcessor.addArticle("1", new Article());
    }

    @Test(expected = TException.class)
    public void invalidTopicIdUpdateArticleTest() throws TException {
        vbManualProcessor.updateArticle("1", new Article());
    }

    @Test
    public void addAuthorTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));

        Assert.assertEquals(1, vbManualProcessor.getAuthors().size());
        Author author = vbManualProcessor.getAuthors().get(0);
        Assert.assertEquals("firstName", author.getFirstName());
        Assert.assertEquals("lastName", author.getLastName());
        Assert.assertEquals("speciality", author.getSpeciality());
    }

    @Test
    public void addTopicTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));
        Author author = vbManualProcessor.getAuthors().get(0);

        vbManualProcessor.addTopic(new Topic().setAuthor(author).setTopicId("NAN").setTopicName("name"));

        Assert.assertEquals(1, vbManualProcessor.getTopics().size());
        Topic topic = vbManualProcessor.getTopics().get(0);
        Assert.assertEquals("name", topic.getTopicName());
        Assert.assertEquals(author.getAuthorId(), topic.getAuthor().getAuthorId());
        Assert.assertEquals(author.getFirstName(), topic.getAuthor().getFirstName());
        Assert.assertEquals(author.getLastName(), topic.getAuthor().getLastName());
        Assert.assertEquals(author.getSpeciality(), topic.getAuthor().getSpeciality());
    }

    @Test
    public void addArticleTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));
        Author author = vbManualProcessor.getAuthors().get(0);
        vbManualProcessor.addTopic(new Topic().setAuthor(author).setTopicId("NAN").setTopicName("name"));
        Topic topic = vbManualProcessor.getTopics().get(0);


        vbManualProcessor.addArticle(topic.getTopicId(), new Article().setArticleId("NAN").setArticleName("name").setAuthor(author).setContent("content"));

        Assert.assertEquals(1, vbManualProcessor.getArticles(topic.getTopicId()).size());
        Article article = vbManualProcessor.getArticles(topic.getTopicId()).get(0);
        Assert.assertEquals("name", article.getArticleName());
        Assert.assertEquals("content", article.getContent());
        Assert.assertEquals(author.getAuthorId(), article.getAuthor().getAuthorId());
        Assert.assertEquals(author.getFirstName(), article.getAuthor().getFirstName());
        Assert.assertEquals(author.getLastName(), article.getAuthor().getLastName());
        Assert.assertEquals(author.getSpeciality(), article.getAuthor().getSpeciality());
    }

    @Test
    public void deleteArticleTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));
        Author author = vbManualProcessor.getAuthors().get(0);
        vbManualProcessor.addTopic(new Topic().setAuthor(author).setTopicId("NAN").setTopicName("name"));
        Topic topic = vbManualProcessor.getTopics().get(0);
        vbManualProcessor.addArticle(topic.getTopicId(), new Article().setArticleId("NAN").setArticleName("name").setAuthor(author).setContent("content"));
        Article article = vbManualProcessor.getArticles(topic.getTopicId()).get(0);

        vbManualProcessor.deleteArticle(topic.getTopicId(), article.getArticleId());

        Assert.assertEquals(0, vbManualProcessor.getArticles(topic.getTopicId()).size());
        Assert.assertEquals(1, vbManualProcessor.getAuthors().size());
    }

    @Test
    public void deleteTopicTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));
        Author author = vbManualProcessor.getAuthors().get(0);
        vbManualProcessor.addTopic(new Topic().setAuthor(author).setTopicId("NAN").setTopicName("name"));
        Topic topic = vbManualProcessor.getTopics().get(0);
        vbManualProcessor.addArticle(topic.getTopicId(), new Article().setArticleId("NAN").setArticleName("name").setAuthor(author).setContent("content"));
        Article article = vbManualProcessor.getArticles(topic.getTopicId()).get(0);

        vbManualProcessor.deleteTopic(topic.getTopicId(), author);

        Assert.assertEquals(0, vbManualProcessor.getArticles(topic.getTopicId()).size());
        Assert.assertEquals(1, vbManualProcessor.getAuthors().size());
        Assert.assertEquals(0, vbManualProcessor.getTopics().size());
    }

    @Test
    public void updateArticleTest() throws TException {
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName").setLastName("lastName").setSpeciality("speciality"));
        vbManualProcessor.addAuthor(new Author().setAuthorId("NAN").setFirstName("firstName2").setLastName("lastName2").setSpeciality("speciality2"));
        Author author = vbManualProcessor.getAuthors().get(0);
        Author author2 = vbManualProcessor.getAuthors().get(1);
        vbManualProcessor.addTopic(new Topic().setAuthor(author).setTopicId("NAN").setTopicName("name"));
        Topic topic = vbManualProcessor.getTopics().get(0);
        vbManualProcessor.addArticle(topic.getTopicId(), new Article().setArticleId("NAN").setArticleName("name").setAuthor(author).setContent("content"));
        Article article = vbManualProcessor.getArticles(topic.getTopicId()).get(0);

        vbManualProcessor.updateArticle(topic.getTopicId(), new Article().setContent("content2").setArticleName("name2").setArticleId(article.getArticleId()).setAuthor(author2));

        Assert.assertEquals(1, vbManualProcessor.getArticles(topic.getTopicId()).size());
        Article updatedArticle = vbManualProcessor.getArticles(topic.getTopicId()).get(0);
        Assert.assertEquals("name2", updatedArticle.getArticleName());
        Assert.assertEquals("content2", updatedArticle.getContent());
        Assert.assertEquals(author2.getAuthorId(), updatedArticle.getAuthor().getAuthorId());
        Assert.assertEquals(author2.getFirstName(), updatedArticle.getAuthor().getFirstName());
        Assert.assertEquals(author2.getLastName(), updatedArticle.getAuthor().getLastName());
        Assert.assertEquals(author2.getSpeciality(), updatedArticle.getAuthor().getSpeciality());
    }

}