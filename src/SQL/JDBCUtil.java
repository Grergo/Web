package SQL;

import java.io.InputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Driver;

public class JDBCUtil {
	private static String driverString;
	private static String urlString;
	private static String usernameString;
	private static String passwdString;
	public JDBCUtil() {
		Properties props = new Properties();
		try {
			InputStream inputStream =JDBCUtil.class.getClassLoader().getResourceAsStream("db.properties");
			props.load(inputStream);
			driverString=props.getProperty("driver");
			urlString=props.getProperty("url");
			usernameString=props.getProperty("user_name");
			passwdString=props.getProperty("password");
			Class.forName(driverString);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static java.sql.Connection getConnection() {
		try {
			return DriverManager.getConnection(urlString,usernameString,passwdString);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public static void close(java.sql.Connection connection,Statement statement,ResultSet resultSet) {
		if(resultSet != null) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(connection!=null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(statement!=null) {
			try {
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void close(java.sql.Connection connection) {
		if (connection!=null) {
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
	}
	public static void close(Statement statement) {
		if (statement!=null) {
			try {
				statement.close();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
	}
	public static void close(ResultSet resultSet) {
		if (resultSet!=null) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
	}
	public static String md5(String plainText) {
		byte[] secretBytes = null;
		try {
			//先通过MessageDigest把目标内容转换为字节数组
			secretBytes = MessageDigest.getInstance("md5").digest(
					plainText.getBytes());
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("找不到md5算法");
		}
		//把字节数组变为字符串
		String md5code = new BigInteger(1, secretBytes).toString(16);
		for (int i = 0; i < 32 - md5code.length(); i++) {
			md5code = "0" + md5code;
		}
		return md5code;
	}
	
}
