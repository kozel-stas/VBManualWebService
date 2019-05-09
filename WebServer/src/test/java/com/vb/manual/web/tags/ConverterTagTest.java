package com.vb.manual.web.tags;

import com.google.common.collect.ImmutableList;
import core.model.Author;
import core.model.Topic;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.io.IOException;

public class ConverterTagTest {

    private ConverterTag converterTag;

    @Before
    public void beforeUp() {
        converterTag = new ConverterTag();
    }

    @Test
    public void doStartTag() throws JspException, IOException {
        PageContext pageContext = Mockito.mock(PageContext.class);
        JspWriter jspWriter = Mockito.mock(JspWriter.class);
        Mockito.doReturn(jspWriter).when(pageContext).getOut();
        converterTag.setPageContext(pageContext);
        converterTag.setArrayName("res");
        converterTag.setTopics(ImmutableList.of(new Topic("1", "a1", "2"), new Topic("3", "a1", "4")));
        converterTag.setAuthors(ImmutableList.of(new Author("2", "a1", "2", "3"), new Author("4", "a1", "4", "5")));

        Assert.assertEquals(0, converterTag.doStartTag());
        Mockito.verify(jspWriter, Mockito.times(1)).write(Mockito.eq("res.push(new Topic(\"1\",\"a1\",new Author(\"2\",\"a1\",\"2\",\"3\")));\n" +
                "res.push(new Topic(\"3\",\"a1\",new Author(\"4\",\"a1\",\"4\",\"5\")));\n"));
    }

    @Test
    public void doEndTag() throws Exception {
        Assert.assertEquals(6, converterTag.doEndTag());
    }
}