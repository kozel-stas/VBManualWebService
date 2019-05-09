package com.vb.manual.web.servlets;

import com.vb.manual.web.SingleInstanceCreator;
import com.vb.manual.web.utils.MockArticleDao;
import com.vb.manual.web.utils.MockAuthorDao;
import com.vb.manual.web.utils.MockTopicDao;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManagerImpl;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.sql.DataSource;

import java.io.IOException;

import static org.junit.Assert.*;

public class TopicServletTest {

    private TopicServlet topicServlet;
    private ServletContext servletContext;
    private RequestDispatcher requestDispatcher;

    @Before
    public void beforeUp() throws ServletException {
        ArticleDao articleDao = new MockArticleDao(Mockito.mock(DataSource.class));
        AuthorDao authorDao = new MockAuthorDao(Mockito.mock(DataSource.class));
        TopicDao topicDao = new MockTopicDao(Mockito.mock(DataSource.class));
        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        VBManualManagerImpl vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        SingleInstanceCreator.setDataForTest(dataLoader, vbManualManager);

        topicServlet = new TopicServlet();
        ServletConfig servletConfig = Mockito.mock(ServletConfig.class);
        servletContext = Mockito.mock(ServletContext.class);
        Mockito.doReturn(servletContext).when(servletConfig).getServletContext();
        topicServlet.init(servletConfig);

        requestDispatcher = Mockito.mock(RequestDispatcher.class);
        Mockito.doReturn(requestDispatcher).when(servletContext).getRequestDispatcher(Mockito.any());
    }

    @Test
    public void testDoGetWithoutPage() throws ServletException, IOException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        mockHttpServletRequest.setParameter("id", "1");
        topicServlet.doGet(mockHttpServletRequest, new MockHttpServletResponse());

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/topic.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }

    @Test
    public void testDoGet() throws ServletException, IOException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        mockHttpServletRequest.setParameter("page", "1");
        mockHttpServletRequest.setParameter("id", "1");
        topicServlet.doGet(mockHttpServletRequest, new MockHttpServletResponse());

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/topic.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }

    @Test
    public void doPost() throws IOException, ServletException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        mockHttpServletRequest.setContent(new ObjectMapper().writeValueAsBytes(new Topic("NAN", "firstName2", "1")));

        topicServlet.doPost(mockHttpServletRequest, mockHttpServletResponse);

        Assert.assertEquals("/WebServer/topics", mockHttpServletResponse.getHeader("Location"));
        Mockito.verify(servletContext, Mockito.times(0)).getRequestDispatcher(Mockito.any());
        Mockito.verify(requestDispatcher, Mockito.times(0)).forward(Mockito.any(), Mockito.any());
    }

    @Test
    public void doDelete() throws IOException, ServletException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("topicID", "1");
        jsonObject.put("author", new JSONObject(new ObjectMapper().writeValueAsString(new Author("1", "firstName", "lastName", "speciality"))));
        mockHttpServletRequest.setContent(jsonObject.toString().getBytes());

        topicServlet.doDelete(mockHttpServletRequest, mockHttpServletResponse);

        Assert.assertEquals("/WebServer/topics", mockHttpServletResponse.getHeader("Location"));
        Mockito.verify(servletContext, Mockito.times(0)).getRequestDispatcher(Mockito.any());
        Mockito.verify(requestDispatcher, Mockito.times(0)).forward(Mockito.any(), Mockito.any());
    }

}