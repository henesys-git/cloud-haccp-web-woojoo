<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.common.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%><%@ include file="/strings.jsp" %>
<%
/* 
계측기 검교정 대장 canvas (S838S070300_canvas.jsp)
*/	
	String loginID = session.getAttribute("login_id").toString();
	String member_key = session.getAttribute("member_key").toString();
	DoyosaeTableModel TableModel;

	String GV_CHECK_DATE="" ;

	if(request.getParameter("check_date")== null)
		GV_CHECK_DATE = "";
	else
		GV_CHECK_DATE = request.getParameter("check_date");
	
	JSONObject jArray = new JSONObject();
	jArray.put( "member_key", member_key);
	jArray.put( "check_date", GV_CHECK_DATE);

	TableModel = new DoyosaeTableModel("M838S070300E144", jArray);
	int RowCount =TableModel.getRowCount();
	
	String CheckDate="", WriteDate="", ApprovalDate="";
	if(RowCount>0) {
		CheckDate=TableModel.getValueAt(0, 2).toString().trim() ;
		WriteDate=TableModel.getValueAt(0, 11).toString().trim() ;
		ApprovalDate=TableModel.getValueAt(0, 13).toString().trim() ;
	}
	
	StringBuffer DataArray = new StringBuffer();
	DataArray.append("[");
	for(int i=0; i<RowCount; i++) {
		DataArray.append("[");
		DataArray.append( "'" + TableModel.getValueAt(i, 0).toString().trim() + "'" + "," ); // seolbi_seq_no
		DataArray.append( "'" + TableModel.getValueAt(i, 1).toString().trim() + "'" + "," ); // seolbi_nm
		DataArray.append( "'" + TableModel.getValueAt(i, 4).toString().trim() + "'" + "," ); // seolbi_location
		DataArray.append( "'" + TableModel.getValueAt(i, 5).toString().trim() + "'" + "," ); // standard_value
		DataArray.append( "'" + TableModel.getValueAt(i, 6).toString().trim() + "'" + "," ); // check_value
		DataArray.append( "'" + TableModel.getValueAt(i, 7).toString().trim() + "'" + "," ); // calibration_value
		DataArray.append( "'" + TableModel.getValueAt(i, 8).toString().trim() + "'" + "," ); // judgment
		DataArray.append( "'" + TableModel.getValueAt(i, 9).toString().trim() + "'" + "" ); // bigo
		if(i==RowCount-1) DataArray.append("]");
		else DataArray.append("],");
	}
	DataArray.append("]");

	
%>

<script type="text/javascript">	
	
	// 상단 텍스트 영역
	var HeadText_HeightStart = 30; // 헤드텍스트의 높이를 지정 , 전체 보고서의 높이 위치를 조정된다
	var HaedText_HeightEnd = HeadText_HeightStart + 150; // 헤드텍스트 영역 종료 높이
	
	// 표1 영역
	var vTextStyle = '15px 맑은고딕';
	var vTextStyleBold = 'bold 15px 맑은고딕';
	var DataGrid1_RowHeight = 50; // 표1의 행 높이
	var DataGrid1_RowCount = <%=RowCount%> + 1 ; // 표1의 행 개수(체크리스트행 개수+헤드)
	var DataGrid1_Width = 0 ; // doc.ready에서 표1의 각 열너비를 더해서 계산
	var DataGrid1_Height = HaedText_HeightEnd + (DataGrid1_RowCount * DataGrid1_RowHeight) + 500; // 표1 높이( 상단텍스트 끝 위치 + (행개수 * 행높이) + 하단 기준안내문 공간)
			
    $(document).ready(function () {
    	// 표1의 전체너비 계산
    	for(i=0; i<DataGrid1.col_head_width.length; i++)
    		DataGrid1_Width += DataGrid1.col_head_width[i];
    	
    	// 캔버스 전체 크기 영역
    	var CanvasPadding = 10; // 캔버스영역 안쪽 여백
    	var CanvasWidth = DataGrid1_Width + CanvasPadding*2; // 캔버스영역 너비
    	var CanvasHeight = DataGrid1_Height + CanvasPadding*2; // 캔버스영역 높이
    	
		document.getElementById('myCanvas').width = CanvasWidth;
		document.getElementById('myCanvas').height = CanvasHeight;
		var ctx = document.getElementById('myCanvas').getContext("2d"); // 캔버스 컨텍스트
		
		// 캔버스 내에 실제로 그리는 영역 좌표
    	var pointSX = CanvasPadding; // 시작좌표x
    	var pointSY = CanvasPadding; // 시작좌표y
    	var pointEX = CanvasWidth - CanvasPadding ; // 끝좌표x
    	var pointEY = CanvasHeight - CanvasPadding ; // 끝좌표y
    	
		// 그리기
	    HeadText.drawText(ctx, pointSX, pointSY + HeadText_HeightStart, pointEX, pointSY + HaedText_HeightEnd-20);
		DataGrid1.drawGrid(ctx, pointSX, pointSY + HaedText_HeightEnd, pointEX, pointEY);
    });	
    
 	// 상단 텍스트 정의
	var HeadText = {
		drawText(ctx, sx, sy, ex, ey) {
			var blank_tab = '    '; // 4칸 공백
			var top_info = 'HS-PP-06-C 계측기검교정 대장' ;
			var middle_info = '계측기 검.교정 대장' ;
			var bottom_info1 = ' - 점 검 일 : '  ;
			if('<%=CheckDate%>'.length<1) {
				bottom_info1 += '201    년      월      일 ' ;
			} else {
				var date = new Date('<%=CheckDate%>');
				bottom_info1 += date.getFullYear() + ' 년  '
							+ ("0" + (date.getMonth() + 1)).slice(-2) + ' 월  '
							+ ("0" + date.getDate()).slice(-2) + ' 일  ' ;
			}
			bottom_info1 += blank_tab + ' - 주    기 : 월1회'
			var bottom_info2 = ' - 담 당 자 : 품질관리팀' ;
			var approval_box_width = 190; //결재박스 너비(30 + 80 + 80)
			// 헤드텍스트
			ctx_fillText(ctx, sx, sy, top_info, 'black', vTextStyle, 'start','top');
			ctx_fillText(ctx, (sx+ex-approval_box_width)/2, sy+30, middle_info, 'black', 'bold 30px 맑은고딕', 'center','top');
			ctx_textUnderline(ctx, (sx+ex-approval_box_width)/2, sy+30, middle_info, 'black', 30, 5); // 중간 글자에 밑줄넣기
			ctx_fillText(ctx, sx, ey-30, bottom_info1, 'black', vTextStyleBold, 'start','bottom');
			ctx_fillText(ctx, sx, ey, bottom_info2, 'black', vTextStyleBold, 'start','bottom');
			// 결재 박스
			ctx_Box(ctx, ex-approval_box_width, sy, ex, ey, 'black', 2); // 표 전체 틀(사각형)
			ctx_Line(ctx, ex-approval_box_width+30, sy, ex-approval_box_width+30, ey, 'black', 2); // 세로선
			ctx_Line(ctx, ex-(approval_box_width-30)/2, sy, ex-(approval_box_width-30)/2, ey, 'black', 1); // 세로선
			ctx_Line(ctx, ex-approval_box_width+30, sy+30, ex, sy+30, 'black', 1); // 가로선
			ctx_Line(ctx, ex-approval_box_width+30, ey-30, ex, ey-30, 'black', 1); // 가로선
			ctx_fillText(ctx, ex-approval_box_width+15, sy+30, '결', 'black', vTextStyle, 'center','middle');
			ctx_fillText(ctx, ex-approval_box_width+15, ey-30, '재', 'black', vTextStyle, 'center','middle');
			ctx_fillText(ctx, ex-(approval_box_width-30)*3/4, sy+15, '작    성', 'black', vTextStyle, 'center','middle');
			ctx_fillText(ctx, ex-(approval_box_width-30)*1/4, sy+15, '승    인', 'black', vTextStyle, 'center','middle');
			var bottom_write = '/' ;
			var bottom_approval = '/' ;
			if('<%=WriteDate%>'.length>0) {
				var date = new Date('<%=WriteDate%>');
				bottom_write = ("0" + (date.getMonth() + 1)).slice(-2) + ' / ' + ("0" + date.getDate()).slice(-2) ;
			}
			if('<%=ApprovalDate%>'.length>0) {
				var date = new Date('<%=ApprovalDate%>');
				bottom_approval = ("0" + (date.getMonth() + 1)).slice(-2) + ' / ' + ("0" + date.getDate()).slice(-2) ;
			}
			ctx_fillText(ctx, ex-(approval_box_width-30)*3/4, ey-15, bottom_write, 'black', vTextStyle, 'center','middle');
			ctx_fillText(ctx, ex-(approval_box_width-30)*1/4, ey-15, bottom_approval, 'black', vTextStyle, 'center','middle');
		} // HeadText.drawText function end
	} ;
	
	// 표1 정의
	var DataGrid1 = {
		col_head:["계측기 번호","계측기명","사용장소","표 준 값","지 시 값","교 정 값","판  정","비  고"],
		col_head_width:[120,160,120,100,100,100,120,120],
		col_unit:[ "℃","KG","□적합 □부적합" ], // 표1 양식에 들어갈 단위
		col_data:<%=DataArray%>,
			
		drawGrid: function(ctx, sx, sy, ex, ey) { // 표1 양식 그리기
			ctx_Box(ctx, sx, sy, ex, ey, 'black', 2); // 표 전체 틀(사각형)
			
			// 헤드
			var col_head_y = sy + DataGrid1_RowHeight ;
			var col_head_y_center = sy + (DataGrid1_RowHeight)/2 ;
			var col_head_x = sx;
			var col_head_x_start = col_head_x;
			ctx_Line(ctx, sx, col_head_y-3, ex, col_head_y-3, 'black', 1); // 가로선(이중선)
			ctx_Line(ctx, sx, col_head_y, ex, col_head_y, 'black', 1); // 가로선(이중선)
			for(i=0; i<this.col_head_width.length; i++){
				col_head_x += this.col_head_width[i] ;
				var col_head_x_center = col_head_x - this.col_head_width[i]/2 ;
				if(i<this.col_head_width.length-1) // 마지막엔 세로선 그릴필요X
					ctx_Line(ctx, col_head_x, sy, col_head_x, sy + (DataGrid1_RowCount * DataGrid1_RowHeight), 'black', 1); // 세로선
				ctx_fillText(ctx, col_head_x_center, col_head_y_center, this.col_head[i], 'black', vTextStyleBold, 'center','middle');
			}
			
			// 데이터
			var col_data_y = sy + DataGrid1_RowHeight ;
			for(i=0; i<this.col_data.length; i++){
				col_data_y += DataGrid1_RowHeight ;
				var col_data_y_center = col_data_y - DataGrid1_RowHeight/2 ;
				var col_data_x = sx ;
				for(j=0; j<this.col_data[i].length; j++){
					col_data_x += this.col_head_width[j] ;
					var col_data_x_center = col_data_x - this.col_head_width[j]/2 ;
					if(j==0) { // 계측기 번호
						var seolbi_seq_no = 'CS-계측-'+('0'+this.col_data[i][j]).slice(-2) ;
	 					ctx_fillText(ctx, col_data_x_center, col_data_y_center, seolbi_seq_no, 'black', vTextStyle, 'center','middle');
					} else if(j==3||j==4||j==5) { // 표준값,지시값,교정값
						// 단위
						if(this.col_data[i][1].indexOf("온도") > 0)
							ctx_fillText(ctx, col_data_x-5, col_data_y_center, this.col_unit[0], 'black', vTextStyle, 'end','middle');
						else if(this.col_data[i][1].indexOf("저울") > 0)
							ctx_fillText(ctx, col_data_x-5, col_data_y_center, this.col_unit[1], 'black', vTextStyle, 'end','middle');
						// 숫자 데이터
						ctx_fillText(ctx, col_data_x_center, col_data_y_center, this.col_data[i][j], 'black', vTextStyle, 'center','middle');
					} else if(j==6) { // 판정
						// 체크박스(적합/부적합)
						ctx_wrapText_space(ctx, col_data_x_center-30, col_data_y_center, this.col_unit[2],
								'black', vTextStyle, 'start','middle', 70, DataGrid1_RowHeight/2);
						// 체크데이터
						var check_data = this.col_data[i][j];
						if(check_data == "Y")
							ctx_fillText(ctx, col_data_x_center-27, col_data_y_center-DataGrid1_RowHeight/4-3, "✓", 'black', vTextStyle, 'start','middle');
						else if(check_data == "N")
							ctx_fillText(ctx, col_data_x_center-27, col_data_y_center+DataGrid1_RowHeight/4-3, "✓", 'black', vTextStyle, 'start','middle');
					} else {
//	 					ctx_fillText(ctx, col_data_x_center, col_data_y_center, this.col_data[i][j], 'black', vTextStyle, 'center','middle');
						ctx_wrapText(ctx, col_data_x_center, col_data_y_center, this.col_data[i][j],
								'black', vTextStyle, 'center','middle', this.col_head_width[j]-10, DataGrid1_RowHeight/2);
					}

				}
				ctx_Line(ctx, sx, col_data_y, ex, col_data_y, 'black', 1); // 가로선
			}
			
			// 하단 기준안내문
			var col_standard = [' □ 한계기준 : ① 온도계 - ±1℃ ,   ② 저울 - ±10g',
								' □ 검ㆍ교정주기',
								'    ◦ 신규구입  표준 계측기는 공인기관에서 발행한 검․교정 검사 성적서 첨부',
								'    ◦ 자가 교정은 월 1회 실시',
								' □ 검ㆍ교정방법',
								'   ① 온도계',
								'    ◦ 교정방법 : ① 계측 대상의 온도계센서와 가장 가까운 곳에서 표준온도계를 작동시킨다.',
								'                ② 1분 이상, 표준온도계가 멈출때까지 기다린다.',
								'    ◦ 기존 온도계는 현재 사용 중인 온도와 표준온도계의 수치를 비교하여 ±1℃ 이상 차이가 있을 경우 교정 실시',
								'    ◦ 온도계 파손 및 외부 서비스를 받은 경우 비고란에 표시',
								'    ◦ 자체교정이 불가능한 경우는 외부 공인기관에 요청하거나 새 온도계로 교체하여야 한다.',
								'   ② 저울',
								'    ◦ 교정방법 : 표준 분동(검․교정 필)을 저울에 올려놓아 비교한다.',
								'    ◦ 기존 저울은 표준 분동에서 표시한 중량의 수치를 비교하여 ±10g 이상 차이가 있을 경우 교정 실시',
								'    ◦ 저울 파손 및 외부 서비스를 받은 경우 비고란에 표시',
								'    ◦ 자체 교정이 불가능한 경우는 외부 공인기관에 요청하거나 새 저울로 교체하여야 한다.',
								' □ 표준온도계 년 1회, 분동은 1회/2년 공인기관에 검교정 의뢰' ];
			var col_standard_y_center = col_data_y + DataGrid1_RowHeight/2;
			for(i=0; i<col_standard.length; i++) {
				col_standard_y_center += DataGrid1_RowHeight/2;
				ctx_fillText(ctx, sx + 10, col_standard_y_center, col_standard[i], 'black', '15px 맑은고딕', 'start','middle');
			}

		} // drawGrid function end
	} ; // DataGrid1(표1) 정의  end
	
</script>
    <div id="PrintAreaP"  style="overflow-y:auto; width:100%; height:650px; text-align:center;">
	    <canvas id="myCanvas" ></canvas>    
	</div>
		
	<p style="text-align:center;" >
    	<button id="btn_Print"  class="btn btn-info" onclick="print_area();">프린트</button>
        <button id="btn_Canc"  class="btn btn-info"  onclick="parent.$('#modalReport').hide();">닫기</button>
    </p>