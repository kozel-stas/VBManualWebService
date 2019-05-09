package com.vb.manual.web.filter;


import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import java.io.IOException;

public class EncodingFilterTest {

    private EncodingFilter encodingFilter;

    @Before
    public void beforeUp() {
        encodingFilter = new EncodingFilter();
        encodingFilter.init(Mockito.mock(FilterConfig.class));
    }

    @After
    public void afterDown() {
        encodingFilter.destroy();
    }

    @Test
    public void testDoFilter() throws IOException, ServletException {
        MockHttpServletRequest mockHttpServletRequest = new MockHttpServletRequest();
        MockHttpServletResponse mockHttpServletResponse = new MockHttpServletResponse();
        mockHttpServletRequest.setCharacterEncoding("UTF-16");
        mockHttpServletResponse.setCharacterEncoding("UTF-16");

        encodingFilter.doFilter(mockHttpServletRequest, mockHttpServletResponse, Mockito.mock(FilterChain.class));

        Assert.assertEquals("UTF-8", mockHttpServletRequest.getCharacterEncoding());
        Assert.assertEquals("UTF-8", mockHttpServletResponse.getCharacterEncoding());
    }

}