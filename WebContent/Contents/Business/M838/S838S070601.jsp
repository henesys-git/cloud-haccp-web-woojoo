﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.common.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%
/* 
S838S070601.jsp
개선조치기록부 등록
*/
	String loginID = session.getAttribute("login_id").toString();
	
	String checklist_id = "";
	
	if(request.getParameter("checklist_id") != null)
		checklist_id = request.getParameter("checklist_id");	

%>
<style>
.modal-body {
    padding-bottom: 0;
}

#unsuit_table tr td, #fileUpload tr td {
	vertical-align: middle;
	text-align: center;
}

.tooltip {
  position: relative;
  display: inline-block;
  opacity: 100;
  font-size: 16px;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 136%;
  background-color: black;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 11px;
  position: absolute;
  z-index: 1;
  bottom: 150%;
  left: 30%;
  margin-left: -60px;
}

.tooltip .tooltiptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: black transparent transparent transparent;
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}

.fa-mouse {
	color:lightgray;
}
</style>   
<script type="text/javascript">
    $(document).ready(function () {
    	
		new SetSingleDate2("", "#defect_date", 0);
		
    });	
	
    function serializeObject() { 
    	var obj = null; 
   	
		var arr = $("#unsuit_frm").serializeArray(); 
		
		if(arr){ 
			obj = {}; 
			jQuery.each(arr, function() { 
				obj[this.name] = this.value; 
			}); 
		}
		
    	return obj; 
    }

	function SaveOderInfo() {       
		
		var dataJson = new Object();
        
        var improve_action = "";
        
        $("textarea").each(function(idx) {
        	
        	if($(this).val() == "" || $(this).val() == null){
        		return true;
        	} else {
        		improve_action += (idx + 1) + ". " + $(this).val() + "//";
        	}
        	
        });

	 	var flag = true;
	 	
	 	$("#unsuit_frm input").each(function() {
	 		
			if($(this).val() == "" || $(this).val() == null){
				
				heneSwal.warning('빈 칸을 모두 입력해주세요.');
				$(this).focus();
			
				flag = false;
				
				return false;
			}
	 		
	 	});

	 	if(flag){
	 		
			dataJson.checklist_id = '<%=checklist_id%>';
		 	dataJson.improve_action = improve_action;
		 	dataJson.input = serializeObject();
		 	dataJson.attached_document = $("#attached_document").val();
		 	dataJson.person_write_id = '<%=loginID%>';
		 	
			var JSONparam = JSON.stringify(dataJson);
			var chekrtn = confirm("등록하시겠습니까?");
			
			if(chekrtn) {
				SendTojsp(JSONparam, "M838S070600E101");
			}
	 	}
	 	
	}

	function SendTojsp(bomdata, pid) {
	    $.ajax({
	        type: "POST",
	        dataType: "json",
	        url: "<%=Config.this_SERVER_path%>/Contents/CommonView/insert_update_delete_json.jsp", 
	        data:  {"bomdata" : bomdata, "pid" : pid},
			success: function (html) {	
				if(html > -1) {
	        		
					if($("#idFilename").val() == "" || $("#idFilename").val() == null){
						
						heneSwal.success('기록부 등록이 완료되었습니다');

    					$('#modalReport').modal('hide');
    	        		parent.fn_MainInfo_List(startDate, endDate);
    	        		parent.$('#SubInfo_List_contents').hide();
						
					} else {
						
		            	var form = $('#upload_form')[0];
		            	
						var data = new FormData(form);
		                
		                data.append("pid", 			$('#txt_pid').val());
		                data.append("user_id", 		$('#txt_user_id').val());
		                data.append("orderno", 		$('#txt_orderno').val());
		                data.append("order_detail", $('#txt_order_detail').val());
		                data.append("jspPage", 		$('#txt_jspPage').val());
		                data.append("getnum_prefix", "HACCP");
		                data.append("JobType", $('#txt_JobType').val());

		                data.append("regist_no", 	"");
		                data.append("docname", 		$('#txt_docname').val());
		                data.append("doccode", 		$('#txt_doccode').val());
		                data.append("rev_no", 		$('#txt_rev_no').val());
		                data.append("doc_gubun", 	$('#txt_doc_gubun').val());
		                
		                data.append("member_key", '107-86-81841'); 		// 관리본여부

		           	    $.ajax({
		        			type: "POST",
		        			async: true,
		           	        enctype: "multipart/form-data",
		           	        acceptcharset: "UTF-8",
		           	        url: "<%= request.getContextPath() %>/hcp_EdmsServerServlet", 
		           	        data: data,
		           	        processData: false,
		           	        contentType: false,
		        			cache: false,
		           	        timeout: 600000,
		           	        success: function (data) {
		        				if(data.length > 0) {

		        					heneSwal.success('기록부 등록이 완료되었습니다');

		        					$('#modalReport').modal('hide');
		        	        		parent.fn_MainInfo_List(startDate, endDate);
		        	        		parent.$('#SubInfo_List_contents').hide();
		        				} else {
		        					heneSwal.errorTimer("기록부 등록 실패했습니다, 다시 시도해주세요");
		        				}
		        			},
		           	        error: function (e) {
		        				$("#result").text(e.responseText);
		           	        }
		           	    });
		                
					}
					
	         	} else {
					heneSwal.error('기록부 등록 실패했습니다, 다시 시도해주세요');
	         	}
	         }
	     });
	}
</script>
<form id = "unsuit_frm" onsubmit="return false;">
	<table class="table" id="unsuit_table">
		<tr>
			<td style = "width: 23%;">
				부적합 사항 기록
			</td>
		    <td colspan = 2>
				<input type="text" name = "unsuit" class="form-control" id="unsuit" required="required" />
			</td>
		</tr>
	   	<tr>
	   		<td rowspan = 2>이탈사항</td>
	 		<td style = "width: 20%;">
				이탈일시
	  		</td>
	  		<td>
	  			<input type="text" data-date-format="yyyy-mm-dd" id="defect_date" name = "defect_date" class="form-control" required />
	  		</td>
	  	</tr>
	  	<tr>
	 		<td>
				이탈발생내용
	  		</td>
	  		<td>
	  			<input type="text" id="defect_detail" name = "defect_detail" class="form-control" required />
	  		</td>
	  	</tr>
	 	<tr>
	 		<td>
				이탈원인 <br> 조사 및 결과
	  		</td>
	  		<td colspan = 2>
	  			<input type="text" name = "defect_result" class="form-control" id="defect_result" required />
	  		</td>
	  	</tr>
	  	<tr>
			<td>
				<div class = "tooltip">
					개선조치사항 1&nbsp;&nbsp;<i class="fas fa-mouse"></i>
					<span class = "tooltiptext">
					공정을 관리상태로 되돌리기 위한 조치(원인확인 및 제거)
					</span>
				</div>
			</td>
		    <td colspan = 2>
				<textarea id="improve_action1" class="form-control"></textarea>
			</td>
		</tr>
	  	<tr>
			<td>
				<div class = "tooltip">
					개선조치사항 2&nbsp;&nbsp;<i class="fas fa-mouse"></i>
					<span class = "tooltiptext">
					원료육 또는 완제품에 대한 조치사항<br>(폐기/재사용/유통 등의 여부)
					</span>
				</div>
			</td>
		    <td colspan = 2>
				<textarea id="improve_action2" class="form-control" placeholder=""></textarea>
			</td>
		</tr>
	  	<tr>
			<td>
				<div class = "tooltip">
					개선조치사항 3&nbsp;&nbsp;<i class="fas fa-mouse"></i>
					<span class = "tooltiptext">
					재발방지 조치사항
					</span>
				</div>
			</td>
		    <td colspan = 2>
				<textarea id="improve_action3" class="form-control"></textarea>
			</td>
		</tr>
	  	<tr>
			<td>
				<div class = "tooltip">
					개선조치사항 4&nbsp;&nbsp;<i class="fas fa-mouse"></i>
					<span class = "tooltiptext">
					기타 개선조치 내용
					</span>
				</div>
			</td>
		    <td colspan = 2>
				<textarea id="improve_action4" class="form-control"></textarea>
			</td>
		</tr>
	  	<tr>
			<td>
				개선조치 담당자
			</td>
		    <td colspan = 2>
				<input type="text" id="person_improve_id" name = "person_improve_id" class="form-control" placeholder="개선조치 담당자 성명" required />
			</td>
		</tr>
		<tr>
			<td rowspan = 2>
				검증자
			</td>
			<td>
				검증결과
			</td>
		    <td>
				<input type="text" id="verify_result" name = "verify_result" class="form-control" required />
			</td>
		</tr>
		<tr>
			<td>
				검증 담당자
			</td>
		    <td>
				<input type="text" id="person_verify_id" name = "person_verify_id" class="form-control" placeholder="검증 담당자 성명" required />
			</td>
		</tr>
	</table>
</form>
<table class="table" id = "fileUpload">
	<tr>
		<td style = "width: 23%;">
			첨부자료
		</td>    
	    <td>
			<input type="hidden" class="form-control" id="txt_pid" name="pid"  value="M838S070600E111"> 
			<input type="hidden" class="form-control" id="txt_user_id" name="user_id"  value="henesys"> 
			<input type="hidden" class="form-control" id="txt_orderno" name="orderno" value="0" > 
			<input type="hidden" class="form-control" id="txt_order_detail" name="order_detail" value="1" > 
			<input type="hidden" class="form-control" id="txt_jspPage" name="jspPage"  value="M838S070601.jsp"> 
			<input type="hidden" class="form-control" id="txt_getnum_prefix" name="getnum_prefix"  value="HACCP"> 
			<input type="hidden" class="form-control" id="txt_JobType" name="JobType" value="INSERT" > 
			<input type="hidden" class="form-control" id="txt_doccode" name="doccode" value = "M838S070600" > 
			<input type="hidden" class="form-control" id="txt_rev_no" name="rev_no" > 
			<input type="hidden" class="form-control" id="txt_doc_gubun" name="doc_gubun" > 
	    <!-- ///////////////////////////////////////////////////////////////////////////////////  -->
			<input type="hidden" id="attached_document" class="form-control">
			<form id="upload_form" enctype="multipart/form-data" action="/hcp_EdmsServerServlet" method="post">
				<input type="file" id="idFilename" name="filenames" multiple="multiple" class="form-control" style = "height: 0%;">
			</form>
		</td>
	</tr>
</table>