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
import dto.Users;


@WebServlet("/AddFriendServlet")
public class  AddFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect("/webapp/LoginServlet");
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
						//request.setAttribute("result", new Result("更新成功！", "名刺情報を更新しました。", "/webapp/RedirectServlet"));
					} else { // 更新失敗
						//request.setAttribute("result", new Result("更新失敗！", "名刺情報を更新できませんでした。", "/webapp/RedirectServlet"));
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
						//request.setAttribute("result", new Result("更新成功！", "名刺情報を更新しました。", "/webapp/RedirectServlet"));
					} else { // 更新失敗
						//request.setAttribute("result", new Result("更新失敗！", "名刺情報を更新できませんでした。", "/webapp/RedirectServlet"));
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
						//request.setAttribute("result", new Result("更新成功！", "名刺情報を更新しました。", "/webapp/RedirectServlet"));
					} else { // 更新失敗
						//request.setAttribute("result", new Result("更新失敗！", "名刺情報を更新できませんでした。", "/webapp/RedirectServlet"));
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
						//request.setAttribute("result", new Result("更新成功！", "名刺情報を更新しました。", "/webapp/RedirectServlet"));
					} else { // 更新失敗
						//request.setAttribute("result", new Result("更新失敗！", "名刺情報を更新できませんでした。", "/webapp/RedirectServlet"));
					}
				} catch (Exception e) {
					// TODO 自動生成された catch ブロック
					e.printStackTrace();
				}
		    	break;
		    	
		    //戻る
		    case "戻る":
		    	//フレンドリストに戻る
		    	RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FriendList.jsp");
				dispatcher.forward(request, response);
		    	break;
		    
		    default:
		    	
		}
		
	}

}

