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
			response.sendRedirect("/D4/LoginServlet");
			return;
		}
		
		// weight がまだセッションに存在しない場合のみ追加
		if (session.getAttribute("weight") == null) {
			
			HealthDAO hDao = new HealthDAO();
			Users loginUser = (Users) session.getAttribute("users");
			String myId = loginUser.getId().toString();
			LocalDateTime yesterday = LocalDateTime.now().minusDays(1);
			String date = yesterday.toLocalDate().toString();
			
			List<Health> healthList = hDao.select(new Health(myId, date));
			
			if (healthList != null && !healthList.isEmpty()) {
			    session.setAttribute("weight", healthList.get(0).getWeight());
			}
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
			response.sendRedirect("/webapp/LoginServlet");
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
		bDao.insert(new Health(id, date, vegetable,sleep,walk,stress,weight));
				
		if (bDao.insert(new Health(id, date, vegetable,sleep,walk,stress,weight))) { // 登録成功
		request.setAttribute("result", new Result("今日の記録を登録しました。", "/D4/EvaluationServlet"));
		} else { // 登録失敗
		request.setAttribute("result", new Result("記録の登録に失敗しました。", "/D4/EvaluationServlet"));
		}
	
		// 結果ページにフォワードする
			//RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/result.jsp");
			//dispatcher.forward(request, response);
	}
	}



