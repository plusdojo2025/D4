package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HealthDAO;
import dto.Health;
import dto.Users;

@WebServlet("/EvaluationServlet")
public class EvaluationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// セッションからユーザー情報を取得
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("users");
//		if (user == null) {
//			response.sendRedirect(request.getContextPath() + "/LoginServlet");
//			return;
//		}

		HealthDAO dao = new HealthDAO();
		Health searchCondition = new Health();
		searchCondition.setId(user.getId());

		List<Health> rawList = dao.select(searchCondition);

		// スコア変換処理
		List<Health> convertedList = new ArrayList<>();
		for (Health h : rawList) {
			Health converted = new Health();
			converted.setId(h.getId());
			converted.setDate(h.getDate());
			converted.setVegetable(convertVegetableToRating(h.getVegetable()));
			converted.setSleep(convertSleepToRating(h.getSleep()));
			converted.setWalk(convertWalkToRating(h.getWalk()));
			converted.setWeight(h.getWeight());
			convertedList.add(converted);
		}

		request.setAttribute("healthList", convertedList);

		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect("/D4/LoginServlet");
			return;
		}
		// 評価ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Evaluation.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	private int convertWalkToRating(int walk) {
		if (walk >= 6500 && walk <= 8000) return 5;
		if (walk >= 5000) return 4;
		if (walk >= 3500) return 3;
		if (walk >= 2000) return 2;
		return 1;
	}

	private int convertSleepToRating(int sleepMinutes) {
		if (sleepMinutes >= 450) return 5;
		if (sleepMinutes >= 400) return 4;
		if (sleepMinutes >= 350) return 3;
		if (sleepMinutes >= 300) return 2;
		return 1;
	}

	private int convertVegetableToRating(int veg) {
		if (veg >= 1 && veg <= 5) return veg;
		return 1;
	}
}
