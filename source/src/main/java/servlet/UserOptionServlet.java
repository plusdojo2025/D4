package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Users;

/**
 * Servlet implementation class UserOptionServlet
 */
@WebServlet("/UserOptionServlet")
public class UserOptionServlet extends HttpServlet {
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
		
		// リクエストパラメータを取得する
		// セッションスコープから自分のIDを取得して、それをもとにフレンド関連のデータを取得
		Users loginUser = (Users) session.getAttribute("users");
		String myId = loginUser.getId().toString();
		
		// 検索処理を行う
		
		// ユーザー編集ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserOption.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
