package com.vb.manual.web.filter;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter {

    private static final org.apache.log4j.Logger LOG = org.apache.log4j.Logger.getLogger(EncodingFilter.class);

    public void init(FilterConfig filterConfig) {
        LOG.debug("EncodingFilter created.");
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
        response.setCharacterEncoding("UTF-8");
    }

    public void destroy() {
        LOG.debug("EncodingFilter destroyed.");
    }

}

