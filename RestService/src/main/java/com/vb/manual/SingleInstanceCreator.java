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

import javax.sql.DataSource;

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
    }

    @VisibleForTesting
    public static void setTestData(VBManualManager vbManualManager, DataLoader dataLoader, JsonConverter jsonConverter) {
        SingleInstanceCreator.dataLoader = dataLoader;
        SingleInstanceCreator.vbManualManager = vbManualManager;
        SingleInstanceCreator.jsonConverter = jsonConverter;
    }
}
