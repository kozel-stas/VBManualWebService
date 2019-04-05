package services;

import model.Article;
import model.Author;
import model.Topic;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class RESTRequestResponseConverter {

    public Author convertToAuthor(JSONObject author) {
        return new Author(author.getString("id"), author.getString("firstName"), author.getString("lastName"), author.getString("speciality"));
    }

    public JSONObject convertFrom(Author author) {
        return new JSONObject().put("id", author.getId()).put("firstName", author.getFirstName()).put("lastName", author.getLastName()).put("speciality", author.getSpeciality());
    }

    public List<Author> getAuthors(String in) {
        JSONObject jsonObject = new JSONObject(in);
        List<Author> res = new ArrayList<>();
        JSONArray authors = jsonObject.getJSONArray("authors");
        for (int i = 0; i < authors.length(); i++) {
            res.add(convertToAuthor(authors.getJSONObject(i)));
        }
        return res;
    }

    public Topic convertToTopic(JSONObject topic) {
        return new Topic(topic.getString("id"), topic.getString("name"), convertToAuthor(topic.getJSONObject("author")));
    }

    public JSONObject convertFrom(Topic topic) {
        return new JSONObject().put("id", topic.getId()).put("name", topic.getName()).put("author", convertFrom(topic.getAuthor()));
    }

    public List<Topic> getTopics(String in) {
        JSONObject jsonObject = new JSONObject(in);
        List<Topic> res = new ArrayList<>();
        JSONArray authors = jsonObject.getJSONArray("topics");
        for (int i = 0; i < authors.length(); i++) {
            res.add(convertToTopic(authors.getJSONObject(i)));
        }
        return res;
    }

    public Article convertToArticle(JSONObject article) {
        return new Article(article.getString("id"), article.getString("name"), article.getString("content"), convertToAuthor(article.getJSONObject("author")));
    }

    public JSONObject convertFrom(Article article) {
        return new JSONObject().put("id", article.getId()).put("name", article.getName()).put("content", article.getContent()).put("author", convertFrom(article.getAuthor()));
    }

    public List<Article> getArticles(String in) {
        JSONObject jsonObject = new JSONObject(in);
        List<Article> res = new ArrayList<>();
        JSONArray articles = jsonObject.getJSONArray("articles");
        for (int i = 0; i < articles.length(); i++) {
            res.add(convertToArticle(articles.getJSONObject(i)));
        }
        return res;
    }

}
