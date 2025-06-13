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
import dto.Health;
import dto.Users;
	
	@WebServlet("/EvaluationServlet")
	public class EvaluationServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        Users user = (Users) session.getAttribute("users");

	        if (user == null) {
	            response.sendRedirect(request.getContextPath() + "/LoginServlet");
	            return;
	        }

	        // --- 日付の計算（Java8以降の LocalDateを使う例） ---
	        java.time.LocalDate todayDate = java.time.LocalDate.now();
	        java.time.LocalDate yesterdayDate = todayDate.minusDays(1);

	        String today = todayDate.toString();       // 例: "2025-06-13"
	        String yesterday = yesterdayDate.toString(); // 例: "2025-06-12"

	        HealthDAO healthDao = new HealthDAO();

	        // 今日のデータを取得
	        Health todayCondition = new Health();
	        todayCondition.setId(user.getId());
	        todayCondition.setDate(today);

	        List<Health> todayList = healthDao.select(todayCondition);

	        // 昨日のデータを取得
	        Health yesterdayCondition = new Health();
	        yesterdayCondition.setId(user.getId());
	        yesterdayCondition.setDate(yesterday);

	        List<Health> yesterdayList = healthDao.select(yesterdayCondition);

	        // データの取り出しと差分計算
	        Health todayData = todayList.isEmpty() ? null : todayList.get(0);
	        Health yesterdayData = yesterdayList.isEmpty() ? null : yesterdayList.get(0);

	        int vegDiff = 0;
	        int sleepDiff = 0;
	        int walkDiff = 0;

	        if (todayData != null && yesterdayData != null) {
	            vegDiff = convertVegetableToRating(todayData.getVegetable()) - convertVegetableToRating(yesterdayData.getVegetable());
	            sleepDiff = convertSleepToRating(todayData.getSleep()) - convertSleepToRating(yesterdayData.getSleep());
	            walkDiff = convertWalkToRating(todayData.getWalk()) - convertWalkToRating(yesterdayData.getWalk());
	            
	            
	        }

	        // 今日のデータをJSPに渡す（差分も一緒に）
	        request.setAttribute("todayData", todayData);
	        request.setAttribute("vegDiff", vegDiff);
	        request.setAttribute("sleepDiff", sleepDiff);
	        request.setAttribute("walkDiff", walkDiff);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Evaluation.jsp");
	        dispatcher.forward(request, response);
	        
	        
	    }

}