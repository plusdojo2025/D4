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

import dao.FriendDAO;
import dao.UsersDAO;
import dto.Friend;
import dto.Users;

/**
 * Servlet implementation class FriendListServlet
 */
@WebServlet("/FriendListServlet")
public class FriendListServlet extends HttpServlet {
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
		FriendDAO fDao = new FriendDAO();
		Friend sFriend = new Friend(myId);
		
		try {
			List<Friend> friendList = fDao.select(sFriend);
			
			// 検索結果をリクエストスコープに格納する
			request.setAttribute("friendList", friendList);
			
			// フレンド一覧ページにフォワードする
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FriendList.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect("/D4/LoginServlet");
			return;
		}
		
		boolean UserExist = false; //対象のユーザーが存在するか
		boolean hasFriend = false; // フレンドリストに登録があるか
		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		
		Users loginUser = (Users) session.getAttribute("users");
		String myId = loginUser.getId().toString();
		
		String friendId = request.getParameter("friendId");
		
		// friendLsitの情報と対象のユーザー情報を取得
		UsersDAO uDao = new UsersDAO();
		FriendDAO fDao = new FriendDAO();
		Friend sFriend = new Friend(myId, friendId);
		try {
			Users friendUser = uDao.select(friendId);
			List<Friend> friendList = fDao.select(sFriend);
			
			// 検索結果をリクエストスコープに格納する
			request.setAttribute("friendList", friendList);
			request.setAttribute("user", friendUser);
			
			if(friendUser != null) {
				UserExist = true;
				
				// friendList の中を1つずつ調べる
				for (Friend f : friendList) {
				    //対象がフレンドリストに登録されているなら
				    if (f.getFriendId().equals(friendUser.getId())) {
				        hasFriend = true;  // 存在している判定
				        break;
				    }
				}
				// JSPで使うためにリクエストにセット
				request.setAttribute("hasFriend", hasFriend);
			}

			request.setAttribute("UserExist", UserExist);
			
			// フレンド詳細ページにフォワードする
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddFriend.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	}
}
