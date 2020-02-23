package SQL;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JDBCUtil jdbcUtil = new JDBCUtil();
		HttpSession session = request.getSession();
		String userString = request.getParameter("username");
		String passwdString = jdbcUtil.md5(request.getParameter("password"));
		Connection connection = jdbcUtil.getConnection();
		String sql_email = "select loginid,type from Web_Customer where email=? and password=?;";
		String sql_phone = "select loginid,type from Web_Customer where tel=? and password=?;";
		PreparedStatement preparedStatement = null;
		if (userString.contains("@")) {
			try {
				preparedStatement = connection.prepareStatement(sql_email);
				preparedStatement.setString(1, userString);
				preparedStatement.setString(2, passwdString);
				ResultSet resultSet = preparedStatement.executeQuery();
				resultSet.next();
				String idString = resultSet.getString("loginid");
				String type=resultSet.getString("type");
				jdbcUtil.close(connection, preparedStatement, resultSet);
				setLoginCookie(response, idString);
				setLoginSession(request, idString);
				if (type.equals("admin")) {
					if (session.getAttribute("Reference") == null) {
						response.sendRedirect(request.getContextPath() + "/Resource/pages/ProductManager.jsp?id=1");
					} else {
						response.sendRedirect(
								request.getContextPath() + "/Resource/pages/" + session.getAttribute("Reference"));
					}
				} else {
					if (session.getAttribute("Reference") == null) {
						response.sendRedirect(request.getContextPath() + "/Resource/pages/memberCenter.jsp?id=1");
					} else {
						response.sendRedirect(
								request.getContextPath() + "/Resource/pages/" + session.getAttribute("Reference"));
					}

				}
			} catch (SQLException e) {
				if (e.getLocalizedMessage().contains("empty")) {
					response.sendRedirect(request.getContextPath() + "/Resource/pages/Login.jsp?code=faild");
				}
			}

		} else {
			try {
				preparedStatement = connection.prepareStatement(sql_phone);
				preparedStatement.setString(1, userString);
				preparedStatement.setString(2, passwdString);
				ResultSet resultSet = preparedStatement.executeQuery();
				resultSet.next();
				String idString = resultSet.getString("loginid");
				String type=resultSet.getString("type");
				jdbcUtil.close(connection, preparedStatement, resultSet);
				setLoginCookie(response, idString);
				setLoginSession(request, idString);
				if (type.equals("admin")) {
					if (session.getAttribute("Reference") == null) {
						response.sendRedirect(request.getContextPath() + "/Resource/pages/ProductManager.jsp?id=1");
					} else {
						response.sendRedirect(
								request.getContextPath() + "/Resource/pages/" + session.getAttribute("Reference"));
					}
				} else {
					if (session.getAttribute("Reference") == null) {
						response.sendRedirect(request.getContextPath() + "/Resource/pages/memberCenter.jsp?id=1");
					} else {
						response.sendRedirect(
								request.getContextPath() + "/Resource/pages/" + session.getAttribute("Reference"));
					}
				}
			} catch (SQLException e) {
				if (e.getLocalizedMessage().contains("empty")) {
					response.sendRedirect(request.getContextPath() + "/Resource/pages/Login.jsp?code=faild");
				}
			}
		}
	}

	protected void setLoginCookie(HttpServletResponse response, String LoingID) {
		Cookie cookie = new Cookie("LoginID", LoingID);
		cookie.setMaxAge(1800);
		response.addCookie(cookie);
	}

	protected void setLoginSession(HttpServletRequest request, String LoginID) {
		HttpSession session = request.getSession();
		session.setAttribute("LOGINED", LoginID);
	}

}
