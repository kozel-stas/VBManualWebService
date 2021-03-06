package model;

import java.util.Objects;

public class Article {

    private final String id;
    private final String name;
    private final String content;
    private final Author author;

    public Article(String id, String name, String content, Author author) {
        this.id = id;
        this.name = name;
        this.content = content;
        this.author = author;
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
