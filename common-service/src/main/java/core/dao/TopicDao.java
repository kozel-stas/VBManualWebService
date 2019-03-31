package core.dao;

import core.model.Topic;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class TopicDao extends JdbcTemplate {

    private static final String INSERT_TOPIC = "INSERT INTO VBDataSource.topics (topicName, author) VALUES (?, ?)";

    private static final String SELECT_TOPICS = "SELECT ID, topicName, author FROM VBDataSource.topics";

    private static final String SELECT_TOPIC = "SELECT ID, topicName, author FROM VBDataSource.topics WHERE ID = ?";

    private static final String DELETE_TOPIC = "DELETE FROM VBDataSource.topics WHERE ID = ? AND author=?";

    public TopicDao(DataSource dataSource) {
        super(dataSource, 10, 10_000);
    }

    public int addTopic(Topic topic) {
        try {
            return update(INSERT_TOPIC, ps -> {
                ps.setString(1, topic.getName());
                ps.setString(2, topic.getAuthorId());
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public Set<Topic> getTopics() {
        try {
            return query(SELECT_TOPICS, new TopicsExtractor());
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

    public Topic getTopic(String topicId) {
        try {
            return query(SELECT_TOPIC, preparedStatement -> {
                preparedStatement.setString(1, topicId);
            }, resultSet -> {
                if (resultSet.next()) {
                    return extractTopic(resultSet);
                }
                return null;
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

    public int deleteTopic(String topicId, String authorID) {
        try {
            return update(DELETE_TOPIC, (ps) -> {
                ps.setString(1, topicId);
                ps.setString(2, authorID);
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    private final class TopicsExtractor implements ResultSetExtractor<Set<Topic>> {

        @Override
        public Set<Topic> extractData(ResultSet resultSet) throws SQLException {
            Set<Topic> result = new HashSet<>();
            while (resultSet.next()) {
                result.add(extractTopic(resultSet));
            }
            return result;
        }

    }

    private static Topic extractTopic(ResultSet resultSet) throws SQLException {
        return new Topic(
                resultSet.getString("ID"),
                resultSet.getString("topicName"),
                resultSet.getString("author")
        );
    }

}
