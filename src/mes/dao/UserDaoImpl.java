package mes.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import mes.frame.database.JDBCConnectionPool;
import mes.model.User;

public class UserDaoImpl implements UserDao {
	public UserDaoImpl() {
	}

	@Override
	public User getUserById(Connection conn, String userId) {

		try {
			Statement stmt = conn.createStatement();
			
			String sql = new StringBuilder()
				.append("SELECT * 							\n")
				.append("FROM user							\n")
				.append("WHERE user_id = '" + userId + "'	\n")
				.append("  AND tenant_id = '" + JDBCConnectionPool.getTenantId(conn) + "'	\n")
				.toString();
			
			ResultSet rs = stmt.executeQuery(sql);
			User user = new User();
			
			if(rs.next()) {
				user = extractFromResultSet(rs);
			}
			
			return user;
			
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		
		return null;
	};
	
	private User extractFromResultSet(ResultSet rs) throws SQLException {
		User user = new User();
		
		user.setUserId(rs.getString("user_id"));
		user.setUserName(rs.getString("user_name"));
		user.setPassword(rs.getString("password"));
		user.setAuthority(rs.getString("authority"));

	    return user;
	}
}
