<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%
	DoyosaeTableModel TableModel;
	MakeTableHTML makeTableHTML; 
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	String[] strColumnHead 	= {"주문번호","발주번호", "번호", "품명",  "자료번호", "원부자재번호",  "파트코드","규격", "수량", "단가","금액","Rev","part_cd_rev"};
	int[]   colOff 			= { 0,  0, 10, 12, 0, 0,0,1,1,1,1,1,0};//전체 넓이 번튼 3개:86%, 문서2개:90%, 문서뷰:94%, 챠트보기,문서등록91%; 고객사

	String[] TR_Style		= {"",""};
// 	String[] TR_Style		= {""," onclick='S202S010240Event(this)' "};
	String[] TD_Style		= {"align:center;font-weight: bold;"}; 
	String[] HyperLink		= {""}; 
	String RightButton[][]	= {{"off", "fn_Chart_View", rightbtnChartShow},{"off", "fn_Doc_Reg()", rightbtnDocSave},{"off", "fn_mius_body(this)", "삭제"}};

	String GV_ORDERNO="", GV_ORDER_DETAIL_SEQ="", GV_JSPPAGE="", GV_NUM_GUBUN="", GV_BALJUNO="";
	
	if(request.getParameter("order_no")== null)
		GV_ORDERNO = "";
	else
		GV_ORDERNO = request.getParameter("order_no");	
	
	if(request.getParameter("order_detail_seq")== null)
		GV_ORDER_DETAIL_SEQ="";
	else
		GV_ORDER_DETAIL_SEQ = request.getParameter("order_detail_seq");
	
	if(request.getParameter("balju_no")== null)
		GV_BALJUNO = "";
	else
		GV_BALJUNO = request.getParameter("balju_no");

	String param = GV_ORDERNO + "|" + GV_BALJUNO + "|";
	
	JSONObject jArray = new JSONObject();
	jArray.put( "order_no", GV_ORDERNO);
	jArray.put( "baljuno", GV_BALJUNO);
	jArray.put( "member_key", member_key);	
//     TableModel = new DoyosaeTableModel("M202S010100E244", strColumnHead, param);	
    TableModel = new DoyosaeTableModel("M202S010100E244", strColumnHead, jArray);
 	int RowCount =TableModel.getRowCount();	

 	CurrentPage jspPageName = new CurrentPage(request.getRequestURI());
 	String JSPpage = jspPageName.GetJSP_FileName();
 	
    makeTableHTML= new MakeTableHTML(TableModel);
    makeTableHTML.colCount		= strColumnHead.length;
    makeTableHTML.pageSize 		= RowCount;  //RowCount 1페이지로 구성,PageSize: PageSize의 사이즈로 구성 
    makeTableHTML.currentPageNum= 1;
    makeTableHTML.htmlTable_ID	= "TableS202S010240";
    makeTableHTML.colOff		= colOff;
    makeTableHTML.TR_Style 		= TR_Style;
    makeTableHTML.TD_Style 		= TD_Style; 
    makeTableHTML.HyperLink 	= HyperLink;makeTableHTML.user_id	= loginID;
    makeTableHTML.Check_Box 	= "false";
    makeTableHTML.RightButton	= RightButton; makeTableHTML.jsp_page	= JSPpage;
    String zhtml=makeTableHTML.getHTML();	
%>
<script>

    $(document).ready(function () {

		vTableS202S010240 = $('#<%=makeTableHTML.htmlTable_ID%>').DataTable({
			scrollX: true,
		    scrollY: 120,
		    scrollCollapse: true,
		    paging: false,
		    lengthMenu: [[8,9,-1], [8,9,"All"]],
		    searching: false,
		    ordering: true,
		    order: [[ 2, "asc" ]],
		    keys: false,
		    info: true,
		    'createdRow': function(row) {	
	      		$(row).attr('id',"<%=makeTableHTML.htmlTable_ID%>_rowID");
// 	      		$(row).attr('onclick',"S202S010240Event(this)");
	      		$(row).attr('role',"row");
	  		},
	  		'columnDefs': [{
	       		'targets': [0,1,4,5,6,12],
	       		'createdCell':  function (td) {
	          			$(td).attr('style', 'width:0px; display: none;'); 
	       		}
			}],
			language: { 
	               url:"<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/localisation/Korean.json"
	            }
		});
		
	
		$('#<%=makeTableHTML.htmlTable_ID%> tbody').on( 'click', 'tr', function () {
			S202S010240_Row_index = vTableS202S010240
		        .row( this )
		        .index();


	 		$(<%=makeTableHTML.htmlTable_ID%>_rowID).removeClass("hene-bg-color");
			vTableS202S010240.row(this)
		    .nodes()
		    .to$()
		    .attr("class","hene-bg-color");


		} );
		        

		$('#<%=makeTableHTML.htmlTable_ID%> tbody').on( 'blur', 'tr', function () {
			vTableS202S010240.row(this)
		    .nodes()
		    .to$()
		    .attr("class", "hene-bg-color_w");
		} );


	    $('#txt_seq').val( '<%=(RowCount+1)%>');
    });

    function S202S010240Event(obj){
    	var tr = $(obj);
		var td = tr.children();
		var trNum = $(obj).closest('tr').prevAll().length;//현재 클릭한 TR의 순서 return	
		
// 		$(<%=makeTableHTML.htmlTable_ID%>_rowID).attr("class", "");
// 		$(obj).attr("class", "hene-bg-color");

// 		$('#txt_seq').val(td.eq(0).text().trim());



    }        
</script>

    <%=zhtml%>  
    
    