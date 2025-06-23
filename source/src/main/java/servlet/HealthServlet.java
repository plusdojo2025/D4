	package servlet;

import java.io.IOException;
import java.time.LocalDateTime;
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
import dto.Result;
import dto.Users;

/**
 * Servlet implementation class HealthServlet
 */
@WebServlet("/HealthServlet")
public class HealthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}
		
		HealthDAO hDao = new HealthDAO();
		Users loginUser = (Users) session.getAttribute("users");
		String myId = loginUser.getId().toString();
		
		// weight がまだセッションに存在しない場合のみ追加
		if (session.getAttribute("weight") == null) {
			LocalDateTime yesterday = LocalDateTime.now().minusDays(1);
			String date = yesterday.toLocalDate().toString();
			List<Health> healthList = hDao.select(new Health(myId, date));
			if (healthList != null && !healthList.isEmpty()) {
			    session.setAttribute("weight", healthList.get(0).getWeight());
			}
		}
		
		//既に今日のデータがある場合は記録を取り出す
		LocalDateTime yesterday = LocalDateTime.now();
		String date = yesterday.toLocalDate().toString();
		List<Health> healthList = hDao.select(new Health(myId, date));
		if (healthList != null && !healthList.isEmpty()) {
		    session.setAttribute("health", healthList.get(0));
		}
		
		 //登録ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Health.jsp");
		dispatcher.forward(request, response);
	}

		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}
		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		
		Users loginUser = (Users) session.getAttribute("users");
		String id = loginUser.getId().toString();
		
		//現在日時
		LocalDateTime today = LocalDateTime.now();
		String date = today.toLocalDate().toString();
				
		int vegetable = Integer.parseInt(request.getParameter("vegetable"));
		
		int sleepHour = Integer.parseInt(request.getParameter("sleep_hour"));
		int sleepMinute = Integer.parseInt(request.getParameter("sleep_minute"));
		int sleep = 60*sleepHour + sleepMinute;
		
		int walk; 
		String checkWalk = request.getParameter("walk");
		if(checkWalk == null || checkWalk.isEmpty()){
			walk=0;
		}else {
			walk= Integer.parseInt(checkWalk);
		}
		
		int    stress = Integer.parseInt(request.getParameter("stress"));
		
		double weight;	
		String checkWeight = request.getParameter("weight");
		if(checkWeight == null || checkWeight.isEmpty()){
			weight=0;
		}else {
			weight= Double.parseDouble(checkWeight);
		}


	
		// 登録処理を行う
		HealthDAO bDao = new HealthDAO();
		Health health = new Health(id, date, vegetable, sleep, walk, stress, weight);
		
		//既にデータがある場合は更新
		
		List<Health> healthList = bDao.select(health);
		boolean success;
		
		if (healthList.size() != 0) {
		    success = bDao.update(health);
		} else {
		    success = bDao.insert(health);
		}
		if (success) {
		    request.setAttribute("redirect", new Result("今日の記録を保存しました。", request.getContextPath() + "/EvaluationServlet"));
		} else {
		    request.setAttribute("redirect", new Result("記録の保存に失敗しました。", request.getContextPath() + "/EvaluationServlet"));
		}
		
		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp");
		dispatcher.forward(request, response);
	}
}