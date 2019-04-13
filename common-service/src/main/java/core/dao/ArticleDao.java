package core.dao;

import core.model.Article;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class ArticleDao extends JdbcTemplate {

    private static final String INSERT_ARTICLE = "INSERT INTO VBDataSource.articles (articleName, content, author, topic) VALUES (?, ?, ?, ?)";

    private static final String SELECT_ARTICLES = "SELECT ID, articleName, content, author, topic FROM VBDataSource.articles where topic = ? LIMIT ?,?";

    private static final String SELECT_COUNT_ARTICLES = "SELECT count(*) FROM VBDataSource.articles where topic = ?";

    private static final String SELECT_ARTICLE = "SELECT ID, articleName, content, author, topic FROM VBDataSource.articles where ID = ?";

    private static final String UPDATE_ARTICLE = "UPDATE VBDataSource.articles SET articleName=?, content=?, author=? WHERE ID=? AND topic = ?";

    private static final String DELETE_ARTICLE = "DELETE FROM VBDataSource.articles WHERE ID = ? AND topic = ?";

    private static final String DELETE_ARTICLES = "DELETE FROM VBDataSource.articles WHERE topic = ?";

    public ArticleDao(DataSource dataSource) {
        super(dataSource, 10, 10_000);
    }

    public int addArticle(Article article) {
        try {
            return update(INSERT_ARTICLE, ps -> {
                ps.setString(1, article.getName());
                ps.setString(2, article.getContent());
                ps.setString(3, article.getAuthorId());
                ps.setString(4, article.getTopicId());
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public Set<Article> getArticles(String topicId, int offset, int limit) {
        try {
            return query(SELECT_ARTICLES, ps -> {
                ps.setString(1, topicId);
                ps.setInt(2, offset);
                ps.setInt(3, limit);
            }, new ArticleExtractor());
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

    public Article getArticle(String articleId) {
        try {
            return query(SELECT_ARTICLE, preparedStatement -> {
                preparedStatement.setString(1, articleId);
            }, resultSet -> {
                if (resultSet.next()) {
                    return extractArticle(resultSet);
                }
                return null;
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

    public int getArticleTotalNumber(String topicId) {
        try {
            return query(SELECT_COUNT_ARTICLES, preparedStatement -> {
                preparedStatement.setString(1, topicId);
            }, resultSet -> {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
                return 0;
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public int updateArticle(Article article) {
        try {
            return update(UPDATE_ARTICLE, ps -> {
                ps.setString(1, article.getName());
                ps.setString(2, article.getContent());
                ps.setString(3, article.getAuthorId());
                ps.setString(4, article.getId());
                ps.setString(5, article.getTopicId());
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public int deleteArticle(String articleId, String topicId) {
        try {
            return update(DELETE_ARTICLE, ps -> {
                ps.setString(1, articleId);
                ps.setString(2, topicId);
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public int deleteArticles(String topicId) {
        try {
            return update(DELETE_ARTICLES, ps -> {
                ps.setString(1, topicId);
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    private final class ArticleExtractor implements ResultSetExtractor<Set<Article>> {

        @Override
        public Set<Article> extractData(ResultSet resultSet) throws SQLException {
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
