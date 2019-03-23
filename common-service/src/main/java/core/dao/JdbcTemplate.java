package core.dao;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class JdbcTemplate {

    private final Semaphore semaphore;
    private final DataSource dataSource;
    private final int requestTimedOut;

    public JdbcTemplate(DataSource dataSource, int numberOfParallelsRequests, int requestTimedOut) {
        this.dataSource = dataSource;
        semaphore = new Semaphore(numberOfParallelsRequests);
        this.requestTimedOut = requestTimedOut;
    }

    public <T> T query(String sql, PreparedStatementSetter pss, ResultSetExtractor<T> rse) throws SQLException, InterruptedException {
        return execute(sql, new PreparedStatementCallback<T>() {
            @Override
            public T doInPreparedStatement(PreparedStatement ps) throws SQLException {
                pss.setValues(ps);

                ResultSet resultSet = ps.executeQuery();

                T object = rse.extractData(resultSet);

                resultSet.close();

                return object;
            }
        });
    }

    public <T> T query(String sql, ResultSetExtractor<T> rse) throws SQLException, InterruptedException {
        return execute(sql, new PreparedStatementCallback<T>() {
            @Override
            public T doInPreparedStatement(PreparedStatement ps) throws SQLException {
                ResultSet resultSet = ps.executeQuery();

                T object = rse.extractData(resultSet);

                resultSet.close();

                return object;
            }
        });
    }

    public int update(String sql, PreparedStatementSetter pss) throws SQLException, InterruptedException {
        return execute(sql, new PreparedStatementCallback<Integer>() {
            @Override
            public Integer doInPreparedStatement(PreparedStatement ps) throws SQLException {
                pss.setValues(ps);
                return ps.executeUpdate();
            }
        });
    }

    private <T> T execute(String sql, PreparedStatementCallback<T> callback) throws InterruptedException, SQLException {
        boolean isAcquired = semaphore.tryAcquire(requestTimedOut, TimeUnit.MILLISECONDS);
        if (isAcquired) {
            try (Connection connection = dataSource.getConnection();) {
                return callback.doInPreparedStatement(connection.prepareStatement(sql));
            } catch (SQLException e) {
                throw e;
            } finally {
                semaphore.release();
            }
        } else {
            throw new SQLException("Request timed out");
        }
    }

    public interface PreparedStatementSetter {
        void setValues(PreparedStatement var1) throws SQLException;
    }

    public interface ResultSetExtractor<T> {
        T extractData(ResultSet var1) throws SQLException;
    }

    public interface PreparedStatementCallback<T> {
        T doInPreparedStatement(PreparedStatement var1) throws SQLException;
    }

}
