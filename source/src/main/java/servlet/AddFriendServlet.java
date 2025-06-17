package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.FriendDAO;
import dto.Friend;
import dto.Result;
import dto.Users;


@WebServlet("/AddFriendServlet")
public class  AddFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.sendRedirect("/D4/FriendListServlet");

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
		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		Users loginUser = (Users) session.getAttribute("users");
		String myId = loginUser.getId().toString();
		String friendId = request.getParameter("friendId");
		String action = request.getParameter("submit");
		
		//パラメーターの種類を使って処理を切り替え・各処理に応じて画面遷移
		FriendDAO fDao = new FriendDAO();
		switch (action) {
			//申請
		    case "申請":
		    	try {
					if (fDao.insert(new Friend(myId, friendId, 0))) { // 更新成功
						request.setAttribute("redirect", new Result("申請を行いました。", "/D4/FriendListServlet"));
					} else { // 更新失敗
						request.setAttribute("redirect", new Result("申請に失敗しました。", "/D4/FriendListServlet"));
					}
				} catch (Exception e) {
					// TODO 自動生成された catch ブロック
					e.printStackTrace();
				}
		    	
		    	break;
		    
		    //承認
		    case "承認":
		    	try {
					if (fDao.update(new Friend(myId, friendId, 0))) { // 更新成功
						request.setAttribute("redirect", new Result("フレンド申請を承認しました。", "/D4/FriendListServlet"));
					} else { // 更新失敗
						request.setAttribute("redirect", new Result("フレンド申請の承認に失敗しました。", "/D4/FriendListServlet"));
					}
				} catch (Exception e) {
					// TODO 自動生成された catch ブロック
					e.printStackTrace();
				}
		    	break;
			
		
		    //拒否
		    case "拒否":
		    	try {
					if (fDao.delete(new Friend(myId, friendId, 0))) { // 更新成功
						request.setAttribute("redirect", new Result("申請を拒否しました。", "/D4/FriendListServlet"));
					} else { // 更新失敗
						request.setAttribute("redirect", new Result("申請の拒否に失敗しました。", "/D4/FriendListServlet"));
					}
				} catch (Exception e) {
					// TODO 自動生成された catch ブロック
					e.printStackTrace();
				}
		    	break;
		
		    //削除
		    case "削除":
		    	try {
					if (fDao.delete(new Friend(myId, friendId, 0))) { // 更新成功
						request.setAttribute("redirect", new Result("フレンドを削除しました。", "/D4/FriendListServlet"));
					} else { // 更新失敗
						request.setAttribute("redirect", new Result("フレンドの削除に失敗しました。", "/D4/FriendListServlet"));
					}
				} catch (Exception e) {
					// TODO 自動生成された catch ブロック
					e.printStackTrace();
				}
		    	break;
		    	
		    //戻る
		    case "戻る":
		    	//フレンドリストに戻る
		    	response.sendRedirect("/D4/FriendListServlet");
				return;
		    
		    default:
		    	
		}
		
		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp");
		dispatcher.forward(request, response);
		
	}

}

