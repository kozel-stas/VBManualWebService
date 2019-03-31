package soap.model;

import java.util.Objects;

public class Topic {

    private String topicId;
    private String name;
    private Author author;

    public Topic() {

    }

    public Topic(String topicId, String name, Author author) {
        this.topicId = topicId;
        this.name = name;
        this.author = author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(String topicId) {
        this.topicId = topicId;
    }

    public Author getAuthor() {
        return author;
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
                ", author=" + author +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }

}
