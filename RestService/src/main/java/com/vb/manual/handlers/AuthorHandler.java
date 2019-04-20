package com.vb.manual.handlers;

import com.vb.manual.JsonConverter;
import com.vb.manual.SingleInstanceCreator;
import core.services.VBManualManager;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/author")
public class AuthorHandler {

    private final VBManualManager vbManualManager = SingleInstanceCreator.getVbManualManager();
    private final JsonConverter jsonConverter = SingleInstanceCreator.getJsonConverter();

    @GET
    @Path("/pages/{offset}/{limit}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAuthors(@PathParam("offset") int offset, @PathParam("limit") int limit) {
        JSONArray res = new JSONArray();
        vbManualManager.getAuthors(offset, limit).forEach(val -> res.put(jsonConverter.convertFrom(val)));
        return Response.ok(new JSONObject().put("authors", res).put("authorTotalNumber", vbManualManager.getAuthorTotalNumber()).toString()).build();
    }

    @GET
    @Path("/{authorID}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAuthor(@PathParam("authorID") String authorId) {
        jsonConverter.validateAuthorId(authorId);
        return Response.ok(new JSONObject().put("author", jsonConverter.convertFrom(vbManualManager.getAuthor(authorId))).toString()).build();
    }


    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addAuthor(String author) {
        vbManualManager.addAuthor(jsonConverter.convertToAuthor(author));
        return Response.ok().build();
    }

}