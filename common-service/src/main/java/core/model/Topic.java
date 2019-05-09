package core.model;

import java.util.Objects;

public class Topic {

    private String id;
    private String name;
    private String authorId;

    public Topic(String id, String name, String authorId) {
        this.id = id;
        this.name = name;
        this.authorId = authorId;
    }

    public Topic(){

    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }

    public void setId(String topicId) {
        this.id = topicId;
    }

    public String getAuthorId() {
        return authorId;
    }

    public String getName() {
        return name;
    }

    public String getId() {
        return id;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Topic) {
            Topic that = (Topic) obj;
            return Objects.equals(id, that.id);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Topic={ID=" + id +
                ", name=" + name +
                ", author=" + authorId +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
