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

public class ArticleRedactorServletTest {

    private ArticleRedactorServlet articleRedactorServlet;
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

        articleRedactorServlet = new ArticleRedactorServlet();
        ServletConfig servletConfig = Mockito.mock(ServletConfig.class);
        servletContext = Mockito.mock(ServletContext.class);
        Mockito.doReturn(servletContext).when(servletConfig).getServletContext();
        articleRedactorServlet.init(servletConfig);

        requestDispatcher = Mockito.mock(RequestDispatcher.class);
        Mockito.doReturn(requestDispatcher).when(servletContext).getRequestDispatcher(Mockito.any());
    }

    @Test(expected = ServletException.class)
    public void testDoGetNoData() throws ServletException, IOException {
        articleRedactorServlet.doGet(new MockHttpServletRequest(), new MockHttpServletResponse());
    }

    @Test()
    public void testDoGetWithoutArticleID() throws ServletException, IOException {
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        mockHttpServletRequest.setParameter("topicID", "1");

        articleRedactorServlet.doGet(mockHttpServletRequest, mockHttpServletResponse);

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/articleRed.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }


    @Test()
    public void testDoGet() throws ServletException, IOException {
        SingleInstanceCreator.getVbManualManager().addAuthor(new Author("NAN", "firstName", "lastName", "speciality"));
        SingleInstanceCreator.getVbManualManager().addTopic(new Topic("NAN", "name", "1"));
        SingleInstanceCreator.getVbManualManager().addArticle(new Article("NAN", "name", "content", "1", "1"));
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        mockHttpServletRequest.setParameter("topicID", "1");
        mockHttpServletRequest.setParameter("articleID", "1");

        articleRedactorServlet.doGet(mockHttpServletRequest, mockHttpServletResponse);

        Mockito.verify(servletContext, Mockito.times(1)).getRequestDispatcher(Mockito.eq("/WEB-INF/views/articleRed.jsp"));
        Mockito.verify(requestDispatcher, Mockito.times(1)).forward(Mockito.any(), Mockito.any());
    }

}