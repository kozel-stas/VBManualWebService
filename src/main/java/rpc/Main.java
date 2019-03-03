package rpc;

import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManager;
import core.services.VBManualManagerImpl;
import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import rpc.service.gen.VBManualService;

import javax.sql.DataSource;
import java.sql.DriverManager;

public class Main {

    public static void main(String[] args) throws InterruptedException, TException, ClassNotFoundException {

        DataSource dataSource = new DriverManagerDataSource(ConfigConstants.DB_URL, ConfigConstants.DB_LOGIN, ConfigConstants.DB_PASSWORD);
        ((DriverManagerDataSource) dataSource).setDriverClassName("com.mysql.jdbc.Driver");

        ArticleDao articleDao = new ArticleDao(dataSource);
        TopicDao topicDao = new TopicDao(dataSource);
        AuthorDao authorDao = new AuthorDao(dataSource);

        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);

        VBManualManager vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);

        RPCServer server = new RPCServer(dataLoader, vbManualManager);
        server.startServerAsync();
        Thread.sleep(1000);

        TTransport transport;
        transport = new TSocket("localhost", 9090);
        transport.open();
        TProtocol protocol = new TBinaryProtocol(transport);
        VBManualService.Client client = new VBManualService.Client(protocol);
        System.out.println(client.getTopics());
        transport.close();
    }

}
