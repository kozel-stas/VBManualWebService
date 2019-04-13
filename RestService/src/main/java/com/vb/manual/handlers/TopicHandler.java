package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.model.Author;
import core.services.VBManualManager;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/topic")
public class TopicHandler {

    private final VBManualManager vbManualManager = SingleInstanceCreator.getVbManualManager();
    private final JsonConverter jsonConverter = SingleInstanceCreator.getJsonConverter();

    @GET
    @Path("/getTopics")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTopics(@QueryParam("offset") int offset, @QueryParam("limit") int limit) {
        JSONArray res = new JSONArray();
        vbManualManager.getTopics(offset, limit).forEach(val -> res.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topics", res).toString()).build();
    }

    @GET
    @Path("/getTopic")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTopic(@QueryParam("topicID") String topicID) {
        jsonConverter.validateTopicId(topicID);
        return Response.ok(new JSONObject().put("topic", jsonConverter.convertFrom(vbManualManager.getTopic(topicID))).toString()).build();
    }

    @GET
    @Path("/getTopicTotalNumber")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTopicTotalNumber() {
        return Response.ok(new JSONObject().put("topicTotalNumber", vbManualManager.getTopicTotalNumber()).toString()).build();
    }

    @POST
    @Path("/addTopic")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addTopic(String topic) {
        vbManualManager.addTopic(jsonConverter.convertToTopic(topic));
        return Response.ok().build();
    }

    @DELETE
    @Path("/deleteTopic")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response deleteTopic(@QueryParam("topicID") String topicID, String author) {
        jsonConverter.validateTopicId(topicID);
        Author author1 = jsonConverter.convertToAuthor(author);
        jsonConverter.validateAuthorId(author1.getId());
        vbManualManager.deleteTopic(topicID, author1);
        return Response.ok().build();
    }

}
