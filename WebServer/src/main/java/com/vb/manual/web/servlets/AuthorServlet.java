package com.vb.manual.web.servlets;

import com.google.common.base.Preconditions;
import core.model.Author;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Collectors;

public class AuthorServlet extends BaseHttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int page = getPropertyAsIntOrDefault(httpServletRequest, "page", 1);
        httpServletRequest.setAttribute("page", page);
        httpServletRequest.setAttribute("authors", vbManualManager.getAuthors((page - 1) * 10, 10));
        httpServletRequest.setAttribute("authorTotalNumber", vbManualManager.getAuthorTotalNumber());
        getServletContext().getRequestDispatcher("/WEB-INF/views/authors.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String body = httpServletRequest.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        if (body != null && !body.trim().isEmpty()) {
            Author author = Preconditions.checkNotNull(mapper.readValue(body, Author.class));
            vbManualManager.addAuthor(author);
            httpServletResponse.sendRedirect("/WebServer/authors");
        } else {
            throw new ServletException("Body is absent for request.");
        }
    }

}
