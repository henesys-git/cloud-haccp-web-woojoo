<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>

<script type="text/javascript">
    
	var dataJspPage = {};
	var mainTable;
	
	$(document).ready(function () {
		
		let mainTableSelectedRow;
		
	    async function initTable() {
	    	var results = new ProductionResult();
	    	var resultsList = await results.getProductionResults();
		    var customOpts = {
					data : resultsList,
					pageLength: 10,
					columns: [
						{ data: "planNo", defaultContent: '' },
						{ data: "workLineNo", defaultContent: '' },
						{ data: "planCountAllocated", defaultContent: '' },
						{ data: "workDate", defaultContent: '' },
						{ data: "productName", defaultContent: '' },
						{ data: "workStartTime", defaultContent: '' },
						{ data: "workFinishTime", defaultContent: '' },
						{ data: "packingCount", defaultContent: '' },
						{ data: "workerCount", defaultContent: '' },
						{ data: "rawMaterialDeductYn", defaultContent: '' },
						{ data: "workStatus", defaultContent: '' },
						{ data: "ipgoYn", defaultContent: '' },
						{ data: "productId", defaultContent: '' }
			        ],
			        columnDefs : [
			        	{
					  			targets: [0,1,2,8,9,10,12],
					  			createdCell:  function (td) {
				          			$(td).attr('style', 'width:0px; display: none;'); 
				       			}
				  		},
				  		{
				  			targets: [11],
				  			render: function(td, cellData, rowData, row, col){
				  				console.log(cellData);
				  				if (rowData.ipgoYn == 'N') {
				  					return "<button type='button' class='btn btn-success' id='btn_ipgo' onclick='prod_ipgo(this);'>입고</button>";
				  				}
				  				else {
				  					return "입고완료";
				  				}
				  			}
				  		}
				    ]
			}
					
			mainTable = $('#resultTable').DataTable(
				mergeOptions(heneMainTableOpts, customOpts)
			);
	    }
	    
	    async function getCupSealerCountFromMachine() {
 			console.log('getting cup sealer count');
 			return $.ajax({
	            url: "<%=Config.this_SERVER_path%>/mes-productionResult",
	            type: 'GET',
	            data: "param1=" + 1 + "&id=packingRead" ,
	            contentType: "plain/text;charset=UTF-8",
	            dataType: "text",
	            success: function (data) {
	            	console.log("packingCount##############");
	            	console.log(data);
				}
	        });
 		};
	    
	    async function refreshMainTable() {
	    	var results = new ProductionResult();
	    	var resultsList = await results.getProductionResults();
	    	
    		mainTable.clear().rows.add(resultsList).draw();
    		
		}
	    
	    var initModal = function () {
	    	$('#work_date').val('');
	    	$('#product_name').val('');
	    	$('#packing_count').val('');
	    	$('#plan_no').val('');
	    };
	    
		initTable();
		getCupSealerCountFromMachine();
		
		
		// 수정
		$('#update').click(function() {
			initModal();
			
			var row = mainTable.rows( '.selected' ).data();
			
			if(row.length == 0) {
				alert('포장수량을 수정할 실적 정보를 선택해주세요.');
				return false;
			}
			
			$('#myModal').modal('show');
			$('.modal-title').text('생산실적 포장수량 수정');
			
			$('#work_date').val(row[0].workDate);
			$('#product_name').val(row[0].productName);
			$('#packing_count').val(row[0].packingCount);
			$('#plan_no').val(row[0].planNo);
			
			
			
			$('#save').off().click(function() {
				
				var planNo = $('#plan_no').val();
				var packingCount = $('#packing_count').val();
				
				var check = confirm('해당 생산실적의 포장수량을 수정하시겠습니까?');
				
				if(check) {
					
				$.ajax({
		            type: "POST",
		            url: "<%=Config.this_SERVER_path%>/mes-productionResult",
		            data: {
		            	"type" : "packingUpdate",
		            	"packingCount" : packingCount,
		            	"planNo" : planNo
		            	
		            },
		            success: function (updateResult) {
		            	if(updateResult == 'true') {
		            		alert('수정되었습니다.');
		            		$('#myModal').modal('hide');
		            		refreshMainTable();
		            	} else {
		            		alert('수정 실패했습니다, 관리자에게 문의해주세요.');
		            	}
		            }
		        });
				
				}
			});
			<%-- /*
			$('#insert').off().click(function() {
					
				$.ajax({
		            type: "POST",
		            url: "<%=Config.this_SERVER_path%>/mes-interfaces",
		            data: {
		            	"data_date" : "2023-04-19",
		            	"prev_product_id" : packingCount,
		            	"prev_product_cnt" : planNo,
		            	"cur_product_id" : planNo,
		            	"cur_product_cnt" : planNo
		            	
		            },
		            success: function (updateResult) {
		            	if(updateResult == 'true') {
		            		alert('수정되었습니다.');
		            		$('#myModal').modal('hide');
		            		refreshMainTable();
		            	} else {
		            		alert('수정 실패했습니다, 관리자에게 문의해주세요.');
		            	}
		            }
		        });
				
			});
			*/ --%>
			
			<%-- $('#packing_read').off().click(function() {
				
				console.log('start');
				
				async function getCupSealerCountFromMachine1() {
		 			console.log('getting cup sealer count');
		 			return $.ajax({
			            url: "<%=Config.this_SERVER_path%>/mes-productionResult",
			            type: 'GET',
			            data: "param1=" + 1 + "&id=packingRead" ,
			            contentType: "plain/text;charset=UTF-8",
			            dataType: "text",
			            success: function (data) {
			            	console.log("packingCount##############");
			            	console.log(data.replace(" ", ""));
			            	$('#packing_count').val(data.replace(" ", ""));
						}
			        });
		 		};
		 		
		 		getCupSealerCountFromMachine1();
			}); --%>
			
			$('#packing_read').off().click(function() {
				
				var row = mainTable.rows( '.selected' ).data();
				
				console.log('start');
				console.log(row[0].productId);
				async function getCupSealerCountFromMachine2() {
		 			console.log('getting cup sealer count2');
		 			return $.ajax({
			            url: "<%=Config.this_SERVER_path%>/mes-productionResult",
			            type: 'GET',
			            data: "param1=" + 1 + "&id=packingReadDB" + "&prod_cd=" + row[0].productId,
			            //contentType: "plain/text;charset=UTF-8",
			            //dataType: "text",
			            success: function (data) {
			            	//console.log("packingCount##############");
			            	//console.log(data.replace(" ", ""));
			            	console.log(data);
			            	console.log(data[0]);
			            	$('#packing_count').val(data[0].curProductCnt);
						}
			        });
		 		};
		 		
		 		getCupSealerCountFromMachine2();
			});

		});
		
    });
	
	//생산실적 입고처리
	function prod_ipgo(obj) {
		
    	var rowIdx = $(obj).closest("tr").index();
		var row = mainTable.rows(rowIdx).data();
		var planNo = row[0].planNo;
		var productId = row[0].productId;
		var packingCount = row[0].packingCount;
			
		$.ajax({
            type: "POST",
            url: heneServerPath + '/Contents/mes/mes_product_stock_manage.jsp',
            data: {
            	productId: row[0].productId,
            	productName: row[0].productName,
            	ipgoOnly: "Y",
            	prodResultParam : "Y",
            	planNo : planNo,
            	packingCount : packingCount
            },
            success: function (html) {
                $("#modalWrapper").html(html);
            }
        });
		
	}
	
</script>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0 text-dark">
        	생산실적 관리
        </h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
      	<div class="float-sm-right">
      		  <button type="button" class="btn btn-success" id="update">
      	  		포장수량수정
      	  	  </button>
      	</div>
      </div><!-- /.col -->
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
          		생산실적 목록
          	</h3>
          </div>
          <div class="card-body" id="MainInfo_List_contents">
          	<table class='table table-bordered nowrap table-hover' 
				   id="resultTable" style="width:100%">
				<thead>
					<tr>
						<th style="display:none; width:0px;">생산계획번호</th>
						<th style="display:none; width:0px;">작업라인번호</th>
						<th style="display:none; width:0px;">할당계획수량</th>
						<th>작업일자</th>
						<th>제품명</th>
					    <th>작업시작시간</th>
					    <th>작업종료시간</th>
					    <th>포장수량</th>
					    <th style="display:none; width:0px;">작업인원</th>
					    <th style="display:none; width:0px;">원자재차감여부</th>
					    <th style="display:none; width:0px;">작업상태</th>
					    <th>입고여부</th>
					    <th style="display:none; width:0px;">제품아이디</th>
					</tr>
				</thead>
				<tbody id="resultTableBody">		
				</tbody>
			</table>
          </div>
        </div>
      </div>
      <!-- /.col-md-6 -->
    </div>
    <!-- /.row -->
  </div><!-- /.container-fluid -->
</div>
<!-- /.content -->

<!-- Modal -->  
<div class="modal fade" id="myModal" role="dialog">  
  <div class="modal-dialog">
    
    <!-- Modal content-->  
    <div class="modal-content">  
      <div class="modal-header">
        <h4 class="modal-title"></h4>  
      </div>  
      <div class="modal-body">
      	<label for="basic-url">작업일자</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" id="work_date" readonly>
		</div>
		<label for="basic-url">제품명</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" id="product_name" readonly>
		  <input type="hidden" class="form-control" id="plan_no">
		</div>
		<label for="basic-url">포장수량</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" id="packing_count">
		</div>
      </div> 
      <div class="modal-footer">
      	<button type="button" class="btn btn-success" id="packing_read">포장수량조회</button>
      	<!-- <button type="button" class="btn btn-success" id="packing_readDB">포장수량DB조회</button> -->
      	<!-- <button type="button" class="btn btn-primary" id="insert">포장수량입력</button> -->
        <button type="button" class="btn btn-primary" id="save">저장</button>  
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>  
      </div>  
    </div>  
      
  </div>  
</div>

 <div id="modalWrapper"></div>