package com.poseidon.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poseidon.dao.MemberDAO;
import com.poseidon.dto.BoardDTO;
import com.poseidon.dto.MemberDTO;

@WebServlet("/join") //@는 컨트롤러? 리포지토리? 
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Join() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("join.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//값 잡아주세요. id, name, pw1
		MemberDTO dto = new MemberDTO();
		
		dto.setMid(request.getParameter("id"));
		dto.setMname(request.getParameter("name"));
		dto.setMpw(request.getParameter("pw1"));
		
		
		
		//db에 보내주세요.
		
		MemberDAO dao = new MemberDAO();
		
		 int result = dao.join(dto);
		 
		 if(result == 1) {
			 response.sendRedirect("./login");
			 //정상적으로 데이터입력을 완료했다면 로그인 페이지로
		 } else {
			 response.sendRedirect("./error");
			 //비정상이라면 에러로 보내주세요.
		 }
		
		
		
	}

}
