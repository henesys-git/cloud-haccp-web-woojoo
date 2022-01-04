﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.common.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" >
<%
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	
	// 로그인한 사용자의 정보
	JSONObject jArrayUser = new JSONObject();
	jArrayUser.put( "member_key", member_key);
	jArrayUser.put( "USER_ID", loginID);
	DoyosaeTableModel TableModelUser = new DoyosaeTableModel("M909S080100E107", jArrayUser);
	
	int RowCountUser =TableModelUser.getRowCount();
	String loginIDrev = "", loginIDjikwi = "", loginIDdept = "";
	
	if(RowCountUser > 0) {
		loginIDrev = TableModelUser.getValueAt(0, 1).toString().trim();
	} else {
		loginIDrev = "0";
	}
	
	String GV_CHECK_GUBUN="", GV_VHCL_NO="", GV_VHCL_NO_REV="", GV_VHCL_NM="", GV_CHECK_DATE="";
	
	if(request.getParameter("check_gubun")== null)
		GV_CHECK_GUBUN = "";
	else
		GV_CHECK_GUBUN = request.getParameter("check_gubun");
	
	if(request.getParameter("vhcl_no")== null)
		GV_VHCL_NO = "";
	else
		GV_VHCL_NO = request.getParameter("vhcl_no");
	
	if(request.getParameter("vhcl_no_rev")== null)
		GV_VHCL_NO_REV="";
	else
		GV_VHCL_NO_REV = request.getParameter("vhcl_no_rev");
	
	if(request.getParameter("vhcl_nm")== null)
		GV_VHCL_NM = "";
	else
		GV_VHCL_NM = request.getParameter("vhcl_nm");
	
	if(request.getParameter("check_date")== null)
		GV_CHECK_DATE = "";
	else
		GV_CHECK_DATE = request.getParameter("check_date");
	
	JSONObject jArray = new JSONObject();
	jArray.put( "member_key",	member_key);
	jArray.put( "check_gubun", 	GV_CHECK_GUBUN);
	jArray.put( "check_date", GV_CHECK_DATE);
	jArray.put( "vhcl_no", 		GV_VHCL_NO);
	jArray.put( "vhcl_no_rev", GV_VHCL_NO_REV);

	
	DoyosaeTableModel TableModel;
	TableModel = new DoyosaeTableModel("M838S060600E154", jArray);
	int RowCount =TableModel.getRowCount();

%>
 
<%-- <jsp:include page="../../Common/linkcss_js.jsp" flush="false"/> --%>
        
    <script type="text/javascript">
//     웹소켓 통신을 위해서 필요한 변수들 ---시작
	var SQL_Param = {
			PID: "M838S060600E103",
			excute: "queryProcess",
			stream: "N",
			param: + "|"
	};
//  웹소켓 통신을 위해서 필요한 변수들 ---끝	
	
	var vTableInoutCheck;
	var TableInoutCheck_info;
    var TableInoutCheck_RowCount;
	
	$(document).ready(function () {
		$("#txt_writor_main").val("<%=loginID%>"); // 로그인한 유저
		$("#txt_writor_main_rev").val("<%=loginIDrev%>"); // 로그인한 유저rev
		
		$("#txt_vhcl_no").val("<%=GV_VHCL_NO%>");
		$("#txt_vhcl_rev").val("<%=GV_VHCL_NO_REV%>");
		$("#txt_vhcl_nm").val("<%=GV_VHCL_NM%>");
		$("#txt_check_date").val("<%=GV_CHECK_DATE%>");
		
		vTableInoutCheck=$('#inout_check_table').DataTable({    
    		scrollX: true,
    		scrollY: 250,
//   	    scrollCollapse: true,
    	    paging: false,
    	    searching: false,
    	    ordering: false,
    	    order: [[ 0, "asc" ]],
    	    keys: false,
    	    info: true,
	  		columnDefs: [
	  			{
		       		'targets': [0],
		       		'createdCell':  function (td) {
		          			$(td).attr('style', 'width:80%;'); 
		       		}
				},
				{
		       		'targets': [1],
		       		'createdCell':  function (td) {
		          			$(td).attr('style', 'width:20%;'); 
		       		}
				}
			],
            language: { 
                url:"<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/localisation/Korean.json"
            }		    	  	
		});	
		
		TableInoutCheck_info = vTableInoutCheck.page.info();
		TableInoutCheck_RowCount = TableInoutCheck_info.recordsTotal;
	});
	
	function SaveOderInfo() {
		// check_date, check_time 체크 날짜 세팅
// 	    var today = new Date("2019-06-02"); // 특정날짜
	    var today = new Date(); // 오늘날짜
		var check_date 	= today.getFullYear() 
						+ "-" + ("0" + (today.getMonth() + 1)).slice(-2) 
						+ "-" + ("0" + today.getDate()).slice(-2) ;
		var check_time 	= ("0" + today.getHours()).slice(-2) 
						+ ":" + ("0" + today.getMinutes()).slice(-2) 
						+ ":" + ("0" + today.getSeconds()).slice(-2) ;
			
	    var jArray = new Array(); // JSON Array 선언
	    
	    TableInoutCheck_info = vTableInoutCheck.page.info();
		TableInoutCheck_RowCount = TableInoutCheck_info.recordsTotal;
	    
	    for(var i=0; i<TableInoutCheck_RowCount; i++){
			var trInput = $($("#inout_check_tbody tr")[i]).find(":input");
		
			// 결과값 세팅
			var result_value;
			if(trInput.eq(21).val()=='CHECK'){ // 결과값이 체크박스 형태일때
				if($("input[id='txt_check_value']").eq(i).prop("checked"))
					result_value ="Y";
				else
					result_value="N";
			} else { // 결과값이 텍스트박스 형태일때
				result_value = trInput.eq(23).val();
			}
			
			// JSON 파라미터 세팅
			var dataJson = new Object(); // jSON Object 선언 
			
			dataJson.vhcl_no 	 	= $("#txt_vhcl_no").val();
			dataJson.vhcl_no_rev 	= $("#txt_vhcl_no_rev").val();
			dataJson.check_duration =	trInput.eq(2).val();
			dataJson.check_date  	= $("#check_date").val();
			dataJson.driver 		= trInput.eq(4).val();
			dataJson.check_gubun 		= trInput.eq(5).val();
			dataJson.check_gubun_mid 	= trInput.eq(6).val();
			dataJson.check_gubun_sm 	= trInput.eq(7).val();
			dataJson.checklist_cd 	 	= trInput.eq(8).val();
			dataJson.cheklist_cd_rev 	= trInput.eq(9).val();
			dataJson.checklist_seq 	 	= trInput.eq(10).val();
			dataJson.item_cd 	 		= trInput.eq(11).val();
			dataJson.item_seq 	 		= trInput.eq(12).val();
			dataJson.item_cd_rev 		= trInput.eq(13).val();
			dataJson.standard_guide 	= trInput.eq(17).val();
			dataJson.standard_value 	= trInput.eq(18).val();
			dataJson.check_note 		= trInput.eq(19).val();
			dataJson.check_value 		= result_value;
			
			dataJson.incong_note  	 	= $("#txt_incong_note").val();
			dataJson.improve_note 		= $("#txt_improve_note").val();
			dataJson.improve_checker 	= $("#txt_improve_checker").val();
			dataJson.confirm_worker  	= $("#txt_confirm_worker").val();
			
			dataJson.writor  	 		= $("#txt_writor").val();
			dataJson.writor_rev 		= '0';
// 			dataJson.write_date 	 	= check_date;
// 			dataJson.reviewer  	 	 	= "";
// 			dataJson.review_date 	 	= check_date;
			dataJson.approval  	 	 	= "";
// 			dataJson.approval_date 	 	= check_date;
			dataJson.member_key 		= "<%=member_key%>";
			
			jArray.push(dataJson); // 데이터를 배열에 담는다.
	    }
	    
		  
	    var dataJsonMulti = new Object();
 		dataJsonMulti.param = jArray; // Array를 다시 Object형태로 변환 {"param":{Array...}}

		var JSONparam = JSON.stringify(dataJsonMulti); // JSON Object전송을 위해 문자열형태로 바꿔줌(stringify)
		
// 		console.log(JSONparam);
		var work_complete_insert_check = confirm("삭제하시겠습니까?");
		if(work_complete_insert_check == false)   return;

		
		SendTojsp(JSONparam, SQL_Param.PID); // SendToJSP를 통해 ajax로 데이터(JSONObject,PID) 보냄
	}
 
	function SendTojsp(bomdata, pid){
	    $.ajax({
	         type: "POST",
	         dataType: "json", // Ajax로 json타입으로 보낸다.
	         url: "<%=Config.this_SERVER_path%>/Contents/CommonView/insert_update_delete_json.jsp", 
	         data: {"bomdata" : bomdata, "pid" : pid },
	         beforeSend: function () {
//	         	 alert(bomdata);
	         },	         
	         success: function (html) {
	        	 if(html>-1){
	        		 opener.parent.fn_MainInfo_List();
		        	 window.close();
	         	}
	         },
	         error: function (xhr, option, error) {
	         }
	     });		
	}
	
    </script>
</head>
<body>
	<table class="table" style="width: 100%; margin: 0 auto; align:left">
		<tr>
           	<td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">차량번호</td>
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left" colspan="2">
				<input type="text" class="form-control" id="txt_vhcl_no" readonly />
				<input type="hidden" class="form-control" id="txt_vhcl_no_rev" />
				<input type="hidden" class="form-control" id="txt_writor" />
				<input type="hidden" class="form-control" id="txt_writor_rev" />
           	</td>
		</tr>
		<tr>
            <td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">점검일자</td>
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left">
				<input type="text" class="form-control" id="txt_check_date" value='<%=TableModel.getValueAt(0, 3).toString().trim()%>' readonly="readonly"/>
           	</td>
		</tr>
		<tr>
           	<td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">부적합 사항</td> 
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left" colspan="2">
				<input type="text" class="form-control" id="txt_incong_note" value='<%=TableModel.getValueAt(0, 22).toString().trim()%>' readonly="readonly" />
           	</td>
		</tr>
		<tr>
           	<td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">개선 조치 사항</td> 
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left" colspan="2">
				<input type="text" class="form-control" id="txt_improve_note" value='<%=TableModel.getValueAt(0, 23).toString().trim()%>' readonly="readonly"/>
           	</td>
		</tr>
		<tr>
           	<td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">개선조치확인란</td> 
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left" colspan="2">
				<input type="text" class="form-control" id="txt_improve_checker" value='<%=TableModel.getValueAt(0, 25).toString().trim()%>' readonly="readonly"/>
           	</td>
		</tr>
		<tr>
           	<td style="width: 150px; font-weight: 900; font-size:14px; vertical-align: middle ; text-align:left">확인</td>
            <td style="width: auto;  font-weight: 900; font-size:14px; vertical-align: middle ;text-align:left" colspan="2">
				<input type="text" class="form-control" id="txt_confirm_worker" value='<%=TableModel.getValueAt(0, 26).toString().trim()%>' readonly="readonly"/>
           	</td>
		</tr>
	</table>

   <table class="table" style="width: 100%; margin: 0 auto; align:left" id="inout_check_table">
		<thead>
        <tr style="vertical-align: middle">
            <th style="width: 80%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">점검항목</th>
            <th style="width: 20%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">결과</th>
        </tr>		    	
		</thead>
		<tbody id="inout_check_tbody">
	<%
			for (int i=0; i<RowCount; i++){  
				String GV_CHECK_NOTE = TableModel.getValueAt(i, 19).toString().trim();
			%>	 
        <tr style="background-color: #fff; height: 40px">
            <td>
            	<%=GV_CHECK_NOTE%>
            	<input type="hidden" id="vhcl_no" 		readonly value='<%=TableModel.getValueAt(i, 0).toString().trim()%>'></input>
            	<input type="hidden" id="vhcl_no_rev" 	readonly value='<%=TableModel.getValueAt(i, 1).toString().trim()%>'></input>
            	<input type="hidden" id="check_duration" readonly value='<%=TableModel.getValueAt(i, 2).toString().trim()%>'></input>
            	<input type="hidden" id="check_date" 	readonly value='<%=TableModel.getValueAt(i, 3).toString().trim()%>'></input>
            	<input type="hidden" id="driver" 		readonly value='<%=TableModel.getValueAt(i, 4).toString().trim()%>'></input>
            	<input type="hidden" id="check_gubun" 	readonly value='<%=TableModel.getValueAt(i, 5).toString().trim()%>'></input>
            	<input type="hidden" id="check_gubun_mid" readonly value='<%=TableModel.getValueAt(i, 6).toString().trim()%>'></input>
            	<input type="hidden" id="check_gubun_sm" readonly value='<%=TableModel.getValueAt(i, 7).toString().trim()%>'></input>
            	<input type="hidden" id="checklist_cd" 	readonly value='<%=TableModel.getValueAt(i, 8).toString().trim()%>'></input>
            	<input type="hidden" id="cheklist_cd_rev" readonly value='<%=TableModel.getValueAt(i, 9).toString().trim()%>'></input>
            	<input type="hidden" id="checklist_seq" readonly value='<%=TableModel.getValueAt(i, 10).toString().trim()%>'></input>
            	<input type="hidden" id="item_cd" 		readonly value='<%=TableModel.getValueAt(i, 11).toString().trim()%>'></input>
            	<input type="hidden" id="item_seq" 		readonly value='<%=TableModel.getValueAt(i, 12).toString().trim()%>'></input>
            	<input type="hidden" id="item_cd_rev" 	readonly value='<%=TableModel.getValueAt(i, 13).toString().trim()%>'></input>
            	<input type="hidden" id="item_type" 	readonly value='<%=TableModel.getValueAt(i, 14).toString().trim()%>'></input>
            	<input type="hidden" id="item_bigo" 	readonly value='<%=TableModel.getValueAt(i, 15).toString().trim()%>'></input>
            	<input type="hidden" id="item_desc" 	readonly value='<%=TableModel.getValueAt(i, 16).toString().trim()%>'></input>
            	<input type="hidden" id="standard_guide" readonly value='<%=TableModel.getValueAt(i, 17).toString().trim()%>'></input>
            	<input type="hidden" id="standard_value" readonly value='<%=TableModel.getValueAt(i, 18).toString().trim()%>'></input>
            	<input type="hidden" id="check_note" 	readonly value='<%=TableModel.getValueAt(i, 19).toString().trim()%>'></input>
            	<input type="hidden" id="check_value" 	readonly value='<%=TableModel.getValueAt(i, 20).toString().trim()%>'></input>
            	            	
            </td>
            <td >
            	<%if(TableModel.getValueAt(i,14).toString().trim().equals("text")){ %> 
				<input type="<%=TableModel.getValueAt(i,14).toString().trim()%>" class="form-control" id="txt_check_value"  
						style="width:100%; vertical-align:middle;"  value='<%=TableModel.getValueAt(i, 20).toString().trim()%>' readonly> 
				</input>
				<%} else if(TableModel.getValueAt(i,14).toString().trim().equals("checkbox")){ %>
					<%if(TableModel.getValueAt(i, 20).toString().trim().equals("Y")) {%>
					<input type="<%=TableModel.getValueAt(i,14).toString().trim()%>" class="" id="txt_check_value" value="CHECK" 
							style="width:30px; height:30px; vertical-align:middle;" checked>
							<%=TableModel.getValueAt(i, 18).toString().trim()%>
					</input>
					<%}else if(TableModel.getValueAt(i, 20).toString().trim().equals("N")){ %>
					<input type="<%=TableModel.getValueAt(i,14).toString().trim()%>" class="" id="txt_check_value" value="CHECK" 
							style="width:30px; height:30px; vertical-align:middle;" >
							<%=TableModel.getValueAt(i, 18).toString().trim()%>
					</input>
					<%} %>
				<%} %>
            </td>
        </tr>
	<%} %>
		</tbody>
    </table>
    <table class="table" style="width: 100%; margin: 0 auto; align:left">    
        <tr style="height: 50px">
            <td colspan="4" align="center">
                <p>
                	<button id="btn_Save"  class="btn btn-info" style="width: 100px" onclick="SaveOderInfo();">삭제</button>
                    <button id="btn_Canc"  class="btn btn-info" style="width: 100px" onclick="window.close();">취소</button>
                </p>
            </td>
        </tr>

    </table>
<!-- </form>     -->
</body>
</html>