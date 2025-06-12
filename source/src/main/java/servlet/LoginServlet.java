package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HealthDAO;
import dao.UsersDAO;
import dto.Health;
import dto.Users;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Login.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		Users loginUser = new Users();
		loginUser.setId(id);
		loginUser.setPw(pw);

		UsersDAO dao = new UsersDAO();
		if (dao.isLoginOK(loginUser)) {
			HttpSession session = request.getSession();
			session.setAttribute("users", loginUser);

			String today = java.time.LocalDate.now().toString();
			
			Health healthParam = new Health();
			healthParam.setId(id);
			healthParam.setDate(today);

			HealthDAO healthDao = new HealthDAO();
			List<Health> healthList = healthDao.select(healthParam);

			boolean isFirstLogin = true;
			for (Health h : healthList) {
				if (h.getStress() != 0) {
					isFirstLogin = false;
					break;
				}
			}
			if (isFirstLogin) {
				response.sendRedirect(request.getContextPath() + "/HealthServlet");
			} else {
				response.sendRedirect(request.getContextPath() + "/EvaluationServlet");
			}
		} else {
			request.setAttribute("errorMsg", "ログイン失敗！IDまたはPWに間違いがあります。");
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Login.jsp");
			dispatcher.forward(request, response);
		}
	}

}
