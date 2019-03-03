package core.dao;

import core.model.Author;
import core.model.Topic;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class TopicDao extends JdbcTemplate {

    private static final String INSERT_TOPIC = "INSERT (ID, topicName, author) INTO VBDataSource.topics VALUES (?, ?, ?)";

    private static final String SELECT_TOPICS = "SELECT ID, topicName, author FROM VBDataSource.topics";

    private static final String SELECT_TOPIC = "SELECT ID, topicName, author FROM VBDataSource.topics WHERE ID = ?";

    private static final String DELETE_TOPIC = "DELETE FROM VBDataSource.topics WHERE ID = ? AND author=?";

    public TopicDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addTopic(Topic topic) {
        return update(INSERT_TOPIC, topic.getId(), topic.getName(), topic.getAuthorId());
    }

    public Set<Topic> getTopics() {
        return query(SELECT_TOPICS, new TopicsExtractor());
    }

    public Topic getTopic(String topicId) {
        return query(SELECT_TOPIC, preparedStatement -> {
            preparedStatement.setString(1, topicId);
        }, resultSet -> {
            if (resultSet.next()) {
                return extractTopic(resultSet);
            }
            return null;
        });
    }

    public int deleteTopic(String topicId, String authorID) {
        return update(DELETE_TOPIC, topicId, authorID);
    }

    private final class TopicsExtractor implements ResultSetExtractor<Set<Topic>> {

        @Override
        public Set<Topic> extractData(ResultSet resultSet) throws SQLException, DataAccessException {
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
