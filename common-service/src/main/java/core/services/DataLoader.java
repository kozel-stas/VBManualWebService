package core.services;

import core.model.Article;
import core.model.Author;
import core.model.Topic;

import java.util.concurrent.ExecutionException;

public interface DataLoader {

    Article loadArticle(String id);

    Author loadAuthor(String id);

    Topic loadTopic(String id);

}
