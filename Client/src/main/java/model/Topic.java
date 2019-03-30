package model;

import java.util.Objects;

public class Topic {

    public static final Topic STUB = new Topic("wdwd", "", Author.STUB);

    private final String topicId;
    private final String name;
    private final Author author;

    public Topic(String topicId, String name, Author author) {
        this.topicId = topicId;
        this.name = name;
        this.author = author;
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
