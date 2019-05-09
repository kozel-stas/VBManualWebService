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

public class TopicHandlerTest {

    private TopicHandler topicHandler;
    private AuthorHandler authorHandler;

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
    }

    @Test
    public void addTopicsTest() {
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicTotalNumber\":2,\"topics\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\"},{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\"}]}", topicHandler.getTopics(0, 100).getEntity());
    }

    @Test
    public void deleteTopicsTest() {
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        topicHandler.deleteTopic("1", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());

        Assert.assertEquals("{\"topicTotalNumber\":1,\"topics\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\"}]}", topicHandler.getTopics(0, 100).getEntity());
    }

    @Test
    public void getTopicTets(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topic\":{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\"}}", topicHandler.getTopic("1").getEntity());
    }

    @Test
    public void getTopicTetsAll(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());
        topicHandler.addTopic(new JSONObject().put("id", "1").put("name", "name").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());
        topicHandler.addTopic(new JSONObject().put("id", "2").put("name", "name2").put("author", new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality")).toString());

        Assert.assertEquals("{\"topicTotalNumber\":2,\"topics\":[{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name\",\"id\":\"1\"},{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"},\"name\":\"name2\",\"id\":\"2\"}]}", topicHandler.getTopicsAll().getEntity());
    }

}
