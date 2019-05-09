package com.vb.manual.web.servlets;

import core.model.Article;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ArticleRedactorServlet extends BaseHttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String topicID = getRequiredPropertyAsString(httpServletRequest, "topicID");
        httpServletRequest.setAttribute("topicID", topicID);
        httpServletRequest.setAttribute("authors", vbManualManager.getAuthors(0, vbManualManager.getAuthorTotalNumber()));
        String articleID = getPropertyAsString(httpServletRequest, "articleID");
        Article article = dataLoader.loadArticle(articleID);
        if (article != null && article.getTopicId().equals(topicID)) {
            httpServletRequest.setAttribute("article", article);
            httpServletRequest.setAttribute("author", dataLoader.loadAuthor(article.getAuthorId()));
        }
        getServletContext().getRequestDispatcher("/WEB-INF/views/articleRed.jsp").forward(httpServletRequest, httpServletResponse);
    }
}
