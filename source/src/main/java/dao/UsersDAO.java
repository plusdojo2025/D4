package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Users;

public class UsersDAO {
	/*引数のユーザー情報でログイン、成功ならtrueを返す*/
	public boolean isLoginOk(Users users) {
		Connection conn = null;
		boolean loginResult = false;
		
		try {
			/*JDBCドライバの読み込み*/
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			/*データベースに接続*/
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/d4?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");
			
			/*SELECT文を準備*/
			String sql = "SELECT count(*) FROM Usere WHERE id=? AND pw=? AND height=? AND name=? AND theme=? "
					+ "AND icon=? AND vPrivate=? AND sPrivate=? AND wPrivate";
			
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, users.getId());
			pStmt.setString(2, users.getPw());
			pStmt.setInt(3, users.getHeight());
			pStmt.setString(4, users.getName());
			pStmt.setInt(5, users.getTheme());
			pStmt.setInt(6, users.getIcon());
			pStmt.setInt(7, users.getvPrivate());
			pStmt.setInt(8, users.getsPrivate());
			pStmt.setInt(9, users.getwPrivate());
			
			// SELECT文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();
			
			/*ユーザーIDとパスワードが一致するユーザーがいれば結果をtrueにする*/
			rs.next();
			if(rs.getInt("count(*)") ==1 ) {
				loginResult = true;
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
			loginResult = false;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			loginResult = false;
		}finally {
			/*データベース切断*/
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					loginResult = false;
				}
			}
		}
		/*結果を返す*/
		return loginResult;
	}

}
