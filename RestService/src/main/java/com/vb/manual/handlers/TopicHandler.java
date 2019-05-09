package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.model.Author;
import core.services.VBManualManager;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/topic")
public class TopicHandler {

    private final VBManualManager vbManualManager = SingleInstanceCreator.getVbManualManager();
    private final JsonConverter jsonConverter = SingleInstanceCreator.getJsonConverter();

    @GET
    @Path("/pages/{offset}/{limit}")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getTopics(@PathParam("offset") int offset, @PathParam("limit") int limit) {
        JSONArray res = new JSONArray();
        vbManualManager.getTopics(offset, limit).forEach(val -> res.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topicTotalNumber", vbManualManager.getTopicTotalNumber()).put("topics", res).toString()).build();
    }


    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getTopicsAll() {
        JSONArray res = new JSONArray();
        vbManualManager.getTopics(0, vbManualManager.getTopicTotalNumber()).forEach(val -> res.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("topicTotalNumber", vbManualManager.getTopicTotalNumber()).put("topics", res).toString()).build();
    }

    @GET
    @Path("/{topicID}")
    @Produces(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response getTopic(@PathParam("topicID") String topicID) {
        jsonConverter.validateTopicId(topicID);
        return Response.ok(new JSONObject().put("topic", jsonConverter.convertFrom(vbManualManager.getTopic(topicID))).toString()).build();
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response addTopic(String topic) {
        vbManualManager.addTopic(jsonConverter.convertToTopic(topic));
        return Response.ok().build();
    }

    @DELETE
    @Path("/{topicID}")
    @Consumes(MediaType.APPLICATION_JSON+";charset=utf-8")
    public Response deleteTopic(@PathParam("topicID") String topicID, String author) {
        jsonConverter.validateTopicId(topicID);
        Author author1 = jsonConverter.convertToAuthor(author);
        jsonConverter.validateAuthorId(author1.getId());
        vbManualManager.deleteTopic(topicID, author1);
        return Response.ok().build();
    }

}
