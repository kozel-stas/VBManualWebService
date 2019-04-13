package core.dao;

import core.model.Author;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AuthorDao extends JdbcTemplate {

    private static final String INSERT_AUTHOR = "INSERT INTO VBDataSource.authors (firstName, lastName, speciality) VALUES (?, ?, ?)";

    private static final String SELECT_AUTHOR = "SELECT ID, firstName, lastName, speciality FROM VBDataSource.authors where ID = ?";

    private static final String SELECT_AUTHORS = "SELECT ID, firstName, lastName, speciality FROM VBDataSource.authors LIMIT ?,?";

    private static final String SELECT_COUNT_AUTHORS = "SELECT count(*) FROM VBDataSource.authors";

    public AuthorDao(DataSource dataSource) {
        super(dataSource, 10, 10_000);
    }

    private static Author extractData(ResultSet resultSet) throws SQLException {
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
    }

    public int addAuthor(Author author) {
        try {
            return update(INSERT_AUTHOR, ps -> {
                ps.setString(1, author.getFirstName());
                ps.setString(2, author.getLastName());
                ps.setString(3, author.getSpeciality());
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
            }, AuthorDao::extractData);
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return null;
        }
    }

    public int getAuthorTotalNumber() {
        try {
            return query(SELECT_COUNT_AUTHORS, ps -> {
            }, rs -> {
                if (rs.next()) {
                    return rs.getInt(1);
                }
                return 0;
            });
        } catch (SQLException | InterruptedException ex) {
            //LOG
            return 0;
        }
    }

    public List<Author> getAuthors(int offset, int limit) {
        List<Author> authors = new ArrayList<>();
        try {
            query(SELECT_AUTHORS, ps -> {
                ps.setInt(1, offset);
                ps.setInt(2, limit);
            }, rs -> {
                Author author = extractData(rs);
                while (author != null) {
                    authors.add(author);
                    author = extractData(rs);
                }
                return null;
            });
        } catch (SQLException | InterruptedException ignored) {
        }
        return authors;
    }

}
