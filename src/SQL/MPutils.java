package SQL;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class MPutils {
	protected String sql_getProduct="SELECT prodid, prodname, putawaytime, isspecial, isfashion, prodprice, prodimg, prodtype FROM Web_Product;";
	protected String sql_updateProduct="UPDATE Web_Product SET prodname=?, putawaytime=?, isspecial=?, isfashion=?, prodprice=?, prodtype=? WHERE prodid=?;";
	protected String sql_insertProduct="INSERT INTO Web_Product (prodid, prodname, putawaytime, isspecial, isfashion, prodprice, prodimg, prodtype) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
	protected String sql_delProduct="DELETE FROM Web_Product WHERE prodid=?;";
	private ArrayList<Map<String, String>> getProduct() {
		// 查询所有产品信息,存到list中,返回list,出现异常返回null
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=jdbcUtil.getConnection();
		ArrayList<Map<String, String>> product_ArrayList= new ArrayList<Map<String,String>>();
		PreparedStatement preparedStatement=null;
		try {
			preparedStatement=connection.prepareStatement(sql_getProduct);
			ResultSet resultSet=preparedStatement.executeQuery();
			while(resultSet.next()) {
				Map<String, String> temp_mapMap=new HashMap<String, String>();
				temp_mapMap.put("prodid", resultSet.getString("prodid"));
				temp_mapMap.put("prodname", resultSet.getString("prodname"));
				temp_mapMap.put("putawaytime", resultSet.getDate("putawaytime").toLocaleString());
				temp_mapMap.put("isspecial", resultSet.getString("isspecial"));
				temp_mapMap.put("isfashion", resultSet.getString("isfashion"));
				temp_mapMap.put("prodprice", Double.toString(resultSet.getDouble("prodprice")));
				temp_mapMap.put("prodimg", resultSet.getString("prodimg"));
				temp_mapMap.put("prodtype", resultSet.getString("prodtype"));
				product_ArrayList.add(temp_mapMap);
			}
			jdbcUtil.close(connection, preparedStatement, resultSet);
		} catch (Exception e) {
			return null;
		}
		return product_ArrayList;
	}
	private void insertProduct(String prodname,String prodid,String isspecial,String isfashion,String  prodprice,String prodimg,String prodtype) {
		JDBCUtil jdbcUtil=new JDBCUtil();
		Connection connection=jdbcUtil.getConnection();
		java.util.Date date=new java.util.Date();
		java.sql.Date sql_date= new java.sql.Date(date.getTime());
		try {
			PreparedStatement preparedStatement=connection.prepareStatement(sql_insertProduct);
			preparedStatement.setString(1, prodname);
			preparedStatement.setString(2, prodid);
			preparedStatement.setDate(3, sql_date);
			preparedStatement.setString(4, isspecial);
			preparedStatement.setString(5, isfashion);
			preparedStatement.setDouble(6, Double.valueOf(prodprice));
			preparedStatement.setString(7, prodimg);
			preparedStatement.setString(8, prodtype);
			preparedStatement.executeUpdate();
			jdbcUtil.close(connection, preparedStatement, null);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
	}
}
