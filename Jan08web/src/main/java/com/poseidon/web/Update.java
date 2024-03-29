package com.poseidon.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poseidon.dao.BoardDAO;
import com.poseidon.dto.BoardDTO;
import com.poseidon.util.Util;

@WebServlet("/update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Update() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// no잡기
		// int no = request.getParameter("no"); - 이거 쓰면 에러남

		HttpSession session = request.getSession();

		if (session.getAttribute("mid") != null) {

			int no = Util.str2Int(request.getParameter("no"));

			// DAO에 질의하기
			BoardDAO dao = new BoardDAO();
			BoardDTO dto = dao.detail(no); // detail에 만든거 가져다 쓰는 것

			// System.out.println(dto.getMid().equals(session.getAttribute("mid"))); //true
			// System.out.println(session.getAttribute("mid").equals(dto.getMid())); //true
			// System.out.println(session.getAttribute("mid") == dto.getMid()); //false :
			// 문자열끼리 비교는 == 안됨.
			// System.out.println(((String)session.getAttribute("mid")).equals(dto.getMid()));
			// //true

			if (session.getAttribute("mid").equals(dto.getMid())) {

				// jsp에 보내기
				request.setAttribute("update", dto);

				RequestDispatcher rd = request.getRequestDispatcher("update.jsp");
				rd.forward(request, response);
			} else {
				response.sendRedirect("./error.jsp");
			}
		} else {
			response.sendRedirect("./login?login=nologin");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
				
		if (request.getParameter("title") != null && request.getParameter("content") != null
				&& Util.intCheck(request.getParameter("no")) && session.getAttribute("mid") != null) {
			// 진짜 수정
			BoardDTO dto = new BoardDTO();
			BoardDAO dao = new BoardDAO();
			
			dto.setContent(request.getParameter("content"));
			dto.setTitle(request.getParameter("title"));
			dto.setNo(Util.str2Int(request.getParameter("no")));
			dto.setMid((String)session.getAttribute("mid"));

			int result = dao.update(dto);
			// System.out.println("수정 결과 : " + result);
			if (result == 1) {
				response.sendRedirect("./detail?no=" + request.getParameter("no"));
			} else {
				response.sendRedirect("./error.jsp");
			}

		} else {
			// error
			response.sendRedirect("./error.jsp");
		}
	}

}
