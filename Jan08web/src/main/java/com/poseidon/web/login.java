package com.poseidon.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poseidon.dao.LogDAO;
import com.poseidon.dao.MemberDAO;
import com.poseidon.dto.MemberDTO;
import com.poseidon.util.Util;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String url = null;
		if(session.getAttribute("mname") != null) {
			url = "already.jsp";
		} else {
			url = "login.jsp";
		}
		RequestDispatcher rd = request.getRequestDispatcher(url);
		
		/*
		 * RequestDispatcher rd = null;
		 * 
		 * if(session.getAttribute("mname") != null) { rd =
		 * request.getRequestDispatcher("already.jsp"); } else { rd =
		 * request.getRequestDispatcher("login.jsp"); }
		 * 
		 * RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
		 */
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 2024-01-12 웹 서버프로그램 구현
		if (request.getParameter("id") != null && request.getParameter("pw") != null) {
			MemberDTO dto = new MemberDTO();
			dto.setMid(request.getParameter("id"));
			dto.setMpw(request.getParameter("pw"));

			MemberDAO dao = new MemberDAO();
			dto = dao.login(dto);
			//아이피도 저장하기 (2024-01-23)
			Map<String, Object> log = new HashMap<String, Object>();
			log.put("ip", Util.getIP(request));
			log.put("url", "./login");
			log.put("data", "id:"+dto.getMid()+", pw:"+dto.getMpw() + " 결과 : " + dto.getCount());
			
			LogDAO logDAO = new LogDAO();
			logDAO.write(log);
			

			if (dto.getCount() == 1) {
				System.out.println("정상 로그인");
				// 세션만들기
				HttpSession session = request.getSession();
				session.setAttribute("mname", dto.getMname()); // mname이라는 이름으로 세션 만듦
				session.setAttribute("mid", dto.getMid()); // mid라는 이름으로 세션 만듦
				// 페이지 이동 = board
				response.sendRedirect("./board");
			} else {
				// System.out.println("헬로우 사만다 = 안녕하세요 시어도르님");
				// 페이지 이동 = login?error=4567
				response.sendRedirect("./login?error=4567");
			}

		} 

	}

}
