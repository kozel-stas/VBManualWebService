package com.vb.manual.web.servlets;

import com.google.common.base.Preconditions;
import core.model.Article;
import core.model.Topic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Collectors;

public class ArticleServlet extends BaseHttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String id = getRequiredPropertyAsString(httpServletRequest, "id");
        String topicID = getRequiredPropertyAsString(httpServletRequest, "topicID");
        Topic topic = dataLoader.loadTopic(topicID);
        Article article = dataLoader.loadArticle(id);
        if (article != null && article.getTopicId().equals(topicID)) {
            httpServletRequest.setAttribute("article", article);
            httpServletRequest.setAttribute("topic", topic);
            httpServletRequest.setAttribute("author", dataLoader.loadAuthor(topic.getAuthorId()));
            httpServletRequest.setAttribute("authorT", dataLoader.loadAuthor(article.getAuthorId()));
            getServletContext().getRequestDispatcher("/WEB-INF/views/article.jsp").forward(httpServletRequest, httpServletResponse);
        } else {
            throw new ServletException("Article isn't exist.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String body = httpServletRequest.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        if (body != null && !body.trim().isEmpty()) {
            Article article = Preconditions.checkNotNull(mapper.readValue(body, Article.class));
            vbManualManager.addArticle(article);
            httpServletResponse.sendRedirect("/WebServer/topics?id=" + article.getTopicId());
        } else {
            throw new ServletException("Body is absent for request.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String topicID = getRequiredPropertyAsString(httpServletRequest, "topicID");
        String articleID = getRequiredPropertyAsString(httpServletRequest, "articleID");
        vbManualManager.deleteArticle(topicID, articleID);
        httpServletResponse.sendRedirect("/WebServer/topics?id=" + topicID);
    }

    @Override
    protected void doPut(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String body = httpServletRequest.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        if (body != null && !body.trim().isEmpty()) {
            Article article = Preconditions.checkNotNull(mapper.readValue(body, Article.class));
            vbManualManager.updateArticle(article);
            httpServletResponse.sendRedirect("/WebServer/article?id=" + article.getId() + "topicID=" + article.getTopicId());
        } else {
            throw new ServletException("Body is absent for request.");
        }
    }

}