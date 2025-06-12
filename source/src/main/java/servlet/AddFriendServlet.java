package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/AddFriendServlet")
public class  AddFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("id") == null) {
			response.sendRedirect("/webapp/LoginServlet");
			return;
		}
		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String myId = (session.getAttribute("id")).toString();
		String friendId = request.getParameter("friendId");
		String action = request.getParameter("submit");
		
		//パラメーターの種類を使って処理を切り替え・各処理に応じて画面遷移
		switch (action) {
			//申請
		    case "申請":
		    	
		    	break;
		    
		    //承認
		    case "承認":
		    	
		    	break;
			
		
		    //拒否
		    case "拒否":
		    	
		    	break;
		
		    //削除
		    case "削除":
		    	
		    	break;
		    	
		    //戻る
		    case "戻る":
		    	
		    	break;
		    
		    default:
		    	
		}
		
	}

}

