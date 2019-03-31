package services;

import com.service.axis.manual.vb.VBManualManagerSOAPStub;
import model.Article;
import model.Author;
import model.Topic;

public class SOAPRequestResponseConverter {

    VBManualManagerSOAPStub.Author convertFrom(Author author) {
        VBManualManagerSOAPStub.Author author1 = new VBManualManagerSOAPStub.Author();
        author1.setId(author.getId());
        author1.setFirstName(author.getFirstName());
        author1.setLastName(author.getLastName());
        author1.setSpeciality(author.getSpeciality());
        return author1;
    }

    Author convertFrom(VBManualManagerSOAPStub.Author author) {
        return new Author(author.getId(), author.getFirstName(), author.getLastName(), author.getSpeciality());
    }

    VBManualManagerSOAPStub.Topic convertFrom(Topic topic) {
        VBManualManagerSOAPStub.Topic topic1 = new VBManualManagerSOAPStub.Topic();
        topic1.setId(topic.getId());
        topic1.setName(topic.getName());
        topic1.setAuthor(convertFrom(topic.getAuthor()));
        return topic1;
    }

    Topic convertFrom(VBManualManagerSOAPStub.Topic topic) {
        return new Topic(topic.getId(), topic.getName(), convertFrom(topic.getAuthor()));
    }

    VBManualManagerSOAPStub.Article convertFrom(Article article) {
        VBManualManagerSOAPStub.Article article1 = new VBManualManagerSOAPStub.Article();
        article1.setId(article.getId());
        article1.setName(article.getName());
        article1.setContent(article.getContent());
        article1.setAuthor(convertFrom(article.getAuthor()));
        return article1;
    }

    Article convertFrom(VBManualManagerSOAPStub.Article article) {
        return new Article(article.getId(), article.getName(), article.getContent(), convertFrom(article.getAuthor()));
    }

}
