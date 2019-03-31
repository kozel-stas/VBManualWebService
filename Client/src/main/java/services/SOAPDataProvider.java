package services;

import com.service.axis.manual.vb.VBManualManagerSOAPStub;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import model.Article;
import model.Author;
import model.Topic;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class SOAPDataProvider implements DataProvider {

    private static final Logger LOG = LogManager.getLogger(SOAPDataProvider.class);

    private final VBManualManagerSOAPStub vbManualManagerSOAPStub;
    private final SOAPRequestResponseConverter soapRequestResponseConverter;

    public SOAPDataProvider() throws RemoteException {
        vbManualManagerSOAPStub = new VBManualManagerSOAPStub("http://localhost/axis2/services/VBManualSOAPService");
        soapRequestResponseConverter = new SOAPRequestResponseConverter();
    }

    @Override
    public List<Author> getAuthors() {
        try {
            VBManualManagerSOAPStub.GetAuthor authorRequest = new VBManualManagerSOAPStub.GetAuthor();
            VBManualManagerSOAPStub.Author[] authors = vbManualManagerSOAPStub.getAuthor(authorRequest).get_return();
            List<Author> res = new ArrayList<>();
            for (VBManualManagerSOAPStub.Author author : authors) {
                res.add(soapRequestResponseConverter.convertFrom(author));
            }
            return res;
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public Author registerAuthor(Author author) {
        VBManualManagerSOAPStub.AddAuthor getAuthor = new VBManualManagerSOAPStub.AddAuthor();
        getAuthor.setAuthor(soapRequestResponseConverter.convertFrom(author));
        return author;
    }

    @Override
    public List<Topic> getTopics() {
        try {
            List<Topic> topics = new ArrayList<>();
            for (VBManualManagerSOAPStub.Topic topic : vbManualManagerSOAPStub.getTopics(new VBManualManagerSOAPStub.GetTopics()).get_return()) {
                topics.add(soapRequestResponseConverter.convertFrom(topic));
            }
            return topics;
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public List<Article> getArticles(String topicID) {
        try {
            VBManualManagerSOAPStub.GetArticles getArticles = new VBManualManagerSOAPStub.GetArticles();
            getArticles.setTopicId(topicID);
            VBManualManagerSOAPStub.Article[] articles = vbManualManagerSOAPStub.getArticles(getArticles).get_return();
            List<Article> res = new ArrayList<>();
            for (VBManualManagerSOAPStub.Article article : articles) {
                res.add(soapRequestResponseConverter.convertFrom(article));
            }
            return res;
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return Collections.emptyList();
    }

    @Override
    public Topic addTopic(Topic topic) {
        VBManualManagerSOAPStub.AddTopic addTopic = new VBManualManagerSOAPStub.AddTopic();
        addTopic.setTopic(soapRequestResponseConverter.convertFrom(topic));
        try {
            vbManualManagerSOAPStub.addTopic(addTopic);
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return topic;
    }

    @Override
    public void deleteTopic(Topic topic) {
        VBManualManagerSOAPStub.DeleteTopic deleteTopic = new VBManualManagerSOAPStub.DeleteTopic();
        deleteTopic.setTopicId(topic.getId());
        deleteTopic.setAuthor(soapRequestResponseConverter.convertFrom(topic.getAuthor()));
        try {
            vbManualManagerSOAPStub.deleteTopic(deleteTopic);
        } catch (RemoteException e) {
            LOG.error(e);
        }
    }

    @Override
    public Article addArticle(String topicID, Article article) {
        VBManualManagerSOAPStub.AddArticle addArticle = new VBManualManagerSOAPStub.AddArticle();
        addArticle.setTopicID(article.getId());
        addArticle.setArticle(soapRequestResponseConverter.convertFrom(article));
        try {
            vbManualManagerSOAPStub.addArticle(addArticle);
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return article;
    }

    @Override
    public Article updateArticle(String topicID, Article article) {
        VBManualManagerSOAPStub.UpdateArticle updateArticle = new VBManualManagerSOAPStub.UpdateArticle();
        updateArticle.setTopicID(article.getId());
        updateArticle.setArticle(soapRequestResponseConverter.convertFrom(article));
        try {
            vbManualManagerSOAPStub.updateArticle(updateArticle);
        } catch (RemoteException e) {
            LOG.error(e);
        }
        return article;
    }

    @Override
    public String toString() {
        return "SOAP";
    }
}
