<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%  	
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	
	if(loginID==null||loginID.equals("")){                            			// id가 Null 이거나 없을 경우
		response.sendRedirect(Config.this_SERVER_path + "/Contents/index.jsp"); // 로그인 페이지로 리다이렉트 한다.
	}

	String sMenuTitle = request.getParameter("MenuTitle").toString();
	String sProgramId = request.getParameter("programId").toString();
	String sHeadmenuID= request.getParameter("HeadmenuID").toString();
	String sHeadmenuName= request.getParameter("HeadmenuName").toString();
	
	Get_Program_button_Autho prg_autho = new Get_Program_button_Autho(loginID,sProgramId);	
%>

 <script type="text/javascript">
	var checklist_id = "checklist22";
	var checklist_rev_no = "";
	var seq_no = "";
	var regist_date = "";
	var approve_date = "";
	var supply_item = "";
	var cust_nm = "";
	var cust_address = "";
	var cust_telno = "";
	var approve_reason = "";
	var person_write_id = "";
	var person_check_id = "";
	var person_approve_id = "";
 	
 	var startDate = "";
 	var endDAte = "";
 	
    $(document).ready(function () {
    	
    	var date = new SetRangeDate("dateParent", "dateRange", 30);
    	startDate = date.start.format('YYYY-MM-DD');
       	endDate = date.end.format('YYYY-MM-DD');
        
       	fn_MainInfo_List(startDate, endDate);
		
       	// 날짜 변경 시
		$('#dateRange').change(function() {
           	fn_MainInfo_List(startDate, endDate);
        });
		
		$("#InfoContentTitle").html("거래처 관리 목록");
		fn_MainSubMenuSelect("<%=sMenuTitle%>");
		fn_tagProcess();
	});

    function fn_tagProcess(){
    	var vSelect = <%=prg_autho.vSelect%>;
    	var vInsert = <%=prg_autho.vInsert%>;
    	var vUpdate = <%=prg_autho.vUpdate%>;
    	var vDelete = <%=prg_autho.vDelete%>;
    	
		if(vSelect == "0") {
	    	$('button[id="select"]').each(function () {
                $(this).prop("disabled",true);
            });
   		}
		if(vInsert == "0") {
	    	$('button[id="insert"]').each(function () {
                $(this).prop("disabled",true);
            });
   		}
		if(vUpdate == "0") {
	    	$('button[id="update"]').each(function () {
                $(this).prop("disabled",true);
                $(this).attr("onclick", " ");
            });
   		}
		if(vDelete == "0") {
	    	$('button[id="delete"]').each(function () {
                $(this).prop("disabled",true);
            });
   		}
    }
        
    // 메인 조회
    function fn_MainInfo_List(startDate, endDate) {
        $.ajax({
            type: "POST",
            url: "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S100100.jsp",
            data: "From=" + startDate + 
            	  "&To=" + endDate,
            success: function (html) {
                $("#MainInfo_List_contents").hide().html(html).fadeIn(100);
            }
        });
        
        $("#SubInfo_List_contents").children().remove(); 
    }
    
    // 상세 조회
    function fn_DetailInfo_List() {     
    	$.ajax({
   	    	type: "POST",
   	        url: "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S100110.jsp",
   	        data: "regist_date=" + regist_date +	
   	     		  "&checklist_id=" + checklist_id +
   	     		  "&checklist_rev_no=" + checklist_rev_no,
   	        success: function (html) {
   	            $("#SubInfo_List_contents").hide().html(html).fadeIn(100);       
   	        }
   	    });
	}
    
    // 점검표 조회
    function displayChecklist(element) {    	
    	
    	if(regist_date.length < 1){
    		heneSwal.warning('조회할 목록표를 선택하세요');
    		return false;
    	}
    	
    	let ajaxUrl = '<%=Config.this_SERVER_path%>/Contents/CheckList/getChecklistFormat.jsp';
    	
    	let jObj = new Object();
    	jObj.checklistId = checklist_id;
    	jObj.checklistRevNo = checklist_rev_no;
    	jObj.checklistDate = regist_date;	
		let ajaxParam = JSON.stringify(jObj);

    	$.ajax({
    		url: ajaxUrl,
    		data: {"ajaxParam" : ajaxParam},
    		success: function(rcvData) {
    			    			
    			const format = rcvData[0][0];	// 이미지 파일
    			const page = rcvData[0][1];		// jsp 페이지
    			
		    	const modalUrl = '<%=Config.this_SERVER_path%>' + page
		    				    + '?format=' + format
		    				    + '&regist_date=' + regist_date;
		    				   
				const footer = "<button type='button' class='btn btn-outline-primary'"
									 + "onclick='printChecklist()'>출력</button>";
				const title = element.innerText;
				const heneModal = new HenesysModal(modalUrl, 'auto', title, footer);
				heneModal.open_modal();
    		}
    	});
    }
	
    // 등록
    function haccpInsert(obj) {
    	var url = "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S100101.jsp"
    				+ '?checklist_id=' + checklist_id
    				+ '&checklist_rev_no=' + checklist_rev_no;
		var footer = '<button id="btn_Save" class="btn btn-info" onclick="SaveOderInfo();">저장</button>';
		var title = obj.innerText;
		var heneModal = new HenesysModal(url, 'standard', title, footer);
		heneModal.open_modal();
    }
    
    //수정
    function haccpUpdate(obj) {
    	
    	if(regist_date.length < 1){
    		heneSwal.warning('수정할 목록표를 선택하세요');
    		return false;
    	}
    	
    	var url = "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S020702.jsp"
			+ '?checklist_id=' + checklist_id
			+ '&checklist_rev_no=' + checklist_rev_no
			+ '&regist_date=' + regist_date
			+ '&waste_nm=' + waste_nm
			+ '&weight=' + weight
			+ '&content=' + content
			+ '&check_yn=' + check_yn;
    	
		var footer = '<button id="btn_Save" class="btn btn-info" onclick="SaveOderInfo();">저장</button>';
		var title = obj.innerText;
		var heneModal = new HenesysModal(url, 'standard', title, footer);
		heneModal.open_modal();
    }
    
    //삭제
    function haccpDelete(obj) {
    	
    	if(regist_date.length < 1){
    		heneSwal.warning('삭제할 목록표를 선택하세요');
    		return false;
    	} else{
    		SaveOderInfo();
    	}
    	
    	function SaveOderInfo() {
       	
   	        var dataJson = new Object();
   			
   			dataJson.checklist_id = checklist_id;
   			dataJson.checklist_rev_no = checklist_rev_no;
   			dataJson.regist_date = regist_date;
   			
   			var JSONparam = JSON.stringify(dataJson);
   			var chekrtn = confirm("삭제하시겠습니까?"); 
   			
   			if(chekrtn) {
   				SendTojsp(JSONparam, "M838S100100E103");
   			} else {
   				return false;
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
    					heneSwal.success('목록표 삭제가 완료되었습니다');

    					$('#modalReport').modal('hide');
    	        		parent.fn_MainInfo_List(startDate, endDate);
    	        		parent.$('#SubInfo_List_contents').hide();
    	         	} else {
    					heneSwal.error('목록표 삭제에 실패했습니다, 다시 시도해주세요');	         		
    	         	}
    	         }
    	     });
    	}
    }
    
    ///////////////////////////////// 상세 명단 
    //거래처 명단 등록
    function haccpPersonInsert(obj) {
    	
    	if(regist_date.length < 1){
    		heneSwal.warning('명단을 등록할 거래처 목록을 선택하세요');
    		return false;
    	}
    	
    	var url = "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S100111.jsp"
    				+ '?checklist_id=' + checklist_id 
    				+ '&checklist_rev_no=' + checklist_rev_no
    				+ '&regist_date=' + regist_date;
		var footer = '<button id="btn_Save" class="btn btn-info" onclick="SaveOderInfo();">저장</button>';
		var title = obj.innerText;
		var heneModal = new HenesysModal(url, 'standard', title, footer);
		heneModal.open_modal();
    }
    
  	//거래처 명단 수정
    function haccpPersonUpdate(obj) {
    	
    	if(seq_no.length < 1){
    		heneSwal.warning('수정할 거래처 명단을 선택하세요');
    		return false;
    	}
    	
    	var url = "<%=Config.this_SERVER_path%>/Contents/Business/M838/S838S100112.jsp"
    				+ '?checklist_id=' + checklist_id 
					+ '&checklist_rev_no=' + checklist_rev_no
					+ '&seq_no=' + seq_no
					+ '&regist_date=' + regist_date
					+ '&approve_date=' + approve_date
					+ '&supply_item=' + supply_item
					+ '&cust_nm=' + cust_nm
					+ '&cust_address=' + cust_address
					+ '&cust_telno=' + cust_telno
					+ '&approve_reason=' + approve_reason
					+ '&person_write_id=' + person_write_id
		   
		var footer = '<button id="btn_Save" class="btn btn-info" onclick="SaveOderInfo();">저장</button>';
		var title = obj.innerText;
		var heneModal = new HenesysModal(url, 'standard', title, footer);
		heneModal.open_modal();
    }
  	
  	//거래처 명단 삭제
  	function haccpPersonDelete(obj) {
    	
    	if(seq_no.length < 1){
    		heneSwal.warning('삭제할 거래처 명단을 선택하세요');
    		return false;
    	} else{
    		SaveOderInfo();
    	}
    	
    	function SaveOderInfo() {
        	
    	        var dataJson = new Object();
    			
    			dataJson.seq_no = seq_no;
    		
            	
    			var JSONparam = JSON.stringify(dataJson);
    			var chekrtn = confirm("삭제하시겠습니까?"); 
    			
    			if(chekrtn) {
    				SendTojsp(JSONparam, "M838S100100E113");
    			} else{
    			       return false;
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
    					heneSwal.success('거래처 명단 삭제가 완료되었습니다');

    					$('#modalReport').modal('hide');
    	        		parent.fn_DetailInfo_List();
    	         	} else {
    					heneSwal.error('거래처 명단 삭제에 실패했습니다, 다시 시도해주세요');	         		
    	         	}
    	         }
    	     });
    	}
    }
    
</script>
    
    <!-- Content Header (Page header) -->
	<div class="content-header">
  		<div class="container-fluid">
    		<div class="row mb-2">
	      		<div class="col-sm-6">
	        		<h1 class="m-0 text-dark" id="MenuTitle">거래처 관리 목록</h1>
	      		</div>
	      		<div class="col-sm-6">
	      			<div class="float-sm-right">
	      				<button type="button" onclick="haccpInsert(this)" 
	      				  		  id="insert" class="btn btn-outline-dark">
	      					목록표 등록
	      				</button>
	      				<!-- <button type="button" onclick="haccpUpdate(this)" 
	      				  		  id="update" class="btn btn-outline-success">
	      					기록표 수정
	      				</button> -->
	      				<button type="button" onclick="haccpDelete(this)" 
	      				  		  id="delete" class="btn btn-outline-danger">
	      					목록표 삭제
	      				</button>
	      				<button type="button" onclick="displayChecklist(this)" 
	      				  	 	class="btn btn-outline-dark">
	      					목록표 조회
	      				</button>
	      			</div>
	      		</div>
     		</div><!-- /.row -->
		</div><!-- /.container-fluid -->
	</div>
	<!-- /.content-header -->
    
    <!-- Main content -->
		<div class="content">
  			<div class="container-fluid">
    			<div class="row">
      				<div class="col-md-12">
        				<div class="card card-primary card-outline">
          			<div class="card-header">
          					<h3 class="card-title">
          						<i class="fas fa-edit" id="InfoContentTitle" ></i>
          					</h3>
          			<div class="card-tools">
          	  	<div class="input-group input-group-sm" id="dateParent">
          	  		<input type="text" class="form-control float-right" id="dateRange">
          	  	<div class="input-group-append">
          	  	  <button type="submit" class="btn btn-default">
          	  	    <i class="fas fa-search"></i>
          	  	  </button>
          	  	</div>
          	  </div>
          	</div>
          </div>
          <div class="card-body" id="MainInfo_List_contents"></div> 
        </div>
        <!-- 서브테이블   0325 서승헌 -->  
        <div class="card card-primary card-outline">
    	<div class="card-header">
    		<h3 class="card-title">
    			<i class="fas fa-edit">거래처 명단</i>
    		</h3>
    		<div class="card-tools">
				<button type="button" onclick="haccpPersonInsert(this)" 
						id="insert" class="btn btn-outline-dark">
					거래처 명단 등록
				</button>          	  
				<button type="button" onclick="haccpPersonUpdate(this)" 
						id="update" class="btn btn-outline-success">
					거래처 명단 수정
				</button>
				<button type="button" onclick="haccpPersonDelete(this)"
						id="delete" class="btn btn-outline-danger">
					거래처 명단 삭제
				</button>       	  
          	</div>
    	</div>
    	<div class="card-body">
    		<ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
	       		<li class="nav-item" onclick='fn_DetailInfo_List()'>
	       			<a class="nav-link" id="DetailInfo_List" data-toggle="pill" href="#SubInfo_List_contents" role="tab">상세정보</a>
	       		</li>
	        </ul>
	     	<div class="tab-content" id="custom-tabs-one-tabContent">
	     		<div class="tab-pane fade" id="SubInfo_List_contents" role="tabpanel"></div>
	     	</div>
	    </div>
    </div>
        
        
      </div>
      <!-- /.col-md-6 -->
      
    </div>
    <!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content -->

