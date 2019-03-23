package core.model;

import java.util.Objects;

public class Topic {

    private final String topicId;
    private final String name;
    private final String authorId;

    public Topic(String topicId, String name, String authorId) {
        this.topicId = topicId;
        this.name = name;
        this.authorId = authorId;
    }

    public String getAuthorId() {
        return authorId;
    }

    public String getName() {
        return name;
    }

    public String getId() {
        return topicId;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Topic) {
            Topic that = (Topic) obj;
            return Objects.equals(topicId, that.topicId);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Topic={ID=" + topicId +
                ", name=" + name +
                ", author=" + authorId +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
