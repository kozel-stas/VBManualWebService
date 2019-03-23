package core.dao;

import core.model.Author;

import javax.sql.DataSource;
import java.sql.SQLException;

public class AuthorDao extends JdbcTemplate {

    private static final String INSERT_AUTHOR = "INSERT (ID, firstName, lastName, speciality) INTO VBDataSource.authors VALUES (?, ?, ?, ?";

    private static final String SELECT_AUTHOR = "SELECT ID, firstName, lastName, speciality FROM VBDataSource.authors where ID = ?";

    public AuthorDao(DataSource dataSource) {
        super(dataSource, 10, 10_000);
    }

    public int addAuthor(Author author) {
        try {
            return update(INSERT_AUTHOR, ps -> {
                ps.setString(1, author.getId());
                ps.setString(2, author.getFirstName());
                ps.setString(3, author.getLastName());
                ps.setString(4, author.getSpeciality());
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public Author getAuthor(String authorID) {
        try {
            return query(SELECT_AUTHOR, ps -> {
                ps.setString(1, authorID);
            }, resultSet -> {
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
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

}
