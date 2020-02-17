package Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import SQL.JDBCUtil;
import SQL.memberUtils;

public class SQL_test {

	public static void main(String[] args) throws Exception {
		memberUtils memberUtils=new memberUtils();
		System.out.println(memberUtils.Select_Person_info("weikangwang730@gmail.com").get("email"));
		

	}

}
