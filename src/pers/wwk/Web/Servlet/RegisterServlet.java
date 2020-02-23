package pers.wwk.Web.Servlet;
/**
 * 
 * @author geroge
 *
 */
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pers.wwk.Web.SQL.JDBCUtil;
/**
 * 
 * 用户注册模块
 *
 */
@WebServlet("/regmember")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JDBCUtil jdbcUtil = new JDBCUtil();
		String usernameString = request.getParameter("username");
		String phoneString = request.getParameter("phone");
		String emString = request.getParameter("email");
		String passwdString = jdbcUtil.md5(request.getParameter("password"));
		String sql = "INSERT INTO Web_Customer (loginid, password, custname, gender, tel, address, integral, email,type) VALUES(?,?, ?, '', ?, '', 0, ?,'user');";
		Connection connection =jdbcUtil.getConnection();
		java.sql.PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			preparedStatement.setString(1, emString);
			preparedStatement.setString(2, passwdString);
			preparedStatement.setString(3, usernameString);
			preparedStatement.setString(4, phoneString);
			preparedStatement.setString(5, emString);
			preparedStatement.executeUpdate();
			jdbcUtil.close(preparedStatement);
			jdbcUtil.close(connection);
			response.sendRedirect(request.getContextPath() + "/Resource/pages/Regsuccess.jsp");
			HttpSession session = request.getSession();
			session.setAttribute("LOGINED", emString);
		} catch (SQLException e) {
			if (e.getLocalizedMessage().contains("Web_Customer_UN_ID")) {
				response.sendRedirect(request.getContextPath() + "/Resource/pages/register.jsp?code=f_UN_ID");
			} else if (e.getLocalizedMessage().contains("Web_Customer_UN_name")) {
				response.sendRedirect(request.getContextPath() + "/Resource/pages/register.jsp?code=f_UN_Name");
			}
		}
	}

}
