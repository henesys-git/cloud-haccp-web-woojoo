<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%  	
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	if(loginID==null||loginID.equals("")){                            // id가 Null 이거나 없을 경우
		response.sendRedirect(Config.this_SERVER_path + "/Contents/index.jsp");    // 로그인 페이지로 리다이렉트 한다.
	}
// 	makeMenu MainMenu = new makeMenu(loginID);

	String sMenuTitle = request.getParameter("MenuTitle").toString();
	String sProgramId = request.getParameter("programId").toString();
	String sHeadmenuID= request.getParameter("HeadmenuID").toString();
	String sHeadmenuName= request.getParameter("HeadmenuName").toString();
// 	String htmlsideMenu = MainMenu.GetsideMenu(sHeadmenuID,sHeadmenuName);
	
	Get_Program_button_Autho prg_autho = new Get_Program_button_Autho(loginID,sProgramId);
	
	CurrentPage jspPageName = new CurrentPage(request.getRequestURI());
	String JSPpage = jspPageName.GetJSP_FileName();
	ProcesStatusCheck prcStatusCheck = new ProcesStatusCheck(JSPpage+"|"+"NON"+"|");
	
	
	String GV_PROCESS_MODIFY	= prcStatusCheck.GV_PROCESS_MODIFY;
	String GV_PROCESS_DELETE	= prcStatusCheck.GV_PROCESS_DELETE;
	String GV_GET_NUM_PREFIX	= prcStatusCheck.GV_PROCESS_NUMBER_GUBUN;

	JSONObject jArray = new JSONObject();
	jArray.put("member_key", member_key);
	
	DBServletLink dbServletLink = new DBServletLink();
	dbServletLink.connectURL("M909S170100E994");
	
	Vector Code_Cd_Vector = dbServletLink.doQuery(jArray, false);
	String Code_Cd_Str = ((Vector)Code_Cd_Vector.get(0)).get(0).toString();
	System.out.println("Code_Cd_Str : " + Code_Cd_Str);
%>

 <script type="text/javascript">
 	var vMemberKey = "<%=member_key%>";
 	var vCodeCd = "<%=Code_Cd_Str%>";
 	var vCensorNo = "";
 	var vCCPNo = "";

    $(document).ready(function () {
		fn_MainSubMenuSelect("<%=sMenuTitle%>");
		$("#InfoContentTitle").html("CCP정보목록");

    	fn_MainInfo_List();
	    fn_tagProcess('<%=JSPpage%>');
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

    function fn_LoadSubPage() {
        fn_clearList();
        fn_MainInfo_List();
    }

    function fn_clearList() {
        if ($("#Main_contents").children().length > 0) {
            $("#Main_contents").children().remove();
        }
    }
        
    //CCP정보정보
    function fn_MainInfo_List() {
    	console.log("CCP정보관리");
        $.ajax(
        {
            type: "POST",
            url: "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S160100.jsp",
	        data: "member_key=" + vMemberKey,
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


    function pop_fn_CCPInfo_Insert(obj) {
    	var modalContentUrl;
    	
    	console.log(obj.innerText);

    	modalContentUrl = "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S160101.jsp"
    					+ "?member_key="	+ "<%=member_key%>"
    					+ "&code_cd="		+ vCodeCd;
    					/* + "&censor_no="		+ vCensorNo; */

    	var footer = "";
     	var title  = obj.innerText;
     	var heneModal = new HenesysModal(modalContentUrl, 'large', title+"(S909S160101)", footer);
     	heneModal.open_modal();
     }

    function pop_fn_CCPInfo_Update(obj) {
		if(vCensorNo.length < 1){
			heneSwal.warning(obj.innerText +" <%=JSPpage%> !! CCP 정보를 선택하세요!!");
 			return false;
		}

    	var modalContentUrl;
    	
    	console.log(obj.innerText);

    	modalContentUrl = "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S160102.jsp"
						+ "?member_key="	+ vMemberKey				
    					+ "&code_cd="		+ vCodeCd
						+ "&censor_no="		+ vCensorNo
						+ "&ccp_no="		+ vCCPNo;
    	
    	var footer = "";
     	var title  = obj.innerText;
     	var heneModal = new HenesysModal(modalContentUrl, 'large', title+"(S909S160102)", footer);
     	heneModal.open_modal();
    }

    function pop_fn_CCPInfo_Delete(obj) {
    	if(vCensorNo.length < 1){
    		heneSwal.warning(obj.innerText +" <%=JSPpage%> !! CCP 정보를 선택하세요!!");
 			return false;
		}

    	var modalContentUrl;
    	
    	console.log(obj.innerText);
    	
    	modalContentUrl = "<%=Config.this_SERVER_path%>/Contents/Business/M909/S909S160103.jsp"
    					+ "?member_key="	+ vMemberKey				
						+ "&code_cd="		+ vCodeCd
						+ "&censor_no="		+ vCensorNo
						+ "&ccp_no="		+ vCCPNo;
    	
    	var footer = "";
     	var title  = obj.innerText;
     	var heneModal = new HenesysModal(modalContentUrl, 'large', title+"(S909S160103)", footer);
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
      	  <button type="button" onclick="pop_fn_CCPInfo_Insert(this)" id="insert" class="btn btn-outline-dark">CCP정보 등록</button>
      	  <button type="button" onclick="pop_fn_CCPInfo_Update(this)" id="update" class="btn btn-outline-success">CCP정보 수정</button>
      	  <button type="button" onclick="pop_fn_CCPInfo_Delete(this)" id="delete" class="btn btn-outline-danger">CCP정보 삭제</button>
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
  </div> <!-- /.container-fluid -->
</div> <!-- /.content -->