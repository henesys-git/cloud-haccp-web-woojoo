<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.common.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%  	

	DoyosaeTableModel TableModel;
	String member_key = session.getAttribute("member_key").toString();

	String GV_VHCL_NO3 = "", GV_VHCL_NO_REV3 = "", GV_DRIVER3 = "", GV_SERVICE_DATE3 = "";
	
	if( request.getParameter("vhcl_no") == null )
		GV_VHCL_NO3 = "";
	else
		GV_VHCL_NO3 = request.getParameter("vhcl_no");
	
	if( request.getParameter("vhcl_no_rev") == null )
		GV_VHCL_NO_REV3 = "";
	else
		GV_VHCL_NO_REV3 = request.getParameter("vhcl_no_rev");
	
	/* if( request.getParameter("driver") == null )
		GV_DRIVER3 = "";
	else
		GV_DRIVER3 = request.getParameter("driver"); */
	
	if( request.getParameter("service_date") == null )
		GV_SERVICE_DATE3 = "";
	else
		GV_SERVICE_DATE3 = request.getParameter("service_date");
	
	JSONObject jArray = new JSONObject();
	jArray.put( "vhcl_no", GV_VHCL_NO3);
	jArray.put( "vhcl_no_rev", GV_VHCL_NO_REV3);
	// jArray.put( "driver", GV_DRIVER3);
	jArray.put( "service_date", GV_SERVICE_DATE3);
	jArray.put( "member_key", member_key);
	
	
	DBServletLink dbServletLink = new DBServletLink();
    dbServletLink.connectURL("M838S060500E164");
    
    Vector Check_Result_Vector = dbServletLink.doQuery(jArray, false);
	
    StringBuffer result = new StringBuffer();
    
    if( Check_Result_Vector.size() == 0 )
    {
    	result.append("N");
		//result.append("|");
    }
    else
    {
    	for( int i = 0 ; i < Check_Result_Vector.size() ; i++ )
    	{
    		result.append(((Vector)Check_Result_Vector.get(i)).get(0).toString());
    		
    		if( i != Check_Result_Vector.size() - 1 )
				result.append("|");
    	}
    }
    
	response.setContentType("text/html");
	response.setHeader("Cache-Control", "no-store");
	response.getWriter().print(result.toString());
%>