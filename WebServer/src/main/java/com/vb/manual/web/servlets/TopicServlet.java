package com.vb.manual.web.servlets;

import com.google.common.base.Preconditions;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.stream.Collectors;

public class TopicServlet extends BaseHttpServlet {

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        int page = getPropertyAsIntOrDefault(httpServletRequest, "page", 1);
        String topicID = getRequiredPropertyAsString(httpServletRequest, "id");
        httpServletRequest.setAttribute("page", page);
        httpServletRequest.setAttribute("articleTotalNumber", vbManualManager.getArticleTotalNumber(topicID));
        httpServletRequest.setAttribute("topic", dataLoader.loadTopic(topicID));
        httpServletRequest.setAttribute("authorT", dataLoader.loadAuthor(dataLoader.loadTopic(topicID).getAuthorId()));
        httpServletRequest.setAttribute("articles", vbManualManager.getArticles(topicID, (page - 1) * 10, 10));
        HashMap<String, Author> authorHashMap = new HashMap<>();
        for (Article article : vbManualManager.getArticles(topicID, (page - 1) * 10, 10)) {
            Author author = dataLoader.loadAuthor(article.getAuthorId());
            authorHashMap.put(author.getId(), author);
        }
        httpServletRequest.setAttribute("authors", authorHashMap);
        getServletContext().getRequestDispatcher("/WEB-INF/views/topic.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String body = httpServletRequest.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        if (body != null && !body.trim().isEmpty()) {
            Topic topic = Preconditions.checkNotNull(mapper.readValue(body, Topic.class));
            vbManualManager.addTopic(topic);
            httpServletResponse.sendRedirect("/WebServer/topics");
        } else {
            throw new ServletException("Body is absent for request.");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String body = httpServletRequest.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
        if (body != null && !body.trim().isEmpty()) {
            JSONObject jsonObject = new JSONObject(body);
            vbManualManager.deleteTopic(jsonObject.getString("topicID"), mapper.readValue(jsonObject.getJSONObject("author").toString(), Author.class));
            httpServletResponse.sendRedirect("/WebServer/topics");
        } else {
            throw new ServletException("Body is absent for request.");
        }
    }

}
