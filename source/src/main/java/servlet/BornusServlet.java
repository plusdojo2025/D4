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

import dao.IconDAO;
import dto.Icon;
import dto.Users;

/**
 * Servlet implementation class BornusServlet
 */
@WebServlet("/BornusServlet")
public class BornusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}
		

		//セッションからUsersオブジェクトを取り出す
		Users user = (Users) session.getAttribute("users");
		
		
		//最長連続ログイン日数を取得
		int mLogin= user.getmLogin();
		request.setAttribute("mLogin", mLogin);
		int start =((mLogin-1)/10)*10+1;
		int end = start +9;
		request.setAttribute("start", start );
		request.setAttribute("end", end);
		
		//報酬配布日数
		IconDAO iDao = new IconDAO();
		List<Icon> iconList = iDao.select();		
		request.setAttribute("iconList", iconList);

		// ログインボーナスページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Bornus.jsp");
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
