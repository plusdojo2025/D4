<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.Ranking" %>
<%@ page import="dto.Users" %>

<%
    List<Ranking> rankingList = (List<Ranking>) request.getAttribute("rankingList");
		Users loginUser = (Users) session.getAttribute("users");
		String currentUserId = loginUser != null ? loginUser.getId() : null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ランキング ｜ けんこう日和</title>
</head>
<body>
    <h2>ランキング</h2>
    <table border="1">
        <tr>
            <th>順位</th>
            <th>ニックネーム</th>
            <th>スコア</th>
            <th></th>
        </tr>
        <%
            for (Ranking r : rankingList) {
                boolean isMyself = r.getId().equals(currentUserId);
        %>
        <tr>
            <td><%= r.getRank() %></td>
            <td><%= isMyself ? r.getName() + "（あなた）" : r.getName() %></td>
            <td>スコア：<%= String.format("%.2f", r.getScore()) %></td>
            <td>
                <% if (!isMyself) { %>
                	<form action="<c:url value='/RankingServlet' />" method="post">
                		<input type="hidden" name="friendId" value="<%= r.getId() %>">
            			<input type="submit" value="詳細を表示">
            		</form>
    			<% } else { %>
    			<% } %>	
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>