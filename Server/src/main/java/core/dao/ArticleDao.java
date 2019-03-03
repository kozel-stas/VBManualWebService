package core.dao;

import core.model.Article;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class ArticleDao extends JdbcTemplate {

    private static final String INSERT_ARTICLE = "INSERT (ID, articleName, content, author, topic) INTO VBDataSource.articles VALUES (?, ?, ?, ?, ?)";

    private static final String SELECT_ARTICLES = "SELECT ID, articleName, content, author, topic FROM VBDataSource.articles where topic = ?";

    private static final String SELECT_ARTICLE = "SELECT ID, articleName, content, author, topic FROM VBDataSource.articles where ID = ?";

    private static final String UPDATE_ARTICLE = "UPDATE VBDataSource.articles SET articleName=?, content=?, topic=? WHERE ID=? AND topic = ?";

    private static final String DELETE_ARTICLE = "DELETE FROM VBDataSource.articles WHERE ID = ? AND topic = ?";

    private static final String DELETE_ARTICLES = "DELETE FROM VBDataSource.articles WHERE topic = ?";

    public ArticleDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addArticle(Article article) {
        return update(INSERT_ARTICLE, article.getId(), article.getName(), article.getContent(), article.getAuthorId(), article.getTopicId());
    }

    public Set<Article> getArticles(String topicId) {
        return query(SELECT_ARTICLES, new ArticleExtractor());
    }

    public Article getArticle(String articleId) {
        return query(SELECT_ARTICLE, preparedStatement -> {
            preparedStatement.setString(1, articleId);
        }, resultSet -> {
            if (resultSet.next()) {
                return extractArticle(resultSet);
            }
            return null;
        });
    }

    public int updateArticle(Article article) {
        return update(UPDATE_ARTICLE, article.getName(), article.getContent(), article.getAuthorId(), article.getTopicId(), article.getId());
    }

    public int deleteArticle(String articleId, String topicId) {
        return update(DELETE_ARTICLE, articleId, topicId);
    }

    public int deleteArticles(String topicId) {
        return update(DELETE_ARTICLES, topicId);
    }

    private final class ArticleExtractor implements ResultSetExtractor<Set<Article>> {

        @Override
        public Set<Article> extractData(ResultSet resultSet) throws SQLException, DataAccessException {
            Set<Article> result = new HashSet<>();
            while (resultSet.next()) {
                result.add(extractArticle(resultSet));
            }
            return result;
        }

    }

    private static Article extractArticle(ResultSet resultSet) throws SQLException {
        return new Article(
                resultSet.getString("ID"),
                resultSet.getString("articleName"),
                resultSet.getString("content"),
                resultSet.getString("author"),
                resultSet.getString("topic")
        );
    }

}
