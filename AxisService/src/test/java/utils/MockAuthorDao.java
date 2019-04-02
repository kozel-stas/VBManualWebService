package utils;

import core.dao.AuthorDao;
import core.model.Author;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class MockAuthorDao extends AuthorDao {

    private long id = 0;
    private List<Author> authors = new ArrayList<>();

    public MockAuthorDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addAuthor(Author author) {
        return authors.add(new Author(++id + "", author.getFirstName(), author.getLastName(), author.getSpeciality())) ? 1 : 0;
    }

    public Author getAuthor(String authorID) {
        List<Author> res = authors.stream().filter(val -> val.getId().equals(authorID)).collect(Collectors.toList());
        if (!res.isEmpty()) {
            return res.get(0);
        }
        return null;
    }

    public List<Author> getAuthors() {
        return authors;
    }

}
