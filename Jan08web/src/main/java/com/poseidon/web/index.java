package com.poseidon.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.poseidon.dao.LogDAO;
import com.poseidon.util.Util;

@WebServlet("/index")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public index() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.sendRedirect("index.jsp");
		
		LogDAO log = new LogDAO();
		log.logWrite(Util.getIP(request), "./index", null);
		
		
		
		
		List<Map<String, String>> map = new ArrayList<Map<String,String>>();
		
		//요소 만들기
		Map<String, String> e = new HashMap<String, String>();
		e.put("name", "홍길동");		
		e.put("age", "120");		
		e.put("addr", "한양");		
		
		map.add(e); //0
		e = new HashMap<String, String>(); //이 줄이 추가되어야 0번지 홍길동 위에 덮어쓰지 않음. 다른 인스턴스가 되는 거심
		e.put("name", "김길동");		
		e.put("age", "12");		
		e.put("addr", "서울");		
		map.add(e); //1
		//jsp로 보내기
		request.setAttribute("map", map); //"map"은 꺼내올 이름
		//request.setAttribute("map", map.get(0).get("name")); //이렇게 쓰면 홍길동이 출력됨
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
