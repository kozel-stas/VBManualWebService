package com.vb.manual.web.tags;

import core.model.Author;
import core.model.Topic;

import java.io.IOException;
import java.util.Collection;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.TagSupport;

public class ConverterTag extends TagSupport {

    private Collection<Author> authors;
    private Collection<Topic> topics;
    private String arrayName;

    @Override
    public void setPageContext(PageContext pageContext) {
        this.pageContext = pageContext;
        super.setPageContext(pageContext);
    }

    public void setAuthors(Collection authors) {
        this.authors = authors;
    }

    public void setTopics(Collection topics) {
        this.topics = topics;
    }

    public void setArrayName(String arrayName) {
        this.arrayName = arrayName;
    }

    @Override
    public int doStartTag() throws JspException {
        try {
            StringBuilder stringBuilder = new StringBuilder();
            for (Topic topic : topics) {
                Author curAuthor = null;
                for (Author author : authors) {
                    if (author.getId().equals(topic.getAuthorId())) {
                        curAuthor = author;
                        break;
                    }
                }
                stringBuilder.append(arrayName).append(".push(")
                        .append("new Topic(\"").append(topic.getId()).append("\",\"").append(topic.getName()).append("\",")
                        .append("new Author(\"").append(curAuthor.getId()).append("\",\"").append(curAuthor.getFirstName())
                        .append("\",\"").append(curAuthor.getLastName()).append("\",\"").append(curAuthor.getSpeciality()).append("\"))").append(");").append('\n');
            }
            pageContext.getOut().write(stringBuilder.toString());
        } catch (IOException e) {
            throw new JspException(e.getMessage());
        }
        return SKIP_BODY;
    }

    @Override
    public int
    doEndTag() throws JspException {
        return EVAL_PAGE;
    }

}


