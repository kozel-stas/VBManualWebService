package utils;

import core.dao.TopicDao;
import core.model.Topic;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class MockTopicDao extends TopicDao {

    private long id = 0;
    private List<Topic> topics = new ArrayList<>();

    public MockTopicDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addTopic(Topic topic) {
        return topics.add(new Topic(++id + "", topic.getName(), topic.getAuthorId())) ? 1 : 0;
    }

    @Override
    public int getTopicTotalNumber() {
        return topics.size();
    }

    @Override
    public Set<Topic> getTopics(int offset, int number) {
        int startIndex = offset;
        if (offset <= 0) {
            startIndex = 0;
        }
        int endIndex = startIndex + number;
        if (startIndex + number >= topics.size()) {
            endIndex = topics.size();
        }
        return new HashSet<>(topics.subList(startIndex, endIndex));
    }

    public Topic getTopic(String topicId) {
        List<Topic> res = topics.stream().filter(val -> val.getId().equals(topicId)).collect(Collectors.toList());
        if (!res.isEmpty()) {
            return res.get(0);
        }
        return null;
    }

    public int deleteTopic(String topicId, String authorID) {
        Topic topic = getTopic(topicId);
        if (topic != null && topic.getAuthorId().equals(authorID)) {
            topics.remove(topic);
            return 1;
        }
        return 0;
    }

}
