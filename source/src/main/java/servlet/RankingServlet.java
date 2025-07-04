package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.FriendDAO;
import dao.RankingDAO;
import dao.UsersDAO;
import dto.Friend;
import dto.Ranking;
import dto.Result;
import dto.Users;

@WebServlet("/RankingServlet")
public class RankingServlet extends HttpServlet {

    // ランキング一覧画面の表示（GET）
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // 再取得してuserIdはnullに(テスト用)
        //session.invalidate();
        //session = request.getSession();

        // usersオブジェクトからuserIdを取得する
        Users loginUser = (Users) session.getAttribute("users");
        String userId = (loginUser != null) ? loginUser.getId() : null;

        // もしもログインしていなかったらログインサーブレットにリダイレクトする
     		if (session.getAttribute("users") == null) {
     			response.sendRedirect(request.getContextPath() + "/LoginServlet");
     			return;
     		}
        
        // 仮ユーザーIDをセット（テスト用）
        /*
        if (userId == null) {
            userId = "user002";  // DBに存在するユーザーIDに変更
            session.setAttribute("userId", userId);
        }
        */

        try {
            // 自分のIDを条件にフレンド一覧を取得
            Friend condition = new Friend();
            condition.setMyId(userId);

            FriendDAO friendDao = new FriendDAO();
            List<Friend> friendList = friendDao.select(condition);

            RankingDAO rankingDao = new RankingDAO();
            List<Ranking> rankingList = rankingDao.makeRanking(friendList);

            // セッションにランキング情報を保存（POST時に利用）
            session.setAttribute("rankingList", rankingList);

            request.setAttribute("rankingList", rankingList);
            request.getRequestDispatcher("/WEB-INF/jsp/Ranking.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            Result result = new Result("フレンドを追加してください。", request.getContextPath() + "/FriendListServlet");

            request.setAttribute("redirect", result);

            request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp").forward(request, response);
        }
    }

    // 詳細表示（POST）
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	//System.out.println("【doPost開始】");

        HttpSession session = request.getSession();

        Users loginUser = (Users) session.getAttribute("users");
        String myId = (loginUser != null) ? loginUser.getId() : null;
        String friendId = request.getParameter("friendId");

        //System.out.println("myId: " + myId);
        //System.out.println("friendId: " + friendId);

        if (myId == null || friendId == null) {
            //System.out.println("IDが取得できずリダイレクト");
            response.sendRedirect("Ranking");
            return;
        }

        try {
            @SuppressWarnings("unchecked")
            List<Ranking> rankingList = (List<Ranking>) session.getAttribute("rankingList");

            //System.out.println("rankingListはnullか？ → " + (rankingList == null));
            if (rankingList == null) {
                //System.out.println("rankingListがnullでリダイレクト");
                response.sendRedirect("Ranking");
                return;
            }

            Ranking myself = null;
            Ranking friend = null;

            for (Ranking r : rankingList) {
                if (r == null) {
                    //System.out.println("rankingListにnullの要素がある");
                    continue;
                }
                //System.out.println("ranking item: id=" + r.getId() + ", name=" + r.getName());

                if (r.getId().equals(myId)) {
                    myself = r;
                } else if (r.getId().equals(friendId)) {
                    friend = r;
                }
            }

            //if (myself == null) System.out.println("myself が null");
            //if (friend == null) System.out.println("friend が null");

            UsersDAO uDao = new UsersDAO();
            Users friendData = uDao.select(friendId);

            //if (friendData == null) {
                //System.out.println("friendData が null");
            //}

            if (myself != null && friend != null) {
                //System.out.println("すべてのデータを取得できている、JSPにフォワード");
                request.setAttribute("myself", myself);
                request.setAttribute("friend", friend);
                request.setAttribute("frienddata", friendData);
                request.getRequestDispatcher("/WEB-INF/jsp/RankingDetail.jsp").forward(request, response);
            } else {
                //System.out.println("必要なデータが不足している");
            	Result result = new Result("ユーザー情報が見つかりません。", request.getContextPath() + "/RankingServlet");
            	request.setAttribute("redirect", result);
            	request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp").forward(request, response);
            	return;
            }

        } catch (Exception e) {
            //System.out.println("doPost内で例外");
            e.printStackTrace();
            Result result = new Result("詳細表示中にエラーが発生しました。", request.getContextPath() + "/RankingServlet");
            request.setAttribute("redirect", result);
            request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp").forward(request, response);
        }
    }
}
