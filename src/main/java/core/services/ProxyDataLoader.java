package core.services;

import core.dao.ArticleDao;
import core.dao.AuthorDao;
import core.dao.TopicDao;
import core.model.Article;
import core.model.Author;
import core.model.Topic;

public class ProxyDataLoader implements DataLoader {

    private final ArticleDao articleDao;
    private final TopicDao topicDao;
    private final AuthorDao authorDao;

    public ProxyDataLoader(ArticleDao articleDao, TopicDao topicDao, AuthorDao authorDao) {
        this.articleDao = articleDao;
        this.topicDao = topicDao;
        this.authorDao = authorDao;
    }

    @Override
    public Article loadArticle(String id) {
        return articleDao.getArticle(id);
    }

    @Override
    public Author loadAuthor(String id) {
        return authorDao.getAuthor(id);
    }

    @Override
    public Topic loadTopic(String id) {
        return topicDao.getTopic(id);
    }
}
