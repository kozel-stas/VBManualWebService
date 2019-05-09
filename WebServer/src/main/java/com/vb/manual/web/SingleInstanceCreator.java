package com.vb.manual.web;

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

    private static synchronized void createDeps() {
        if (dataLoader != null && vbManualManager != null) {
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
    }

    @VisibleForTesting
    public static void setDataForTest(DataLoader dataForTest, VBManualManager vbManualManagerForTest) {
        dataLoader = dataForTest;
        vbManualManager = vbManualManagerForTest;
    }

}
