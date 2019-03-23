package services;

import model.Author;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import rpc.service.gen.VBManualService;

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

}
