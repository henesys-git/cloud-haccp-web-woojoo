<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%  	
/* 
수입검사체크리스트(M909S124100.jsp)
 */
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	if(loginID==null||loginID.equals("")){                            // id가 Null 이거나 없을 경우
		response.sendRedirect(Config.this_SERVER_path + "/Contents/index.jsp");    // 로그인 페이지로 리다이렉트 한다.
	}

	String sMenuTitle = request.getParameter("MenuTitle").toString();
	String sProgramId = request.getParameter("programId").toString();
	String sHeadmenuID= request.getParameter("HeadmenuID").toString();
	String sHeadmenuName= request.getParameter("HeadmenuName").toString();	
	
	Get_Program_button_Autho prg_autho = new Get_Program_button_Autho(loginID,sProgramId);	
	
	CurrentPage jspPageName = new CurrentPage(request.getRequestURI());
	String JSPpage = jspPageName.GetJSP_FileName();
	ProcesStatusCheck prcStatusCheck = new ProcesStatusCheck(JSPpage+"|"+"NON"+"|");
	
	String GV_PROCESS_MODIFY	= prcStatusCheck.GV_PROCESS_MODIFY;
	String GV_PROCESS_DELETE	= prcStatusCheck.GV_PROCESS_DELETE;
	String GV_GET_NUM_PREFIX	= prcStatusCheck.GV_PROCESS_NUMBER_GUBUN;
%>

 <script type="text/javascript">
	var vPart_cd = ""; 
	var vPart_cd_rev;
	var vPart_name;
	var vChecklist_cd = "";
	var menuName;
	var FLAG	= false;

    $(document).ready(function () {
        fn_MainSubMenuSelect("<%=sMenuTitle%>");
		$("#InfoContentTitle").html("원부자재정보");

    	fn_MainInfo_List();
    	
	    fn_tagProcess('<%=JSPpage%>');
	    
	    $("#total_rev_check").change(function(){
			FLAG = !FLAG;
	    	
	    	if( FLAG )
	    	{
	    		alert("등록 / 삭제 기능이 제한됩니다.");
	    		
	    		$("#insert").prop("disabled",true);
	    		$("#delete").prop("disabled",true);
	    	}
	    	else
	    	{
	    		$("#insert").prop("disabled",false);
	    		$("#delete").prop("disabled",false);
	    	}
	    	
	    	fn_MainInfo_List();
	    });
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

    function fn_clearList() {
        if ($("#Main_contents").children().length > 0) {
            $("#Main_contents").children().remove();
        }
        if ($("#Main_contents2").children().length > 0) {
            $("#Main_contents2").children().remove();
        }
    }
        
    //원부자재정보
    function fn_MainInfo_List() {
    	var revCheck = $("#total_rev_check").is(":checked"); 
    	
        $.ajax(
        {
            type: "POST",
            url: "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S124100.jsp",
            data: "total_rev_check=" + revCheck,
            beforeSend: function () {
                $("#Main_contents").children().remove();
            },
            success: function (html) {
                $("#Main_contents").hide().html(html).fadeIn(100);
            },
            error: function (xhr, option, error) {

            }
        });
    }

	function fn_DetailInfo_List() { //원부자재검사 체크리스트 목록
    	$.ajax(
    	    {
    	        type: "POST",
    	        url: "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S124110.jsp",
    	        data: "part_cd=" + vPart_cd + "&part_cd_rev=" + vPart_cd_rev,
    	        success: function (html) {
    	            $("#SubInfo_List_contents").hide().html(html).fadeIn(100);
    	        }
    	    });
		return;
	}   

    function pop_fn_import_ins_checklist_Insert(obj) {
    	if(vPart_cd.length < 1){
    		heneSwal.warning("원부자재를 선택하세요");
 			return false;
    	}
    	var modalContentUrl;
    	modalContentUrl = "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S124101.jsp?part_cd=" + vPart_cd + "&part_cd_rev=" + vPart_cd_rev + "&part_name=" + vPart_name;
    	
    	var footer = '<button id="btn_Save"  class="btn btn-info" style="width: 100px" onclick="SaveOderInfo();">저장</button>';
     	var title  = obj.innerText;
     	var heneModal = new HenesysModal(modalContentUrl, 'large', title, footer);
     	heneModal.open_modal();     
     }


    function pop_fn_import_ins_checklist_Delete(obj) {
    	if(vChecklist_cd == undefined || vChecklist_cd.length < 1){
    		heneSwal.warning("삭제할 체크리스트를 선택하세요");
 			return false;
    	}
    	
    	var modalContentUrl;
    	
    	modalContentUrl = "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S124103.jsp"
    						+ "?part_cd=" + vPart_cd + "&checklist_cd=" + vChecklist_cd
    						+ "&part_nm=" + vPart_name + "&check_note=" + vCheck_note 
    						+ "&checklist_seq=" + vChecklist_seq + "&standard_guide=" + vStandard_guide 
    						+ "&standard_value=" + vStandard_value + "&item_desc=" + vItem_desc 
    						+ "&item_type=" + vItem_type + "&item_bigo=" + vItem_bigo;
    	
 		var footer = '<button id="btn_Save"  class="btn btn-info" style="width: 100px" onclick="SaveOderInfo();">삭제</button>';
		var title  = obj.innerText;
		var heneModal = new HenesysModal(modalContentUrl, 'large', title, footer);
		heneModal.open_modal();
    	}

    </script>
    
    <!-- Content Header (Page header) -->
	<div class="content-header">
  		<div class="container-fluid">
    		<div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0 text-dark" id="MenuTitle">여기에 메뉴 타이틀</h1>
      </div>
      <div class="col-sm-6">
      	<div class="float-sm-right">
      	  <button type="button" onclick="pop_fn_import_ins_checklist_Insert(this)" id="insert" class="btn btn-outline-dark">수입검사체크리스트 등록</button>
      	  <button type="button" onclick="pop_fn_import_ins_checklist_Delete(this)" id="delete" class="btn btn-outline-danger">수입검사체크리스트 삭제</button>
			
		<label style="width: auto; clear:both; margin-left:30px;">
	     Rev. No 전체보기
	    <input type="checkbox" id="total_rev_check"  />
	    </label>      	
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
          				<i class="fas fa-edit" id="InfoContentTitle"></i>
          					</h3>
          			 
          		</div>
          <div class="card-body" id="Main_contents"></div> 
        </div>
      </div> <!-- /.col-md-6 -->
    </div> <!-- /.row -->
    		 <div class="card card-primary card-outline">
    	<div class="card-header">
    		<h3 class="card-title">
    			<i class="fas fa-edit">세부 정보</i>
    		</h3>
    	</div>
    	<div class="card-body">
    		<ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
	       		<li class="nav-item" onclick='fn_DetailInfo_List()'>
	       			<a class="nav-link" id="DetailInfo_List" data-toggle="pill" href="#SubInfo_List_contents" role="tab">수입검사체크리스트목록</a>
	       		</li>
	        </ul>
	     	<div class="tab-content" id="custom-tabs-one-tabContent">
	     		<div class="tab-pane fade" id="SubInfo_List_contents" role="tabpanel"></div>
	     		
	        </div>
        </div>
    </div>
  		</div> <!-- /.container-fluid -->
	</div> <!-- /.content -->