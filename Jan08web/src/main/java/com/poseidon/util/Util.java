package com.poseidon.util;

import javax.servlet.http.HttpServletRequest;

public class Util {
	// (파라미터로)String 값이 들어오면 int타입인지 확인해보는 메소드
	// ex) 127 -> true, 1A2A -> false

	public static int str2Int(String str) {
		// A59 -> 59, 5A9 -> 59 무조건 숫자로 반환하는 코드 작성하기
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < str.length(); i++) {
			if (Character.isDigit(str.charAt(i))) {
				sb.append(str.charAt(i));
			}
		}
		// return Integer.parseInt(sb.toString());
		int number = 0;
		if (sb.length() > 0) {
			number = Integer.parseInt(sb.toString());
		}
		// System.out.println("변환된 숫자 "+number);
		return number;
	}

	public static int str2Int2(String str) {
		// A59 -> 59, 5A9 -> 59 무조건 숫자로 반환하는 코드 작성하기
		String numberOnly = str.replaceAll("[^0-9]", "");
		return Integer.parseInt(numberOnly);
	}

	public static boolean intCheck(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public static boolean intCheck2(String str) {
		boolean result = true;
		for (int i = 0; i < str.length(); i++) {
			if (!Character.isDigit(str.charAt(i))) {
				result = false;
				break;
			}
		}

		return result;
	}

	// ip가져오기
	// IP얻어오기
	public static String getIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	//HTML태그를 특수기호로 변경하기    < &lt  > &gt
	   public static String removeTag(String str) {
	      str = str.replaceAll("<", "&lt");
	      str = str.replaceAll(">", "&gt");
	      return str;
	   }
	   
	   //줄바꿈 처리~ 댓글에서 enter키 사용할 수 있도
	   public static String addBR(String str) {
		      return str.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		   }
	   
	   //아이피 중간을 ☆로 가리기  172.30.1.27 → 172.☆.1.27
	   
	   public static String ipMasking(String ip) {
		   if(ip.indexOf('.') != -1) {
			   StringBuffer sb = new StringBuffer(); //멀티스레드 환경에서도 동기화 지원..??
			   sb.append(ip.substring(0, ip.indexOf('.')+1));
			   sb.append("☆");
			   sb.append(ip.substring(ip.indexOf('.', ip.indexOf('.')+1)));
			   return sb.toString();
		   } else {
			   return ip;
		   }
		   
	   }
	   
	   
	   
}
