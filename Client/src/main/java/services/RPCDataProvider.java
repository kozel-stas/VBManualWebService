package services;

import com.service.axis.manual.vb.VBManualManagerSOAPStub;
import model.Article;
import model.Author;
import model.Topic;
import org.apache.axis2.AxisFault;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import rpc.service.gen.VBManualService;

import java.util.List;
import java.util.stream.Collectors;

public class RPCDataProvider implements DataProvider {

    private TTransport transport;
    private TProtocol protocol;
    private VBManualService.Client client;
    private RequestResponseConverter requestResponseConverter;

    public RPCDataProvider() throws TTransportException {
        transport = new TSocket("localhost", 9090);
        protocol = new TBinaryProtocol(transport);
        client = new VBManualService.Client(protocol);
        transport.open();
        requestResponseConverter = new RequestResponseConverter();
    }

    @Override
    public Author getAuthor(String id) throws TException {
        return requestResponseConverter.convertFrom(client.getAuthor(id));
    }

    @Override
    public Author registerAuthor(Author author) throws TException {
        client.addAuthor(requestResponseConverter.convertFrom(author));
        return getAuthor(author.getId());
    }

    @Override
    public List<Topic> getTopics() throws TException {
        List<rpc.service.gen.Topic> topics = client.getTopics();
        return topics.stream().map(val -> requestResponseConverter.convertFrom(val)).collect(Collectors.toList());
    }

    @Override
    public List<Article> getArticles(String topicID) throws TException {
        List<rpc.service.gen.Article> articles = client.getArticles(topicID);
        return articles.stream().map(val -> requestResponseConverter.convertFrom(val)).collect(Collectors.toList());
    }

}
