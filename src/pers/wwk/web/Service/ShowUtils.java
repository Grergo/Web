package pers.wwk.web.Service;
/**
 * 
 * @author geroge
 *
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import pers.wwk.Web.SQL.JDBCUtil;
/**
 * 
 * 1. 查询新品-> 可指定商品类型
 * 2. 查询指定类型商品-> 可指定商品类型，是否特价
 * 3. 查询时尚产品
 * 4. 获取商品详细信息
 *
 */
public class ShowUtils {
	public ArrayList<Map<String, String>> Select_news(String type) {
		ArrayList<Map<String, String>> tem_ArrayList = new ArrayList<Map<String, String>>();
		tem_ArrayList = Select_assigned_product(type, null);
		if (tem_ArrayList.size() > 4) {
			return (ArrayList<Map<String, String>>) tem_ArrayList.subList(0, 4);
		} else {
			return tem_ArrayList;
		}
	}

	public ArrayList<Map<String, String>> Select_assigned_product(String type, String isspecial) {
		String sql_special = "select prodid,prodname,prodprice from Web_Product where prodtype=? and isspecial=?;";
		String sql = "select prodid,prodname,prodprice from Web_Product where prodtype=?;";
		JDBCUtil jdbcUtil = new JDBCUtil();
		Connection connection = jdbcUtil.getConnection();
		ArrayList<Map<String, String>> product_list = new ArrayList<Map<String, String>>();
		if (isspecial == null) {
			try {
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, type);
				ResultSet resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
					Map<String, String> teMap = new HashMap<String, String>();
					teMap.put("prodid", resultSet.getString("prodid"));
					teMap.put("prodname", resultSet.getString("prodname"));
					teMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if (isspecial.equals("是")) {
			try {
				PreparedStatement preparedStatement = connection.prepareStatement(sql_special);
				preparedStatement.setString(1, type);
				preparedStatement.setString(2, isspecial);
				ResultSet resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
					Map<String, String> teMap = new HashMap<String, String>();
					teMap.put("prodid", resultSet.getString("prodid"));
					teMap.put("prodname", resultSet.getString("prodname"));
					teMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return product_list;
	}

	public ArrayList<Map<String, String>> get_fashion(String isspecial) {
		String sql = "select prodid,prodname,prodprice from Web_Product where isfashion='是';";
		String sql_isspecial = "select prodid,prodname,prodprice from Web_Product where isfashion='是' and isspecial='是';";
		JDBCUtil jdbcUtil = new JDBCUtil();
		Connection connection = jdbcUtil.getConnection();
		ArrayList<Map<String, String>> product_list = new ArrayList<Map<String, String>>();
		if (isspecial == null) {
			try {
				PreparedStatement preparedStatement = connection.prepareStatement(sql);
				ResultSet resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
					Map<String, String> teMap = new HashMap<String, String>();
					teMap.put("prodid", resultSet.getString("prodid"));
					teMap.put("prodname", resultSet.getString("prodname"));
					teMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		} else if (isspecial.equals("是")) {
			try {
				PreparedStatement preparedStatement = connection.prepareStatement(sql_isspecial);
				ResultSet resultSet = preparedStatement.executeQuery();
				while (resultSet.next()) {
					Map<String, String> teMap = new HashMap<String, String>();
					teMap.put("prodid", resultSet.getString("prodid"));
					teMap.put("prodname", resultSet.getString("prodname"));
					teMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
					product_list.add(teMap);
				}
			} catch (SQLException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
		}
		return product_list;
	}

	public ArrayList<Map<String, String>> Select_fashion_news() {
		ArrayList<Map<String, String>> tem_ArrayList = new ArrayList<Map<String, String>>();
		tem_ArrayList = get_fashion(null);
		if (tem_ArrayList.size() > 4) {
			return (ArrayList<Map<String, String>>) tem_ArrayList.subList(0, 4);
		} else {
			return tem_ArrayList;
		}
	}

	public Map<String, String> get_Product_info(String ProdID) {
		Map<String, String> prodinfoMap = new HashMap<String, String>();
		JDBCUtil jdbcUtil = new JDBCUtil();
		Connection connection = jdbcUtil.getConnection();
		String sqlString = "SELECT  prodname, putawaytime, prodprice FROM Web_Product where prodid=?;";
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(sqlString);
			preparedStatement.setString(1, ProdID);
			ResultSet resultSet = preparedStatement.executeQuery();
			resultSet.next();
			prodinfoMap.put("prodname", resultSet.getString("prodname"));
			prodinfoMap.put("putawaytime", resultSet.getDate("putawaytime").toString());
			prodinfoMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
			prodinfoMap.put("prodimg", ProdID);
			jdbcUtil.close(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
		return prodinfoMap;
	}
}
