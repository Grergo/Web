package SQL;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/regmember")
public class regmember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public regmember() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JDBCUtil jdbcUtil = new JDBCUtil();
		String usernameString = request.getParameter("username");
		String phoneString = request.getParameter("phone");
		String emString = request.getParameter("email");
		String passwdString = JDBCUtil.md5(request.getParameter("password"));
		String sql = "INSERT INTO Web_Customer (loginid, password, custname, gender, tel, address, integral, email) VALUES(?,?, ?, '', ?, '', 0, ?);";
		Connection connection = JDBCUtil.getConnection();
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
			JDBCUtil.close(preparedStatement);
			JDBCUtil.close(connection);
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
