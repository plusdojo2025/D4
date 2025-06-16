package servlet;

import java.io.IOException;
import java.time.LocalDate;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    
	    HttpSession session = request.getSession();
	    Users user = (Users) session.getAttribute("users");

	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/LoginServlet");
	        return;
	    }

	    // 表示したい年月を取得。なければ今月
	    String yearParam = request.getParameter("year");
	    String monthParam = request.getParameter("month");
	    LocalDate baseDate;
	    if (yearParam != null && monthParam != null) {
	        int year = Integer.parseInt(yearParam);
	        int month = Integer.parseInt(monthParam);
	        baseDate = LocalDate.of(year, month, 1);
	    } else {
	        baseDate = LocalDate.now().withDayOfMonth(1);
	    }

	    // 年月をJSPに渡す
	    request.setAttribute("year", baseDate.getYear());
	    request.setAttribute("month", baseDate.getMonthValue());

	    // 今日の日付（カレンダークリックで詳細取得する想定の当日情報）
	    LocalDate todayDate = LocalDate.now();
	    LocalDate yesterdayDate = todayDate.minusDays(1);

	    String today = todayDate.toString();
	    String yesterday = yesterdayDate.toString();

	    HealthDAO healthDao = new HealthDAO();

	    // 今日の情報を取得
	    Health todayCondition = new Health();
	    todayCondition.setId(user.getId());
	    todayCondition.setDate(today);
	    java.util.List<Health> todayList = healthDao.select(todayCondition);
	    Health todayData = todayList.isEmpty() ? null : todayList.get(0);

	    // 昨日の情報を取得
	    Health yesterdayCondition = new Health();
	    yesterdayCondition.setId(user.getId());
	    yesterdayCondition.setDate(yesterday);
	    java.util.List<Health> yesterdayList = healthDao.select(yesterdayCondition);
	    Health yesterdayData = yesterdayList.isEmpty() ? null : yesterdayList.get(0);

	    // 今日と昨日の評価値を初期化
	    int vegetableRatingToday = 0;
	    int sleepRatingToday = 0;
	    int walkRatingToday = 0;

	    int vegetableRatingYesterday = 0;
	    int sleepRatingYesterday = 0;
	    int walkRatingYesterday = 0;

	    // 生データ変換
	    if (todayData != null) {
	        vegetableRatingToday = convertVegetableToRating(todayData.getVegetable());
	        sleepRatingToday = convertSleepToRating(todayData.getSleep());
	        walkRatingToday = convertWalkToRating(todayData.getWalk());
	    }
	    if (yesterdayData != null) {
	        vegetableRatingYesterday = convertVegetableToRating(yesterdayData.getVegetable());
	        sleepRatingYesterday = convertSleepToRating(yesterdayData.getSleep());
	        walkRatingYesterday = convertWalkToRating(yesterdayData.getWalk());
	    }

	    // 評価値差分計算
	    int vegDiff = vegetableRatingToday - vegetableRatingYesterday;
	    int sleepDiff = sleepRatingToday - sleepRatingYesterday;
	    int walkDiff = walkRatingToday - walkRatingYesterday;

	    // コメント作成
	    String vegetableComment = createComment(vegetableRatingToday);
	    String sleepComment = createComment(sleepRatingToday);
	    String walkComment = createComment(walkRatingToday);

	    //全体スコア
	    double averageScore = 0.0;
	    if (todayData != null) {
	        int totalScore = vegetableRatingToday + sleepRatingToday + walkRatingToday;
	        averageScore = totalScore / 3.0;
	    }

	    int averageRating = (int) Math.round(averageScore);
	    
	    // BMI計算
	    double weight = 0.0;
	    if (todayData != null) {
	        weight = todayData.getWeight();
	    }else{
	    	System.out.println("データなし");	
	    }
	    
	    double height = user.getHeight();
	    	System.out.println(height);
	    double bmi = 0.0;

	    if (height > 0 && weight > 0) {
	        bmi = weight / (height * height);
	    } else {
	        System.out.println("BMI計算に必要な身長または体重がありません");
	    }
	    request.setAttribute("bmi", String.format("%.2f", bmi));

	    request.setAttribute("vegetableRating", vegetableRatingToday);
	    request.setAttribute("sleepRating", sleepRatingToday);
	    request.setAttribute("walkRating", walkRatingToday);

	    request.setAttribute("vegetableDiff", vegDiff);
	    request.setAttribute("sleepDiff", sleepDiff);
	    request.setAttribute("walkDiff", walkDiff);

	    request.setAttribute("vegetableComment", vegetableComment);
	    request.setAttribute("sleepComment", sleepComment);
	    request.setAttribute("walkComment", walkComment);
	    
	    request.setAttribute("averageScore", String.format("%.2f", averageScore));
	    request.setAttribute("averageRating", averageRating);
	    
	    request.setAttribute("todayData", todayData);
	    request.setAttribute("user", user);

	    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Evaluation.jsp");
	    dispatcher.forward(request, response);
	}

	private int convertWalkToRating(int walk) {
	    if (walk >= 6500 && walk <= 8000) return 5;
	    if (walk >= 5000) return 4;
	    if (walk >= 3500) return 3;
	    if (walk >= 2000) return 2;
	    return 1;
	}

	private int convertSleepToRating(int sleep) {
	    if (sleep >= 450) return 5;
	    if (sleep >= 400) return 4;
	    if (sleep >= 350) return 3;
	    if (sleep >= 300) return 2;
	    return 1;
	}

	private int convertVegetableToRating(int veg) {
	    if (veg >= 1 && veg <= 5) return veg;
	    return 1;
	}

	private String createComment(int score) {
	    if (score == 5) {
	        return "完璧!! 維持していこう!!";
	    } else if (score == 4) {
	        return "いい感じ!! このまま☆5を目指そう!!";
	    } else if (score == 3) {
	        return "もう少し頑張ろう!!";
	    } else if (score == 2) {
	        return "見直して!!";
	    } else {
	        return "コメント";
	    }
	}

}
