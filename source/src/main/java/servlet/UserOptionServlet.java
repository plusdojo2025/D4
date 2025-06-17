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
import dao.ThemeDAO;
import dao.UsersDAO;
import dto.Icon;
import dto.Result;
import dto.Theme;
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
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}
		
		// リクエストパラメータを取得する
		// セッションスコープから自分のデータを取得
		Users loginUser = (Users) session.getAttribute("users");
		String myId = loginUser.getId();
		// 検索処理を行う
		UsersDAO uDao = new UsersDAO();
		Users user = uDao.select(myId);
		IconDAO iDao = new IconDAO();
		List<Icon> iconList = iDao.select();
		ThemeDAO tDao = new ThemeDAO();
		List<Theme> themeList = tDao.select();
		
		// 検索結果をリクエストスコープに格納する
		request.setAttribute("userInfo", user);
		request.setAttribute("iconList", iconList);
		request.setAttribute("themeList", themeList);
		
		// ユーザー編集ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserOption.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// もしもログインしていなかったらログインサーブレットにリダイレクトする
		HttpSession session = request.getSession();
		if (session.getAttribute("users") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}
		
		// リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("myId");
		String pw = request.getParameter("pw");
		int height = Integer.parseInt(request.getParameter("height"));
		String name = request.getParameter("name");
		String icon = request.getParameter("icon");
		String theme = request.getParameter("theme");
		// チェックボックスはnullかどうかで判断
		int vPrivate = request.getParameter("vegetable") != null ? 1 : 0;
		int sPrivate = request.getParameter("sleep") != null ? 1 : 0;
		int wPrivate = request.getParameter("walk") != null ? 1 : 0;
		
		// friendLsitの情報と対象のユーザー情報を取得
		UsersDAO uDao = new UsersDAO();
		Users user = new Users(id, pw, height, name, theme, icon, vPrivate, sPrivate, wPrivate);
		
		try {
			if (uDao.update(user)) { // 更新成功
				request.setAttribute("redirect", new Result("ユーザー情報を更新しました。", request.getContextPath() + "/UserOptionServlet"));
				Users logedUser = uDao.select(id);
				session.setAttribute("users", logedUser);
			} else { // 更新失敗
				request.setAttribute("redirect", new Result("ユーザー情報を更新できませんでした。", request.getContextPath() + "/UserOptionServlet"));
			}
		} catch (Exception e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		
		// 結果ページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Redirect.jsp");
		dispatcher.forward(request, response);
	}
}
