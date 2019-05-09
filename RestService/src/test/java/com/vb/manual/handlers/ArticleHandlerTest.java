package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManagerImpl;
import org.json.JSONObject;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import utils.MockArticleDao;
import utils.MockAuthorDao;
import utils.MockTopicDao;

import javax.sql.DataSource;

public class ArticleHandlerTest {

    private AuthorHandler authorHandler;
    private TopicHandler topicHandler;
    private ArticleHandler articleHandler;

    @Before
    public void beforeUp() {
        ArticleDao articleDao = new MockArticleDao(Mockito.any(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.any(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.any(DataSource.class));
        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        VBManualManagerImpl vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        SingleInstanceCreator.setTestData(vbManualManager, dataLoader, new JsonConverter(dataLoader));

        topicHandler = new TopicHandler();
        authorHandler = new AuthorHandler();
        articleHandler = new ArticleHandler();
    }

    @Test
    public void testAddGetArticle() {
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicID\":\"1\",\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\",\"content\":\"content\"}]}", articleHandler.getArticles("1", 0, 100).getEntity());
        Assert.assertEquals("{\"topicID\":\"2\",\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\",\"content\":\"content2\"}]}", articleHandler.getArticles("2", 0, 100).getEntity());
    }

    @Test
    public void deleteArticleTest() {
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        articleHandler.deleteArticle("1", "1");

        Assert.assertEquals("{\"topicID\":\"1\",\"articles\":[]}", articleHandler.getArticles("1", 0, 100).getEntity());
        Assert.assertEquals("{\"topicID\":\"2\",\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\",\"content\":\"content2\"}]}", articleHandler.getArticles("2", 0, 100).getEntity());
    }

    @Test
    public void updateArticleTest() {
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        articleHandler.updateArticle("1", new JSONObject().put("id", "1").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicID\":\"1\",\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"1\",\"content\":\"content2\"}]}", articleHandler.getArticles("1", 0, 100).getEntity());
        Assert.assertEquals("{\"topicID\":\"2\",\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\",\"content\":\"content2\"}]}", articleHandler.getArticles("2", 0, 100).getEntity());
    }

    @Test
    public void getArticlesTest(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicID\":\"1\",\"article\":{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\",\"content\":\"content\"}}", articleHandler.getArticle("1", "1").getEntity());
    }

    @Test
    public void getArticlesAllTest(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicID\":\"1\",\"articleTotalNumber\":1,\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\",\"content\":\"content\"}]}", articleHandler.getArticles("1").getEntity());
    }

    @Test
    public void getArticlesAllWithoutIdTest(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("1", new JSONObject().put("id", "1").put("name", "name").put("content", "content").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        articleHandler.addArticle("2", new JSONObject().put("id", "2").put("name", "name2").put("content", "content2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("[{\"topicID\":\"1\",\"articleTotalNumber\":1,\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\",\"content\":\"content\"}]},{\"topicID\":\"2\",\"articleTotalNumber\":1,\"articles\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\",\"content\":\"content2\"}]}]", articleHandler.getArticles().getEntity());
    }

}
