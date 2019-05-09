package core.model;

import java.util.Objects;

public class Article {

    private String id;
    private String name;
    private String content;
    private String authorId;
    private String topicId;

    public Article(String id, String name, String content, String authorId, String topicId) {
        this.id = id;
        this.name = name;
        this.content = content;
        this.authorId = authorId;
        this.topicId = topicId;
    }

    public Article() {

    }

    public void setId(String id) {
        this.id = id;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId;
    }

    public void setName(String name) {
        this.name = name;
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
