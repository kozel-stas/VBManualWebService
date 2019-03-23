package services;

import model.Author;
import org.apache.thrift.TException;

public interface DataProvider {

    Author getAuthor(String id) throws TException;

    Author registerAuthor(Author author) throws TException;

}
