package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsersDAO;
import dto.Users;

/**
 * Servlet implementation class RegistServlet
 */
@WebServlet("/RegistServlet")
public class RegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// ユーザー登録ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Regist.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
	    String pw = request.getParameter("pw");
	    String pw2 = request.getParameter("pw2");
	    int height = Integer.parseInt(request.getParameter("height"));
	    int weight = Integer.parseInt(request.getParameter("weight"));
	    String name = request.getParameter("name");
	    
	    // パスワード確認チェック
	    if (!pw.equals(pw2)) {
	        // 一致しないときの処理（例：エラーメッセージを表示して登録画面に戻す）
	        request.setAttribute("errorMsg", "パスワードが一致しません。");
	        request.getRequestDispatcher("/WEB-INF/jsp/Regist.jsp").forward(request, response);
	        return;
	    }

	    Users user = new Users(id, pw, height, name);
	 	
		// 登録処理を行う
		UsersDAO bDao = new UsersDAO();
	
		
		if(bDao.insert(new Users(id, pw, height,name))) {
			// 登録成功ならログイン画面などにリダイレクト	
			response.sendRedirect("/D4/LoginServlet");
			System.out.println("登録成功");
		} else {
			// 登録失敗時の処理（エラーメッセージ表示など）
			request.setAttribute("error", "登録に失敗しました");
			request.getRequestDispatcher("/Regist.jsp").forward(request, response);
			System.out.println("登録失敗");
		}
	}
}
