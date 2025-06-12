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
import dto.Friend;
import dto.Ranking;

@WebServlet("/Ranking")
public class RankingServlet extends HttpServlet {

    // ランキング一覧画面の表示（GET）
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        // ログインチェックを一時スキップ
        /* if (userId == null) {
            request.getRequestDispatcher("/WEB-INF/jsp/Login.jsp").forward(request, response);
            return;
        } */

        // 仮ユーザーIDをセット（テスト用）
        if (userId == null) {
            userId = "user001";  // ← DBに存在するユーザーIDに変更
            session.setAttribute("userId", userId);
        }


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
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<h2>ランキングの取得に失敗しました。</h2>");
        }
    }

    // 詳細表示（POST）
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String myId = (String) session.getAttribute("userId");
        String friendId = request.getParameter("friendId");

        if (myId == null || friendId == null) {
            response.sendRedirect("Ranking");
            return;
        }

        try {
            @SuppressWarnings("unchecked")
            List<Ranking> rankingList = (List<Ranking>) session.getAttribute("rankingList");

            if (rankingList == null) {
                response.sendRedirect("Ranking");
                return;
            }

            Ranking myself = null;
            Ranking friend = null;

            for (Ranking r : rankingList) {
                if (r.getId().equals(myId)) {
                    myself = r;
                } else if (r.getId().equals(friendId)) {
                    friend = r;
                }
            }

            if (myself != null && friend != null) {
                request.setAttribute("myself", myself);
                request.setAttribute("friend", friend);
                request.getRequestDispatcher("/WEB-INF/jsp/RankingDetail.jsp").forward(request, response);
            } else {
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<h2>ユーザー情報が見つかりません。</h2>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<h2>詳細表示中にエラーが発生しました。</h2>");
        }
    }
}