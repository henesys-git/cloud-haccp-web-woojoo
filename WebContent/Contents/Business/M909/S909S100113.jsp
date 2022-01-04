﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.common.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();

	DoyosaeTableModel TableModel;
	String zhtml = "";
    Vector optCode =  null;
    Vector optName =  null;
	Vector DocGubunVector = CommonData.getDocGubunCDAll(member_key);

	String[] strColumnHead = {
							  "parent_menu_id", "메뉴ID", 
							  "메뉴명", "메뉴레벨", 
							  "program_id", "정렬순서", 
							  "updatedate", "update_user", 
							  "삭제여부"
							 };
	
	String GV_PROGRAM_ID="", JOB_GUBUN="";

	if(request.getParameter("program_id")== null)
		GV_PROGRAM_ID="";
	else
		GV_PROGRAM_ID = request.getParameter("program_id");
	
	if(request.getParameter("job_gubun")== null)
		JOB_GUBUN = "";
	else
		JOB_GUBUN = request.getParameter("job_gubun");	
	
	String param = GV_PROGRAM_ID + "|";
	
	JSONObject jArray = new JSONObject();
	jArray.put("member_key", member_key);
	jArray.put("PROGRAM_ID", GV_PROGRAM_ID);
		
    TableModel = new DoyosaeTableModel("M909S100100E214", strColumnHead, jArray);
    int ColCount = TableModel.getColumnCount();
    CurrentPage jspPageName = new CurrentPage(request.getRequestURI());
    String JSPpage = jspPageName.GetJSP_FileName();
    Vector targetMenuVector = (Vector)(TableModel.getVector().get(0));
%>
 
<%-- <jsp:include page="../../Common/linkcss_js.jsp" flush="false" /> --%>
        
<script type="text/javascript">
	// 웹소켓 통신을 위해서 필요한 변수들 ---시작
	var M909S100100E113 = {
			PID: "M909S100100E113",
			totalcnt: 0,
			retnValue: 999,
			colcnt: 0,
			colname: ["", "", "", ""], //insert, Update, Delete 문장을 처리할 때는 사용되지않음
			data: []
	};  
	
	var SQL_Param = {
			PID: "M909S100100E113",
			excute: "queryProcess",
			stream: "N",
			param: + "|"
	};
	
	var GV_RECV_DATA = "";	//웹소켓 onMessage(event)들어온 데이터를 받는 변수
	// 웹소켓 통신을 위해서 필요한 변수들 ---끝	

    var docGubunCode = "";
    var JOB_GUBUN = "";
	
	function SetRecvData(){
		if (confirm("정말 삭제하시겠습니까?") != true) {
			return;
		}

		DataPars(M909S100100E113, GV_RECV_DATA);

		if(M909S100100E113.retnValue > 0) {
 			alert('삭제 되었습니다.');
		}
   		
   		parent.fn_DetailInfo_List();
 		parent.$('#modalReport').hide();
	}
	
	function SaveOderInfo() {
		
		var WebSockData="";
   		var dataJson = new Object();
   			dataJson.member_key = "<%=member_key%>";
			dataJson.MenuId = $('#txt_MenuId').val();
			dataJson.MenuName = $('#txt_MenuName').val();
			dataJson.MenuLevel = $('#txt_MenuLevel').val();
			dataJson.OrderIndex = $('#txt_OrderIndex').val();
			dataJson.DelYn = $('#txt_DelYn').val();
			dataJson.UpMenu = $('#txt_UpMenu').val();
			dataJson.ProgramId = $('#txt_ProgramId').val();
			dataJson.user_id = "<%=loginID%>";

			if (JOB_GUBUN == "open") {
				params += "|" + <%=JOB_GUBUN%> + "|";
			}

			SendTojsp(JSON.stringify(dataJson), SQL_Param.PID);
	}
 
	function SendTojsp(bomdata, pid){
	    $.ajax({
	         type: "POST",
	         dataType: "json",
	         url: "<%=Config.this_SERVER_path%>/Contents/CommonView/insert_update_delete_json.jsp", 
	         data: "bomdata=" + bomdata + "&pid=" + pid,
	         beforeSend: function () {
	         },	         
	         success: function (html) {
	         	if(html > -1) {
	        		alert('삭제 되었습니다.');
	        	 	parent.fn_DetailInfo_List();
	        	 	$('#modalReport').modal('hide');
	         	}
	         },
	         error: function (xhr, option, error) {
	         }
	     });
	}
    
    $(document).ready(function () {	    
	    JOB_GUBUN = "<%=JOB_GUBUN%>";
    });

    function fn_CommonPopupModal(sUrl, name, w, h) { // url, name, width, height, 기타 속성(생략해도 무방)     	
        var popupWin = window.showModalDialog(sUrl, name, 'dialogWidth:' + w + 'px; dialogHeight:' + h 
                + 'px; center:yes; help:no; status:no; resizable:no; scroll:yes; toolbar :no;');
    	if(typeof(popupWin) == "undefine")
    		popupWin = window.returnValue;
		return popupWin;
    }  
    
    function SetDocName_code(name, code){
		$('#txt_DocName').val(name);
		$('#txt_DocCode').val(code);
    }
    </script>

	<table class="table table-hover" style="width: 100%; margin: 0 auto; align:left">
    	<tr style="background-color: #fff; height: 40px">
            <td>메뉴ID</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_MenuId" style="width: 200px; float:left" 
            		value="<%=targetMenuVector.get(1).toString() %>" readonly />
           	</td>
        </tr>

        <tr style="background-color: #fff; height: 40px">
            <td style="font-weight:900;">메뉴명</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_MenuName" style="width: 200px; float:left"  
            		value="<%=targetMenuVector.get(2).toString() %>" readonly/>
           	</td>
        </tr>

        <tr>
        	<td style="font-weight:900;">프로그램ID</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_ProgramId" style="width: 200px; float:left" 
            		   value="<%=targetMenuVector.get(4).toString() %>" readonly />
           	</td>
        </tr>
        
        <tr style="background-color: #fff; height: 40px">
            <td style="font-weight:900;">메뉴레벨</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_MenuLevel" style="width: 200px; float:left" 
            		value="<%=targetMenuVector.get(3).toString() %>"  readonly/>
           	</td>
        </tr>

        <tr style="background-color: #fff; height: 40px">
            <td style="font-weight:900;">정렬순서</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_OrderIndex" style="width: 200px; float:left" 
            		value="<%=targetMenuVector.get(5).toString() %>"  readonly/>
           	</td>
        </tr>
        
        <tr style="background-color: #fff; height: 40px">
            <td style="font-weight:900;">삭제여부</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_DelYn" style="width: 200px; float:left" 
            		value="<%=targetMenuVector.get(8).toString() %>"  readonly/>
           	</td>
        </tr>
        
        <tr style="background-color: #fff; height: 40px">
            <td style="font-weight:900;">상위메뉴</td>
            <td></td>
            <td>
            	<input type="text" class="form-control" id="txt_UpMenu" style="width: 200px; float:left"  
            		value="<%=targetMenuVector.get(0).toString() %>" readonly/>
           	</td>
        </tr>

        <!-- <tr style="height: 60px">
            <td colspan="4" align="center">
                <p>
                	<button id="btn_Save" class="btn btn-info" style="width:100px" onclick="SaveOderInfo();">삭제</button>
                    <button id="btn_Canc" class="btn btn-info" style="width:100px" onclick="parent.$('#modalReport').hide();">취소</button>
                </p>
            </td>
        </tr> -->
	</table>