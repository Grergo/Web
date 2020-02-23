package SQL;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Member_DO
 */
@WebServlet("/Member_DO")
public class Member_DO extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Member_DO() {
		super();
		// TODO Auto-generated constructor stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		if (request.getParameter("address") == null) {
			update_person_info(request, response);
		} else {
			update_address(request, response);
		}
	}

	protected void update_person_info(HttpServletRequest request, HttpServletResponse response) {
		memberUtils memberUtils = new memberUtils();
		HttpSession session = request.getSession();
		memberUtils.update_person_info(request.getParameter("gender").toString(),
				request.getParameter("phone").toString(), request.getParameter("username").toString(),
				session.getAttribute("LOGINED").toString());
		try {
			response.sendRedirect(request.getContextPath() + "/Resource/pages/memberCenter.jsp?id=1");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	protected void update_address(HttpServletRequest request, HttpServletResponse response) {
		memberUtils memberUtils = new memberUtils();
		HttpSession session = request.getSession();
		memberUtils.update_address(request.getParameter("address"), session.getAttribute("LOGINED").toString());
		try {
			response.sendRedirect(request.getContextPath() + "/Resource/pages/memberCenter.jsp?id=3");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
