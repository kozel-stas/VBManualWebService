package com.vb.manual.handlers;


import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class NPEMapper implements ExceptionMapper<NullPointerException> {

    @Override
    public Response toResponse(NullPointerException e) {
        return Response.serverError().status(Response.Status.BAD_REQUEST).entity(e.getLocalizedMessage()).build();
    }

}
