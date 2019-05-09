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

public class AuthorServletTest {

    private AuthorServlet authorServlet;
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

        authorServlet = new AuthorServlet();
        ServletConfig servletConfig = Mockito.mock(ServletConfig.class);
        servletContext = Mockito.mock(ServletContext.class);
        Mockito.doReturn(servletContext).when(servletConfig).getServletContext();
        authorServlet.init(servletConfig);

        requestDispatcher = Mockito.mock(RequestDispatcher.class);
        Mockito.doReturn(requestDispatcher).when(servletContext).getRequestDispatcher(Mockito.any());
    }

    @Test
    public void testDoGetWithoutPage() throws ServletException, IOException {
        authorServlet.doGet(new MockHttpServletRequest(), new MockHttpServletResponse());

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/authors.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }

    @Test
    public void testDoGet() throws ServletException, IOException {
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        mockHttpServletRequest.setParameter("page", "1");
        authorServlet.doGet(mockHttpServletRequest, new MockHttpServletResponse());

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/authors.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }

    @Test
    public void doPost() throws IOException, ServletException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        mockHttpServletRequest.setContent(new ObjectMapper().writeValueAsBytes(new Author("NAN", "firstName2", "lastName2", "speciality2")));

        authorServlet.doPost(mockHttpServletRequest, mockHttpServletResponse);

        Assert.assertEquals("/WebServer/authors", mockHttpServletResponse.getHeader("Location"));
        Mockito.verify(servletContext, Mockito.times(0)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/authors.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(0)).forward(Mockito.any(), Mockito.any());
    }
}