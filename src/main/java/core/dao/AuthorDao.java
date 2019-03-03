package core.dao;

import core.model.Author;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;

public class AuthorDao extends JdbcTemplate {

    private static final String INSERT_AUTHOR = "INSERT (ID, firstName, lastName, speciality) INTO VBDataSource.authors VALUES (?, ?, ?, ?";

    private static final String SELECT_AUTHOR = "SELECT ID, firstName, lastName, speciality FROM VBDataSource.authors where ID = ?";

    public AuthorDao(DataSource dataSource) {
        super(dataSource);
    }

    public int addAuthor(Author author) {
        return update(INSERT_AUTHOR, author.getId(), author.getFirstName(), author.getLastName(), author.getSpeciality());
    }

    public Author getAuthor(String authorID) {
        return query(SELECT_AUTHOR, resultSet -> {
            if (resultSet.next()) {
                return new Author(
                        resultSet.getString("ID"),
                        resultSet.getString("firstName"),
                        resultSet.getString("lastName"),
                        resultSet.getString("speciality")
                );
            } else {
                return null;
            }
        });
    }

}
