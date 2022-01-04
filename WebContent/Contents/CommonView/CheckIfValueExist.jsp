<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.*"%>
<%
	String[] rTurnValue;
	DBServletLink dbServletLink = new DBServletLink();
	
	String GV_PID = "", GV_PARM = "";
	
	if(request.getParameter("pid") != null) {
		GV_PID = request.getParameter("pid");		
	}
	
	if(request.getParameter("prmtr") != null) {
		GV_PARM = request.getParameter("prmtr");
	}
	
	System.out.println( "1. GV_PARM === : " + GV_PARM);
	System.out.println( "2. GV_PID === : " + GV_PID);
	
	try{
		dbServletLink = new DBServletLink();
		dbServletLink.connectURL(GV_PID); // 쿼리메소드(PID) 연결
		
		// String형태의 JSON 데이터를 JSONObject 형태로 변환한다.
		JSONParser parser = new JSONParser();
		JSONObject jObject = (JSONObject)parser.parse(GV_PARM);
		
		// JSONObject 데이터를 쿼리메소드(PID)로 보낸다.
		rTurnValue = dbServletLink.queryProcessForjsp(jObject, false).split("\t");
		
		System.out.println("rTurnValue[0] 길이 => "+rTurnValue[0].trim());
		System.out.println("rTurnValue[1] 쿼리 => "+rTurnValue[1].trim());
		System.out.println("rTurnValue[2] 성공/실패 => "+rTurnValue[2].trim());
		System.out.println("rTurnValue[3] 컬럼수 => "+rTurnValue[3].trim());
		System.out.println("rTurnValue[4] 리턴값 => "+rTurnValue[4].trim());
		
		response.setContentType("text/html");
	    response.setHeader("Cache-Control", "no-store");
	    
	    response.getWriter().print(rTurnValue[4].trim());
	} catch(Exception e){
		System.out.println(e);
	}
%>