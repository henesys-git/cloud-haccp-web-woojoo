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
	
	String member_key = session.getAttribute("member_key").toString();

	String[] strColumnHead 	= {"order_no","project_name", "product_serial_no","lotno", "lot_count",  "pic_seq", "prod_cd",  "product_nm", "order_check_no", //0~8
			"순번","체크코드", "표준지침","체크내용","표준값","결과값","비고", //9~15
			"prod_cd_rev","checklist_cd_rev","item_cd","item_desc","item_seq","item_cd_rev","합격여부","inspect_gubun","검사구분","inspect_no","inspect_seq"};
	int[]   colOff 	= {0,0,0,0,0,0,0,0,0,
						0,0,0,0,0,0,0,
						0,0,0,0,0,0,1,0,1,0,0};//전체 넓이 번튼 3개:86%, 문서2개:90%, 문서뷰:94%, 챠트보기,문서등록91%; 고객사

	
	String[] TR_Style		= {"",""};
// 	String[] TR_Style		= {""," onclick='S404S070230Event(this)' "};
	String[] TD_Style		= {"align:center;font-weight: bold;"}; 
	String[] HyperLink		= {""}; 
	String RightButton[][]	= {{"off", "fn_Chart_View", rightbtnChartShow},{"off", "fn_Doc_Reg()", rightbtnDocSave},{"off", "fn_mius_body(this)", "삭제"}};
	
	String GV_ORDER_NO="";
	
	if(request.getParameter("order_no")== null)
		GV_ORDER_NO="";
	else
		GV_ORDER_NO = request.getParameter("order_no");	
		
	
	String param = GV_ORDER_NO + "|";
	
	JSONObject jArray = new JSONObject();
	jArray.put( "order_no", GV_ORDER_NO);
	jArray.put( "member_key", member_key);

		
    TableModel = new DoyosaeTableModel("M404S070100E234", strColumnHead, jArray);	
 	int RowCount =TableModel.getRowCount();	
//     makeTableHTML= new MakeTableHTML(TableModel);
//     makeTableHTML.colCount		= strColumnHead.length;
//     makeTableHTML.pageSize 		= RowCount;  //RowCount 1페이지로 구성,PageSize: PageSize의 사이즈로 구성 
//     makeTableHTML.currentPageNum= 1;
//     makeTableHTML.htmlTable_ID	= "TableS404S070230";
//     makeTableHTML.colOff		= colOff;
//     makeTableHTML.TR_Style 		= TR_Style;
//     makeTableHTML.TD_Style 		= TD_Style; 
//     makeTableHTML.HyperLink 	= HyperLink;
//     makeTableHTML.Check_Box 	= "false";
//     makeTableHTML.RightButton	= RightButton;
//     String zhtml=makeTableHTML.getHTML();	
%>
<script>

var vTableS404S070230;
var TableS404S070230_info;
var TableS404S070230_RowCount;
var S404S070230_Row_index = -1;

var item_type = [];


    $(document).ready(function () {	
		vTableS404S070230=$('#order_product_result_table').DataTable({  
			scrollX: true,
			scrollY: 470,
		    scrollCollapse: true,
		    paging: false,
		    searching: false,
		    ordering: true,
		    order: [[ 0, "asc" ]],
		    info: false
		    ,
	  		'columnDefs': [{
	       		'targets': [0],
	       		'createdCell':  function (td) {
	          			$(td).attr('style', 'width:3%;'); 
	       		}
			}],         
            language: { 
                url:"<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/localisation/Korean.json"
             }			    	  	
		});	

// 		$('#order_product_result_table tbody tr').mouseover(function () {
// 			S404S070230_Row_index = vTableS404S070230
// 		        .row( this )
// 		        .index();		
// 		});
		
			$('#order_product_result_table tbody').on( 'click', 'tr', function () {
// 				alert($(this).closest('tr').preveAll().length);
		 		$($("input[id='txt_item_type']")[S404S070230_Row_index]).on("click", function(){
					if($($("input[id='txt_item_type']")[S404S070230_Row_index]).prop('checked')){
						$(this).attr("checked", true);
						item_type[S404S070230_Row_index]="Y";
	//						$($("input[id='txt_pass_yn']")[S404S070230_Row_index]).attr("checked", true);
		 			}
					else{
						$(this).attr("checked", false);
						item_type[S404S070230_Row_index]="N";
						
	//						$($("input[id='txt_pass_yn']")[S404S070230_Row_index]).attr("checked", false);
					}	
			    }); 			
			});

	} );
		        

// 		$('#order_product_result_table tbody').on( 'blur', 'tr', function () {
// 			vTableS404S070230.row(this)
// 		    .nodes()
// 		    .to$()
// 		    .attr("class", "hene-bg-color_w");
// 		} );

    function S404S070230Event(obj){
    	var tr = $(obj);
		var td = tr.children();
		var trNum = $(obj).closest('tr').prevAll().length;//현재 클릭한 TR의 순서 return	
		
// 		$(order_product_result_table_rowID).attr("class", "");
// 		$(obj).attr("class", "hene-bg-color");
    }        
</script>

			<table class="table table-striped" style="width: 100%; margin: 0 ; align:center ;" id="order_product_result_table"> 
			<thead>
	        <tr style="vertical-align: middle">
	            <th style="width:  3%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">순번</th>
	            <th style="width: 10%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">체크코드</th>
	            <th style="width: 20%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle ">표준지침</th>
	            <th style="width: 10%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle ">체크내용</th>
	            <th style="width: 15%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">표준값</th>
	            <th style="width: 15%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">결과값</th>
	            <th style="width: 15%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">합격여부</th>
	            <th style="width: 17%; font-weight: 900; font-size:14px; text-align:center; vertical-align: middle">비고</th>
	        </tr>		    	
			</thead>
			
	        <tbody id="order_head_tbody">
<%for (int i=0; i<RowCount; i++){  %>	        

	        <tr style="vertical-align: middle">			            
	        	<td style="text-align:center; vertical-align: middle ;margin: 0 ;">
	        	<input type="hidden" class="form-control" id="txt_pic_seq" readonly value='<%=TableModel.getValueAt(i, 5).toString().trim()%>'></input>	
				<input type="hidden" class="form-control" id="txt_prod_cd" readonly value='<%=TableModel.getValueAt(i, 6).toString().trim()%>'></input>	
				<input type="hidden" class="form-control" id="txt_product_nm" readonly value='<%=TableModel.getValueAt(i, 7).toString().trim()%>'></input>	
				<input type="hidden" class="form-control" id="txt_order_check_no" readonly value='<%=TableModel.getValueAt(i, 8).toString().trim()%>'></input>		
				<input type="text" class="form-control" id="txt_checklist_cd_rev" readonly value='<%=TableModel.getValueAt(i, 9).toString().trim()%>'></input>	
				</td>	
				
				<td style="text-align:right;vertical-align: middle ;margin: 0 ;">
					<input type="text" class="form-control" id="txt_checklist_cd"  readonly value='<%=TableModel.getValueAt(i, 10).toString().trim()%>'></input> 
	           	</td> 
	           	        
	           	<td style="text-align:right;vertical-align: middle ;margin: 0 ;">
					<input type="text" class="form-control" id="txt_standard_guide"  readonly value='<%=TableModel.getValueAt(i, 11).toString().trim()%>'></input> 
	           	</td>
	           	
	           	<td style="text-align:center; vertical-align: middle ;margin: 0 ;">
					<input type="text" 	 class="form-control" id="txt_check_note" readonly value='<%=TableModel.getValueAt(i, 12).toString().trim()%>'></input>	           
	           	</td>
	           	
	           <td style="text-align:center; vertical-align: middle ;margin: 0 ;">
					<input type="text" 	 	class="form-control" id="txt_standard_value" readonly value='<%=TableModel.getValueAt(i, 13).toString().trim()%>'></input>
				</td>
				
				 <td style="text-align:center; vertical-align: middle ;margin: 0 ;">
	            <%if(TableModel.getValueAt(i,14).toString().trim().equals("text")){ %>
					<input type="<%=TableModel.getValueAt(i,14).toString().trim()%>"  id="txt_item_type"  disabled="disabled"></input>
				<%} 
				else{ %>
					<input type="<%=TableModel.getValueAt(i,14).toString().trim()%>"  id="txt_item_type" value="CHECK" disabled="disabled"><%=TableModel.getValueAt(i, 19).toString().trim()%></input>
				<%} %>
	           	</td>
	            <td style="text-align:center; vertical-align: middle ;margin: 0 ;">
					<input type="checkbox" id="txt_pass_yn" value="CHECK" disabled="disabled">Y/N</input>
	           	</td>
	           	<td style="text-align:center; vertical-align: middle ;margin: 0 ;">
					<input type="text" 	 class="form-control" id="txt_item_bigo" readonly value='<%=TableModel.getValueAt(i, 15).toString().trim()%>'></input>	           
	           	
					<input type="hidden" class="form-control" id="txt_prod_cd_rev" readonly value='<%=TableModel.getValueAt(i, 16).toString().trim()%>'></input>	
					<input type="hidden" class="form-control" id="txt_checklist_cd_rev" readonly value='<%=TableModel.getValueAt(i, 17).toString().trim()%>'></input>	
					<input type="hidden" class="form-control" id="txt_item_cd" readonly value='<%=TableModel.getValueAt(i, 18).toString().trim()%>'></input>
					<input type="hidden" class="form-control" id="txt_item_seq" readonly value='<%=TableModel.getValueAt(i, 20).toString().trim()%>'></input>
					<input type="hidden" class="form-control" id="txt_item_cd_rev" readonly value='<%=TableModel.getValueAt(i, 21).toString().trim()%>'></input>
					<input type="hidden" class="form-control" id="txt_inspect_gubun" readonly value='<%=TableModel.getValueAt(i, 23).toString().trim()%>'></input>
<%-- 					<input type="hidden" class="form-control" id="txt_inspect_no" readonly value='<%=TableModel.getValueAt(i, 25).toString().trim()%>'></input> --%>
<%-- 					<input type="hidden" class="form-control" id="txt_inspect_seq" readonly value='<%=TableModel.getValueAt(i, 26).toString().trim()%>'></input> --%>
				 </td>
	        </tr>
<% }%>	        
	        </tbody>
	    </table>
	    