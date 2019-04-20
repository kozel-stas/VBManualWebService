package soap.model;

import java.util.Objects;

public class Article {

    private String id;
    private String name;
    private String content;
    private Author author;

    public Article(String id, String name, String content, Author author) {
        this.id = id;
        this.name = name;
        this.content = content;
        this.author = author;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Author getAuthor() {
        return author;
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
                ", author=" + author +
                "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
