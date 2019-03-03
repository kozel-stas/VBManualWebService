package core.model;

import javax.annotation.concurrent.Immutable;
import java.util.Objects;

@Immutable
public class Article {

    private final String id;
    private final String name;
    private final String content;
    private final String authorId;
    private final String topicId;

    public Article(String id, String name, String content, String authorId, String topicId) {
        this.id = id;
        this.name = name;
        this.content = content;
        this.authorId = authorId;
        this.topicId = topicId;
    }

    public String getAuthorId() {
        return authorId;
    }

    public String getContent() {
        return content;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getTopicId() {
        return topicId;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Article) {
            Article that = (Article) obj;
            return Objects.equals(id, that.id);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Article={id=" + id +
                ", name=" + name +
                ", author=" + authorId +
                ", topicId=" + topicId +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
