package com.poseidon.util;

public class Util2 {
	//(파라미터로)String 값이 들어오면 int타입인지 확인해보는 메소드
	// ex) 127 -> true,  1A2A -> false
	public static boolean intCheck(String str) {
		boolean result = true;
		for (int i = 0; i < str.length(); i++) {
		      if (!Character.isDigit(str.charAt(i))) {
		        result = false;
		        break;
		      }
		    }
		    
		
		return result;
	}

}
