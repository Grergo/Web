package SQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class memberUtils {
	protected String sql_person_Select="SELECT  loginid, custname, gender, tel, integral, email FROM Web_Customer where email=?";
	protected String sql_Person_update="UPDATE Web_Customer SET gender=?,tel=?,custname=? WHERE loginid=?;";
	protected String sql_orderinfo_select="SELECT orderno, ordertime, customer, consignee, orderprice, orderaddress, zipcode, phone, status FROM Web_Orderinfo where customerid=?;";
	protected String sql_address_select="select address from Web_Customer where email=?;";
	protected String sql_address_update="UPDATE Web_Customer SET  address=? WHERE loginid=?;";
	protected String sql_password_update="UPDATE Web_Customer SET password=? WHERE loginid=?;";
	protected String sql_message_select="SELECT ID, message FROM Web_Notic;";
	public memberUtils() {
		
	}
	public Map<String, String> Select_Person_info(String loginid) {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=JDBCUtil.getConnection();
		ResultSet resultSet=null;
		Map<String, String> personinfo= new HashMap<String, String>();
		try {
			PreparedStatement preparedStatement=connection.prepareStatement(sql_person_Select);
			preparedStatement.setString(1, loginid);
			resultSet=preparedStatement.executeQuery();
			resultSet.next();
			personinfo.put("loginid", resultSet.getString("loginid"));
			personinfo.put("custname", resultSet.getString("custname"));
			personinfo.put("gender", resultSet.getString("gender"));
			personinfo.put("tel", resultSet.getString("tel"));
			personinfo.put("integral", resultSet.getString("integral"));
			personinfo.put("email", resultSet.getString("email"));
			JDBCUtil.close(connection, preparedStatement, resultSet);
		} catch (SQLException e) {
			
			System.out.println(e.getLocalizedMessage());
		}
		return personinfo;
	}
	public void update_person_info(String gender,String tel,String custname,String loginid) {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=JDBCUtil.getConnection();
		PreparedStatement preparedStatement=null;
		try {
			preparedStatement=connection.prepareStatement(sql_Person_update);
			preparedStatement.setString(1, gender);
			preparedStatement.setString(2, tel);
			preparedStatement.setString(3, custname);
			preparedStatement.setString(4, loginid);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			
			System.out.println(e.getLocalizedMessage());
		}
		JDBCUtil.close(connection, preparedStatement, null);
	}
	public void update_address(String address,String loginid) {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=JDBCUtil.getConnection();
		PreparedStatement preparedStatement=null;
		try {
			preparedStatement=connection.prepareStatement(sql_address_update);
			preparedStatement.setString(1, address);
			preparedStatement.setString(2, loginid);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			
			System.out.println(e.getLocalizedMessage());
		}
		JDBCUtil.close(connection, preparedStatement, null);
	}
	public ArrayList<Map<String, String>> Select_order_info(String loginid) {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=JDBCUtil.getConnection();
		ArrayList<Map<String, String>> order_list= new ArrayList<Map<String,String>>();
		PreparedStatement preparedStatement=null;
		try {
			preparedStatement=connection.prepareStatement(sql_orderinfo_select);
			preparedStatement.setString(1, loginid);
			ResultSet resultSet=preparedStatement.executeQuery();
			while(resultSet.next()) {
				Map<String, String> map_teMap= new HashMap<String, String>();
				map_teMap.put("order_num", resultSet.getString("orderno"));
				map_teMap.put("order_time", resultSet.getTimestamp("ordertime").toLocaleString());
				map_teMap.put("customer", resultSet.getString("customer"));
				map_teMap.put("consignee", resultSet.getString("consignee"));
				map_teMap.put("order_price", resultSet.getString("orderprice"));
				map_teMap.put("order_address", resultSet.getString("orderaddress"));
				map_teMap.put("zipcode", resultSet.getString("zipcode"));
				map_teMap.put("phone", resultSet.getString("phone"));
				map_teMap.put("status", resultSet.getString("status"));
				order_list.add(map_teMap);
			}
			JDBCUtil.close(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
		return order_list;
	}
	public ArrayList<Map<String, String>> Select_notice() {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection= JDBCUtil.getConnection();
		ArrayList<Map<String, String>> message_list= new ArrayList<Map<String,String>>();
		PreparedStatement preparedStatement=null;
		try {
			preparedStatement=connection.prepareStatement(sql_message_select);
			ResultSet resultSet=preparedStatement.executeQuery();
			while(resultSet.next()) {
				Map<String, String> message= new HashMap<String, String>();
				message.put("num", Integer.toString(resultSet.getInt("ID")));
				message.put("message",resultSet.getString("message"));
				message_list.add(message);
			}
			JDBCUtil.close(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
		return message_list;
	}
public  Map<String, String> Select_address(String loginid) {
	JDBCUtil jdbcUtil=new JDBCUtil();
	Connection connection=JDBCUtil.getConnection();
	ResultSet resultSet=null;
	Map<String, String> address= new HashMap<String, String>();
	try {
		PreparedStatement preparedStatement=connection.prepareStatement(sql_address_select);
		preparedStatement.setString(1, loginid);
		resultSet=preparedStatement.executeQuery();
		resultSet.next();
		address.put("address", resultSet.getString("address"));
		JDBCUtil.close(connection, preparedStatement, resultSet);
	} catch (Exception e) {
		System.out.println(e.getLocalizedMessage());
	}
	return address;
}
public void update_password(String password,String loginid) {
	JDBCUtil jdbcUtil=new JDBCUtil();
	Connection connection=JDBCUtil.getConnection();
	PreparedStatement preparedStatement=null;
	try {
		preparedStatement=connection.prepareStatement(sql_password_update);
		preparedStatement.setString(1, JDBCUtil.md5(password));
		preparedStatement.executeUpdate();
	} catch (Exception e) {
		System.out.println(e.getLocalizedMessage());
	}
	JDBCUtil.close(connection, preparedStatement, null);
}
}
