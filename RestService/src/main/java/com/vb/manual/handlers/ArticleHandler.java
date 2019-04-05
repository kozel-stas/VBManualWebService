package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.model.Article;
import core.services.VBManualManager;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/article")
public class ArticleHandler {

    private final VBManualManager vbManualManager = SingleInstanceCreator.getVbManualManager();
    private final JsonConverter jsonConverter = SingleInstanceCreator.getJsonConverter();

    @GET
    @Path("/getArticles")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getArticles(@QueryParam("topicID") String topicID) {
        jsonConverter.validateTopicId(topicID);
        JSONArray jsonArray = new JSONArray();
        vbManualManager.getArticles(topicID).forEach(val -> jsonArray.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topicID", topicID).put("articles", jsonArray).toString()).build();
    }

    @POST
    @Path("/addArticle")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addArticle(@QueryParam("topicID") String topicID, String article) {
        jsonConverter.validateTopicId(topicID);
        Article article1 = jsonConverter.convertToArticle(article, topicID);
        jsonConverter.validateAuthorId(article1.getAuthorId());
        vbManualManager.addArticle(article1);
        return Response.ok().build();
    }

    @DELETE
    @Path("/deleteArticle")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteArticle(@QueryParam("topicID") String topicID, @QueryParam("articleID") String articleID) {
        jsonConverter.validateTopicId(topicID);
        jsonConverter.validateArticleId(articleID);
        vbManualManager.deleteArticle(topicID, articleID);
        return Response.ok().build();
    }

    @PUT
    @Path("/updateArticle")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateArticle(@QueryParam("topicID") String topicID, String article) {
        jsonConverter.validateTopicId(topicID);
        Article article1 = jsonConverter.convertToArticle(article, topicID);
        jsonConverter.validateArticleId(article1.getId());
        jsonConverter.validateAuthorId(article1.getAuthorId());
        vbManualManager.updateArticle(article1);
        return Response.ok().build();
    }

}