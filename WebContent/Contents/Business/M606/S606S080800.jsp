<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%
// 	DoyosaeTableModel TableModel;
	EdmsDoyosaeTableModel TableModel;
	MakeTableHTML makeTableHTML;
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	String zhtml = "";
	
	int startPageNo = 1;
	//	final int PageSize=15; 
	String[] strColumnHead 	= {"내외부구분","문서코드", "문서명", "문서구분코드", "문서구분", "파일명","등록번호","변경번호", "실파일명"  ,"외부문서", "등록사유", "파기사유","총페이지", "관리본여부","보관여부","보존여부","등록일자", "등록자","document_no_rev"} ;	
	int[]   colOff 			= {0, 0         , 9      , 0              , 8         , 8       , 5        , 5        , 0           , 0        , 5         , 0         , 5        , 5           , 0        , 0        , 11        , 5,0};//전체 넓이 번튼 3개:86%, 문서2개:90%, 문서뷰:94%, 챠트보기,문서등록91%;
	
	String[] TR_Style		= {""," onclick='S606S080100Event(this)' "};
	String[] TD_Style		= {"align:center;font-weight: bold;"};  //strColumnHead의 수만큼 
	String[] HyperLink		= {""}; //strColumnHead의 수만큼
	String RightButton[][]	= {{"off", "fn_Chart_View", rightbtnChartShow},{"off", "file_view_name", rightbtnDocRevise},{"on", "file_real_name", rightbtnDocShow}};
	
	String GV_DOCGUBUN="";
	
	if(request.getParameter("DocGubun")== null) 
		GV_DOCGUBUN="";
	else
		GV_DOCGUBUN = request.getParameter("DocGubun");
	
	
	String param = GV_DOCGUBUN + "|" + member_key + "|";
	TableModel = new EdmsDoyosaeTableModel("M606S080100E104", strColumnHead, param);	
 	int RowCount =TableModel.getRowCount();	

 	CurrentPage jspPageName = new CurrentPage(request.getRequestURI());
 	String JSPpage = jspPageName.GetJSP_FileName();
 	
    makeTableHTML= new MakeTableHTML(TableModel);
    makeTableHTML.colCount		= strColumnHead.length;
    makeTableHTML.pageSize 		= RowCount;
    makeTableHTML.currentPageNum= startPageNo;
    makeTableHTML.htmlTable_ID	= "TableS606S080100";
    makeTableHTML.colOff		= colOff;
    makeTableHTML.TR_Style 		= TR_Style;
    makeTableHTML.TD_Style 		= TD_Style; 
    makeTableHTML.HyperLink 	= HyperLink;makeTableHTML.user_id	= loginID;
    makeTableHTML.Check_Box 	= "false";
    makeTableHTML.RightButton	= RightButton; makeTableHTML.jsp_page	= JSPpage;
    zhtml = makeTableHTML.getHTML();
    
//     int ColCount =TableModel.getColumnCount()+1;
//     out.println(zhtml);
%>
<script>
    $(document).ready(function () {
    	
    	$('#<%=makeTableHTML.htmlTable_ID%>').DataTable({	    	    
    		scrollX: true,
    		//scrollY: 300,
    	    scrollCollapse: true,
    	    paging: true,
    	    searching: false,
    	    ordering: true,
    	    order: [[ 5, "desc" ]],
    	    info: true,
    	    "dom": '<"top"i>rt<"bottom"flp><"clear">',
            language: { 
                url:"<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/localisation/Korean.json"
             }
		});
    	
    });
    
    function fn_right_btn_view(fileName, obj,view_revision){
    	/* 
    	{"on", "file_view_name", "문서View"} 인경우 이 함수를 반드시 사용한다.
    	 */
    	var tr = $(obj).parent().parent();
		var td = tr.children();

// 		{"내외부구분","문서코드", "문서명", "문서구분코드", "문서구분", "파일명","등록번호","변경번호", "실파일명"  ,"외부문서", "등록사유", "파기사유","총페이지", "관리본여부","보관여부","보존여부","등록일자", "등록자","document_no_rev"} ;		
		var regist_no 		= td.eq(6).text().trim();
		var regist_no_rev 	= td.eq(7).text().trim();
		var document_no 	= td.eq(1).text().trim();
		var document_no_rev 	= td.eq(18).text().trim();
		var JSPpage			= '<%=JSPpage%>';
		var loginID			= '<%=loginID%>';

		fn_pdf_View(regist_no, regist_no_rev, document_no, document_no_rev,fileName, JSPpage, loginID,view_revision);
    }
    
	function S606S080100Event(obj){
		var tr = $(obj);
		var td = tr.children();

		var trNum = $(obj).closest('tr').prevAll().length;//현재 클릭한 TR의 순서 return .bg-success

		$($("input[id='checkbox1']")[trNum]).prop("checked", function(){
	        return !$(this).prop('checked');
	    });

	
		$(<%=makeTableHTML.htmlTable_ID%>_rowID).attr("class", "");
		$(obj).attr("class", "hene-bg-color");
		
	}
	    
</script>

<%=zhtml%>
<div id="UserList_pager" class="text-center">
</div>