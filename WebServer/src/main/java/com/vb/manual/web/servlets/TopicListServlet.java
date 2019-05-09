package com.vb.manual.web.servlets;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TopicListServlet extends BaseHttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int page = getPropertyAsIntOrDefault(httpServletRequest, "page", 1);
        httpServletRequest.setAttribute("page", page);
        httpServletRequest.setAttribute("topicTotalNumber", vbManualManager.getTopicTotalNumber());
        httpServletRequest.setAttribute("topics", vbManualManager.getTopics((page - 1) * 10, 10));
        httpServletRequest.setAttribute("authors", vbManualManager.getAuthors(0, vbManualManager.getAuthorTotalNumber()));
        getServletContext().getRequestDispatcher("/WEB-INF/views/topics.jsp").forward(httpServletRequest, httpServletResponse);
    }

}
