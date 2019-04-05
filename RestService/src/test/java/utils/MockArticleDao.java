package utils;

import core.dao.ArticleDao;
import core.model.Article;

import javax.annotation.concurrent.NotThreadSafe;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@NotThreadSafe
public class MockArticleDao extends ArticleDao {

    private long id = 0;
    private List<Article> articles = new ArrayList<>();

    public MockArticleDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addArticle(Article article) {
        return articles.add(new Article(++id + "", article.getName(), article.getContent(), article.getAuthorId(), article.getTopicId())) ? 1 : 0;
    }

    public Set<Article> getArticles(String topicId) {
        return articles.stream().filter(val -> val.getTopicId().equals(topicId)).collect(Collectors.toSet());
    }

    public Article getArticle(String articleId) {
        List<Article> res = articles.stream().filter(val -> val.getId().equals(articleId)).collect(Collectors.toList());
        if (!res.isEmpty()) {
            return res.get(0);
        }
        return null;
    }

    public int updateArticle(Article article) {
        Article article1 = getArticle(article.getId());
        if (article1 != null) {
            articles.remove(article1);
            articles.add(article);
            return 1;
        }
        return 0;
    }

    public int deleteArticle(String articleId, String topicId) {
        List<Article> res = articles.stream().filter(val -> val.getId().equals(articleId)).filter(val -> val.getTopicId().equals(topicId)).collect(Collectors.toList());
        if (!res.isEmpty()) {
            articles.remove(res.get(0));
            return 1;
        }
        return 0;
    }

    public int deleteArticles(String topicId) {
        List<Article> res = articles.stream().filter(val -> val.getTopicId().equals(topicId)).collect(Collectors.toList());
        articles.removeAll(res);
        return res.size();
    }


}
