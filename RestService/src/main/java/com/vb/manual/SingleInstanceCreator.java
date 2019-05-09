package com.vb.manual;

import com.google.common.annotations.VisibleForTesting;
import com.mysql.cj.jdbc.MysqlDataSource;
import core.config.ConfigConstants;
import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.services.DataLoader;
import core.services.ProxyDataLoader;
import core.services.VBManualManager;
import core.services.VBManualManagerImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.LoggerContext;
import org.apache.logging.log4j.core.appender.ConsoleAppender;

import javax.sql.DataSource;
import java.net.URISyntaxException;
import java.net.URL;

public class SingleInstanceCreator {

    private static DataLoader dataLoader;
    private static VBManualManager vbManualManager;
    private static JsonConverter jsonConverter;

    public static DataLoader getDataLoader() {
        if (dataLoader == null) {
            createDeps();
        }
        return dataLoader;
    }

    public static VBManualManager getVbManualManager() {
        if (vbManualManager == null) {
            createDeps();
        }
        return vbManualManager;
    }

    public static JsonConverter getJsonConverter() {
        if (jsonConverter == null) {
            createDeps();
        }
        return jsonConverter;
    }

    private static synchronized void createDeps() {
        if (dataLoader != null && vbManualManager != null && jsonConverter != null) {
            return;
        }
        DataSource dataSource = new MysqlDataSource();
        ((MysqlDataSource) dataSource).setPassword(ConfigConstants.DB_PASSWORD);
        ((MysqlDataSource) dataSource).setUser(ConfigConstants.DB_LOGIN);
        ((MysqlDataSource) dataSource).setURL(ConfigConstants.DB_URL);
        ArticleDao articleDao = new ArticleDao(dataSource);
        TopicDao topicDao = new TopicDao(dataSource);
        AuthorDao authorDao = new AuthorDao(dataSource);
        dataLoader = new ProxyDataLoader(articleDao, topicDao, authorDao);
        vbManualManager = new VBManualManagerImpl(articleDao, topicDao, authorDao, dataLoader);
        jsonConverter = new JsonConverter(dataLoader);
        configureLogger();
    }

    private static void configureLogger() {
        final LoggerContext ctx = (LoggerContext) LogManager.getContext(false);
        URL url = ArticleDao.class.getClassLoader().getResource("src/test/resources/log4j2.xml");
        if (url != null) {
            try {
                ctx.setConfigLocation(url.toURI());
            } catch (URISyntaxException e) {
                e.printStackTrace();
                ctx.getConfiguration().addAppender(new ConsoleAppender.Builder<>().build());
            }
        } else {
            ctx.getConfiguration().addAppender(new ConsoleAppender.Builder<>().build());
        }
        ctx.updateLoggers();
        LogManager.getLogger(SingleInstanceCreator.class).warn("Logger was successfully initialized.");
    }

    @VisibleForTesting
    public static void setTestData(VBManualManager vbManualManager, DataLoader dataLoader, JsonConverter jsonConverter) {
        SingleInstanceCreator.dataLoader = dataLoader;
        SingleInstanceCreator.vbManualManager = vbManualManager;
        SingleInstanceCreator.jsonConverter = jsonConverter;
    }
}
