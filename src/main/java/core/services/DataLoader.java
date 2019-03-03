package core.services;

import com.google.common.cache.CacheLoader;
import core.model.Article;
import core.model.Author;
import core.model.Topic;

import java.util.concurrent.ExecutionException;

public interface DataLoader {

    Article loadArticle(String id) throws ExecutionException;

    Author loadAuthor(String id) throws ExecutionException;

    Topic loadTopic(String id) throws ExecutionException;

}
