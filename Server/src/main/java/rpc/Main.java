package rpc;

import com.mysql.cj.jdbc.MysqlDataSource;
import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManager;
import core.services.VBManualManagerImpl;

import javax.sql.DataSource;

public class Main {

    public static void main(String[] args) {
        DataSource dataSource = new MysqlDataSource();
        ((MysqlDataSource) dataSource).setPassword(ConfigConstants.DB_PASSWORD);
        ((MysqlDataSource) dataSource).setUser(ConfigConstants.DB_LOGIN);
        ((MysqlDataSource) dataSource).setURL(ConfigConstants.DB_URL);

        ArticleDao articleDao = new ArticleDao(dataSource);
        TopicDao topicDao = new TopicDao(dataSource);
        AuthorDao authorDao = new AuthorDao(dataSource);

        DataLoader dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);

        VBManualManager vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);

        RPCServer server = new RPCServer(dataLoader, vbManualManager);
        server.startServerAsync();
    }

}
