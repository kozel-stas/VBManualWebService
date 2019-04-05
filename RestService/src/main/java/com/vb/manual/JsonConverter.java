package com.vb.manual;

import com.google.common.base.Preconditions;
import core.model.Article;
import core.model.Author;
import core.model.Topic;
import core.services.DataLoader;
import org.json.JSONObject;

public class JsonConverter {

    private final DataLoader dataLoader;

    public JsonConverter(DataLoader dataLoader) {
        this.dataLoader = dataLoader;
    }

    public JSONObject convertFrom(Author author) {
        return new JSONObject().put("id", author.getId()).put("firstName", author.getFirstName()).put("lastName", author.getLastName()).put("speciality", author.getSpeciality());
    }

    public Author convertToAuthor(String in) {
        JSONObject author = new JSONObject(in);
        return new Author(author.optString("id"), author.getString("firstName"), author.getString("lastName"), author.getString("speciality"));
    }

    public JSONObject convertFrom(Topic topic) {
        return new JSONObject().put("id", topic.getId()).put("name", topic.getName()).put("author", convertFrom(dataLoader.loadAuthor(topic.getAuthorId())));
    }

    public Topic convertToTopic(String in) {
        JSONObject topic = new JSONObject(in);
        return new Topic(topic.optString("id"), topic.getString("name"), topic.getJSONObject("author").getString("id"));
    }

    public JSONObject convertFrom(Article article) {
        return new JSONObject().put("id", article.getId()).put("name", article.getName()).put("author", convertFrom(dataLoader.loadAuthor(article.getAuthorId()))).put("content", article.getContent());
    }

    public Article convertToArticle(String in, String topicID) {
        JSONObject article = new JSONObject(in);
        return new Article(article.optString("id"), article.getString("name"), article.getString("content"), article.getJSONObject("author").getString("id"), topicID);
    }

    public void validateTopicId(String topicId) {
        Preconditions.checkNotNull(dataLoader.loadTopic(topicId), "Don't have topics with this ID.");
    }

    public void validateArticleId(String article) {
        Preconditions.checkNotNull(dataLoader.loadArticle(article), "Don't have articles with this ID.");
    }

    public void validateAuthorId(String authorID) {
        Preconditions.checkNotNull(dataLoader.loadAuthor(authorID), "Don't have authors with this ID.");
    }

}
