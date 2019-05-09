package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.model.Article;
import core.model.Topic;
import core.services.VBManualManager;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.LogManager;

@Path("/article")
public class ArticleHandler {

    private final VBManualManager vbManualManager = SingleInstanceCreator.getVbManualManager();
    private final JsonConverter jsonConverter = SingleInstanceCreator.getJsonConverter();

    @GET
    @Path("/{topicID}/pages/{offset}/{limit}")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getArticles(@PathParam("topicID") String topicID, @PathParam("offset") int offset, @PathParam("limit") int limit) {
        org.apache.logging.log4j.LogManager.getLogger(ArticleHandler.class).error("sqfdqwfqwfqwf");
        jsonConverter.validateTopicId(topicID);
        JSONArray jsonArray = new JSONArray();
        vbManualManager.getArticles(topicID, offset, limit).forEach(val -> jsonArray.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topicID", topicID).put("articles", jsonArray).toString()).build();
    }

    @GET
    @Path("/{topicID}")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getArticles(@PathParam("topicID") String topicID) {
        jsonConverter.validateTopicId(topicID);
        JSONArray jsonArray = new JSONArray();
        vbManualManager.getArticles(topicID, 0, vbManualManager.getArticleTotalNumber(topicID)).forEach(val -> jsonArray.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topicID", topicID).put("articleTotalNumber", vbManualManager.getArticleTotalNumber(topicID)).put("articles", jsonArray).toString()).build();
    }

    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getArticles() {
        JSONArray res = new JSONArray();
        for (Topic topic: vbManualManager.getTopics(0, vbManualManager.getTopicTotalNumber())) {
            JSONArray jsonArray = new JSONArray();
            vbManualManager.getArticles(topic.getId(), 0, vbManualManager.getArticleTotalNumber(topic.getId())).forEach(val -> jsonArray.put(jsonConverter.convertFrom(val)));
            res.put(new JSONObject().put("topicID", topic.getId()).put("articleTotalNumber", vbManualManager.getArticleTotalNumber(topic.getId())).put("articles", jsonArray));
        }
        return Response.ok(res.toString()).build();
    }

    @GET
    @Path("/{topicID}/{articleID}")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getArticle(@PathParam("topicID") String topicID, @PathParam("articleID") String articleID) {
        jsonConverter.validateTopicId(topicID);
        jsonConverter.validateArticleId(articleID);
            return Response.ok(new JSONObject().put("topicID", topicID).put("article", jsonConverter.convertFrom(vbManualManager.getArticle(articleID, topicID))).toString()).build();
    }

    @POST
    @Path("/{topicID}")
    @Consumes(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response addArticle(@PathParam("topicID") String topicID, String article) {
        jsonConverter.validateTopicId(topicID);
        Article article1 = jsonConverter.convertToArticle(article, topicID);
        jsonConverter.validateAuthorId(article1.getAuthorId());
        vbManualManager.addArticle(article1);
        return Response.ok().build();
    }

    @DELETE
    @Path("/{topicID}/{articleID}")
    @Consumes(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response deleteArticle(@PathParam("topicID") String topicID, @PathParam("articleID") String articleID) {
        jsonConverter.validateTopicId(topicID);
        jsonConverter.validateArticleId(articleID);
        vbManualManager.deleteArticle(topicID, articleID);
        return Response.ok().build();
    }

    @PUT
    @Path("/{topicID}")
    @Consumes(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response updateArticle(@PathParam("topicID") String topicID, String article) {
        jsonConverter.validateTopicId(topicID);
        Article article1 = jsonConverter.convertToArticle(article, topicID);
        jsonConverter.validateArticleId(article1.getId());
        jsonConverter.validateAuthorId(article1.getAuthorId());
        vbManualManager.updateArticle(article1);
        return Response.ok().build();
    }

}