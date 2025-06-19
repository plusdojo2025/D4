package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            response.sendRedirect("/D4/LoginServlet");
            return;
        }

        // 表示したい年月を取得。なければ今月
        String dateParam = request.getParameter("date");  // yyyy-MM-dd形式で日付受け取り
        LocalDate baseDate;

        if (dateParam != null && !dateParam.isEmpty()) {
            baseDate = LocalDate.parse(dateParam);
        } else {
            String yearParam = request.getParameter("year");
            String monthParam = request.getParameter("month");

            if (yearParam != null && monthParam != null) {
                int year = Integer.parseInt(yearParam);
                int month = Integer.parseInt(monthParam);
                baseDate = LocalDate.of(year, month, 1);
            } else {
                baseDate = LocalDate.now().withDayOfMonth(1);
            }
        }

        // カレンダー表示用に年月を渡す（baseDateの年月）
        request.setAttribute("year", baseDate.getYear());
        request.setAttribute("month", baseDate.getMonthValue());

        HealthDAO healthDao = new HealthDAO();
        
        String datePattern = baseDate.getYear() + "-" + String.format("%02d", baseDate.getMonthValue());
        List<Health> healthList = healthDao.selectByMonth(user.getId(), datePattern);

        Map<String, String> calendarIcons = new HashMap<>();
        for (Health health : healthList) {
            int stress = health.getStress();
            String iconPath = iconForStress(stress);
            calendarIcons.put(health.getDate(), iconPath);
        }
        request.setAttribute("calendarIcons", calendarIcons);

       
        String selectedDateParam = request.getParameter("date");
        LocalDate todayDate;
        if (selectedDateParam != null && !selectedDateParam.isEmpty()) {
            todayDate = LocalDate.parse(selectedDateParam); 
        } else {
            todayDate = LocalDate.now();
        }

        LocalDate displayDate = (dateParam != null && !dateParam.isEmpty()) ? LocalDate.parse(dateParam) : LocalDate.now();
        String displayDateStr = displayDate.toString();
        LocalDate prevDate = displayDate.minusDays(1);
        String prevDateStr = prevDate.toString();

        // その日の情報を取得
        Health todayCondition = new Health();
        todayCondition.setId(user.getId());
        todayCondition.setDate(displayDateStr);
        List<Health> todayList = healthDao.select(todayCondition);
        Health todayData = todayList.isEmpty() ? null : todayList.get(0);


        // 昨日の情報を取得
        Health yesterdayCondition = new Health();
        yesterdayCondition.setId(user.getId());
        yesterdayCondition.setDate(prevDateStr);
        List<Health> yesterdayList = healthDao.select(yesterdayCondition);
        Health yesterdayData = yesterdayList.isEmpty() ? null : yesterdayList.get(0);

        // 前日データが取得できた場合のみ差分を計算
        boolean showDiff = yesterdayData != null;

        // 今日と前日の評価値を初期化
        int vegetableRatingToday = 0;
        int sleepRatingToday = 0;
        int walkRatingToday = 0;
        int vegetableRatingYesterday = 0;
        int sleepRatingYesterday = 0;
        int walkRatingYesterday = 0;

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

        // 差分計算（前日データがある時）
        int vegDiff   = showDiff ? vegetableRatingToday - vegetableRatingYesterday : 0;
        int sleepDiff = showDiff ? sleepRatingToday - sleepRatingYesterday : 0;
        int walkDiff  = showDiff ? walkRatingToday - walkRatingYesterday : 0;


        // 差分が0でない場合のみ表示
        boolean showVegDiff = vegDiff != 0;
        boolean showSleepDiff = sleepDiff != 0;
        boolean showWalkDiff = walkDiff != 0;

        // コメント
        String vegetableComment = createComment(vegetableRatingToday);
        String sleepComment = createComment(sleepRatingToday);
        String walkComment = createComment(walkRatingToday);

        // 全体スコア計算
        double averageScore = 0.0;
        if (todayData != null) {
            int totalScore = vegetableRatingToday + sleepRatingToday + walkRatingToday;
            averageScore = totalScore / 3.0;
        }

        int averageRating = (int) Math.round(averageScore);

        // BMI計算
        int height = user.getHeight();
        double weight = todayData.getWeight();
        double heightInMeters = height / 100.0;
        double bmi = weight / (heightInMeters * heightInMeters);
        
        
     // グラフ表示用データ
        LocalDate weekAgoDate = todayDate.minusDays(7);
        String weekAgo = weekAgoDate.toString();

        List<Health> recentHealthList = healthDao.selectByRecentDays(user.getId(), weekAgo, todayDate.toString());
        request.setAttribute("recentHealthList", recentHealthList);

        Map<String, Health> healthMap = new HashMap<>();
        if (recentHealthList != null) {
            for (Health h : recentHealthList) {
                healthMap.put(h.getDate(), h);
            }
        }
     
        List<Integer> vegScoreList = new ArrayList<>();
        List<Integer> vegPrevScoreList = new ArrayList<>();
        List<Integer> sleepScoreList = new ArrayList<>();
        List<Integer> sleepPrevScoreList = new ArrayList<>();
        List<Integer> walkScoreList = new ArrayList<>();
        List<Integer> walkPrevScoreList = new ArrayList<>();
        List<String> dayLabelList = new ArrayList<>();

        LocalDate currentDate = weekAgoDate; 

        while (!currentDate.isAfter(todayDate)) {
            prevDate = currentDate.minusDays(1);

            Health todayHealth = healthMap.getOrDefault(currentDate.toString(), null);
            Health yesterdayHealth = healthMap.getOrDefault(prevDate.toString(), null);

            vegScoreList.add(todayHealth != null ? convertVegetableToRating(todayHealth.getVegetable()) : 0);
            vegPrevScoreList.add(yesterdayHealth != null ? convertVegetableToRating(yesterdayHealth.getVegetable()) : 0);

            sleepScoreList.add(todayHealth != null ? convertSleepToRating(todayHealth.getSleep()) : 0);
            sleepPrevScoreList.add(yesterdayHealth != null ? convertSleepToRating(yesterdayHealth.getSleep()) : 0);

            walkScoreList.add(todayHealth != null ? convertWalkToRating(todayHealth.getWalk()) : 0);
            walkPrevScoreList.add(yesterdayHealth != null ? convertWalkToRating(yesterdayHealth.getWalk()) : 0);

            String[] jpWeekdays = {"月", "火", "水", "木", "金", "土", "日"};
            int dayOfWeekValue = currentDate.getDayOfWeek().getValue(); 
            
            dayLabelList.add(jpWeekdays[dayOfWeekValue - 1]);

            currentDate = currentDate.plusDays(1);
        }



        request.setAttribute("vegScoreList", vegScoreList);
        request.setAttribute("vegPrevScoreList", vegPrevScoreList);
        request.setAttribute("sleepScoreList", sleepScoreList);
        request.setAttribute("sleepPrevScoreList", sleepPrevScoreList);
        request.setAttribute("walkScoreList", walkScoreList);
        request.setAttribute("walkPrevScoreList", walkPrevScoreList);
        request.setAttribute("dayLabelList", dayLabelList);


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
        request.setAttribute("showVegDiff", showVegDiff);
        request.setAttribute("showSleepDiff", showSleepDiff);
        request.setAttribute("showWalkDiff", showWalkDiff);
        request.setAttribute("todayData", todayData);
        request.setAttribute("user", user);
        
        request.setAttribute("showDiff", showDiff);

        // JSPへフォワード
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
            return "いい感じ!! このまま☆5を目指ろう!!";
        } else if (score == 3) {
            return "もう少し頑張ろう!!";
        } else if (score <= 2) {
            return "見直して!!";
        } else {
            return "コメント";
        }
    }
    
    private String iconForStress(int stress) { 
        if (stress == 1) return "/images/stamp_sad.png";		//ストレス値画像パス
        if (stress == 2) return "/images/stamp_normal.png";		//ストレス値画像パス
        if (stress == 3) return "/images/stamp_happy.png";		//ストレス値画像パス

        return "/images/stamp_default.png";		//適当な画像のパス (基本表示されない)
    }

}
