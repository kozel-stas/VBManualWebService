package com.vb.manual.web.servlets;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vb.manual.web.SingleInstanceCreator;
import core.services.DataLoader;
import core.services.VBManualManager;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

public abstract class BaseHttpServlet extends HttpServlet {

    protected final Logger LOG = Logger.getLogger(this.getClass().getName());

    protected VBManualManager vbManualManager;
    protected DataLoader dataLoader;
    protected ObjectMapper mapper = new ObjectMapper();

    @Override
    public void init() throws ServletException {
        super.init();
        vbManualManager = SingleInstanceCreator.getVbManualManager();
        dataLoader = SingleInstanceCreator.getDataLoader();
    }

    protected static int getPropertyAsIntOrDefault(HttpServletRequest request, String property, int defaultP) {
        String prop = request.getParameter(property);
        if (prop != null && !prop.isEmpty()) {
            return Integer.parseInt(prop);
        }
        return defaultP;
    }

    protected static String getRequiredPropertyAsString(HttpServletRequest request, String property) throws ServletException {
        String prop = request.getParameter(property);
        if (prop != null && !prop.isEmpty()) {
            return prop;
        }
        throw new ServletException("Property '" + property + "' is absent.");
    }

    protected static String getPropertyAsString(HttpServletRequest request, String property) throws ServletException {
        return request.getParameter(property);
    }

}
