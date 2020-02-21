package SQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ShowUtils {
	public ArrayList<Map<String, String>> Select_news(String type) {
		ArrayList<Map<String, String>> tem_ArrayList= new ArrayList<Map<String,String>>();
		tem_ArrayList=Select_assigned_product(type, null);
		if(tem_ArrayList.size()>4) {
		return (ArrayList<Map<String, String>>) tem_ArrayList.subList(0, 4);
		}else {
			return tem_ArrayList;
		}
	}
	public ArrayList<Map<String, String>> Select_assigned_product(String type,String isspecial) {
		String sql_special="select prodid,prodname,prodprice from Web_Product where prodtype=? and isspecial=?;";
		String sql="select prodid,prodname,prodprice from Web_Product where prodtype=?;";
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=jdbcUtil.getConnection();
		ArrayList<Map<String, String>> product_list=new ArrayList<Map<String,String>>();
		if (isspecial==null) {
			try {
				PreparedStatement preparedStatement=connection.prepareStatement(sql);
				preparedStatement.setString(1, type);
				ResultSet resultSet=preparedStatement.executeQuery();
				while(resultSet.next()) {
					Map<String, String>teMap=new HashMap<String, String>();
					teMap.put("prodid",resultSet.getString("prodid"));
					teMap.put("prodname",resultSet.getString("prodname"));
					teMap.put("prodprice",Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}else if(isspecial.equals("是")) {
			try {
				PreparedStatement preparedStatement=connection.prepareStatement(sql_special);
				preparedStatement.setString(1, type);
				preparedStatement.setString(2, isspecial);
				ResultSet resultSet=preparedStatement.executeQuery();
				while(resultSet.next()) {
					Map<String, String>teMap=new HashMap<String, String>();
					teMap.put("prodid",resultSet.getString("prodid"));
					teMap.put("prodname",resultSet.getString("prodname"));
					teMap.put("prodprice",Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return product_list;
	}
}
