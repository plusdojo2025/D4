package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddFriendServlet")
public class  AddFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// リクエストパラメータを取得する
		
		//パラメーターの種類を使って処理を切り替え・各処理に応じて画面遷移
		//申請
		//承認
		//拒否
		//削除
		//戻る
		
	}

}

