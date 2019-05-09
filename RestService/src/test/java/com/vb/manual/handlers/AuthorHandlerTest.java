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

public class AuthorHandlerTest {

    private AuthorHandler authorHandler;

    @Before
    public void beforeUp(){
        ArticleDao articleDao = new MockArticleDao(Mockito.any(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.any(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.any(DataSource.class));
        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        VBManualManagerImpl vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        SingleInstanceCreator.setTestData(vbManualManager, dataLoader, new JsonConverter(dataLoader));

        authorHandler = new AuthorHandler();
    }

    @Test
    public void addGetTest(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());

        Assert.assertEquals("{\"authorTotalNumber\":1,\"authors\":[{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"}]}", authorHandler.getAuthors(0, 100).getEntity());
    }

    @Test
    public void addGetTestAll(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());

        Assert.assertEquals("{\"authorTotalNumber\":1,\"authors\":[{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"}]}", authorHandler.getAllAuthors().getEntity());
    }

    @Test
    public void getAuthorTest(){
        authorHandler.addAuthor(new JSONObject().put("id", "1").put("firstName", "firstName").put("lastName", "lastName").put("speciality", "speciality").toString());

        Assert.assertEquals("{\"author\":{\"firstName\":\"firstName\",\"lastName\":\"lastName\",\"speciality\":\"speciality\",\"id\":\"1\"}}", authorHandler.getAuthor("1").getEntity());
    }



}
