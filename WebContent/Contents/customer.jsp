<!-- 
완제품 고객사 관리 메뉴
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>

<script type="text/javascript">
    
	$(document).ready(function () {
		
		let mainTable;
		
	    async function initTable() {
	    	var customers = new Customer();
	    	var customersList = await customers.getCustomers();
	    	
		    var customOpts = {
					data : customersList,
					pageLength: 10,
					columns: [
						{ data: "customerId", defaultContent: '' },
						{ data: "customerName", defaultContent: '' }
			        ]
			}
					
			mainTable = $('#customerTable').DataTable(
				mergeOptions(heneMainTableOpts, customOpts)
			);
	    }
	    
	    async function refreshMainTable() {
	    	var customers = new Customer();
	    	var customersList = await customers.getCustomers();
	    	
    		mainTable.clear().rows.add(customersList).draw();
		}
	    
	    var initModal = function () {
	    	$('#customer-id').prop('disabled', false);
	    	$('#customer-id').val('');
	    	$('#customer-name').val('');
	    };
	     
		initTable();
		
		// 등록
		$('#insert').click(function() {
			initModal();
			
			$('#myModal').modal('show');
			$('.modal-title').text('등록');
			
			$('#save').off().click(function() {
				var id = $('#customer-id').val();
				var name = $('#customer-name').val();
				
				if(id === '') {
					alert('제품아이디를 입력해주세요');
					return false;
				}
				if(name === '') {
					alert('제품명을 입력해주세요');
					return false;
				}
				
				$.ajax({
		            type: "POST",
		            url: "<%=Config.this_SERVER_path%>/customer",
		            data: {
		            	"type" : "insert",
		            	"id" : id, 
		            	"name" : name 
		            },
		            success: function (insertResult) {
		            	if(insertResult == 'true') {
		            		alert('등록되었습니다.');
		            		$('#myModal').modal('hide');
		            		refreshMainTable();
		            	} else {
		            		alert('등록 실패했습니다, 관리자에게 문의해주세요.');
		            	}
		            }
		        });
			});
		});

		// 수정
		$('#update').click(function() {
			initModal();
			
			var row = mainTable.rows( '.selected' ).data();
			
			if(row.length == 0) {
				alert('수정할 고객사를 선택해주세요.');
				return false;
			}
			
			$('#myModal').modal('show');
			$('.modal-title').text('수정');
			
			$('#customer-id').val(row[0].customerId);
			$('#customer-name').val(row[0].customerName);
			
			$('#customer-id').prop('disabled', true);
			
			$('#save').off().click(function() {
				$.ajax({
		            type: "POST",
		            url: "<%=Config.this_SERVER_path%>/customer",
		            data: { 
	            		"type" : "update",
	            		"id" : row[0].customerId,
	            		"name" : $('#customer-name').val()
		           	},
		            success: function (deleteResult) {
		            	if(deleteResult == 'true') {
		            		alert('수정되었습니다.');
		            		$('#myModal').modal('hide');
		            		refreshMainTable();
		            	} else {
		            		alert('수정 실패했습니다, 관리자에게 문의해주세요.');
		            	}
		            }
		        });
			});
		});
		
		// 삭제
		$('#delete').click(function() {
			var row = mainTable.rows( '.selected' ).data();
			
			if(row.length == 0) {
				alert('삭제할 고객사를 선택해주세요.');
				return false;
			}
			
			if(confirm('삭제하시겠습니까?')) {
				$.ajax({
		            type: "POST",
		            url: "<%=Config.this_SERVER_path%>/customer",
		            data: { 
		            		"type" : "delete",
		            		"id" : row[0].customerId 
		            	  },
		            success: function (deleteResult) {
		            	if(deleteResult == 'true') {
		            		alert('삭제되었습니다.');
		            		refreshMainTable();
		            	} else {
		            		alert('삭제 실패했습니다, 관리자에게 문의해주세요.');
		            	}
		            }
		        });
			}
			
		});
    });
    
</script>

<!-- Content Header (Page header) -->
<div class="content-header">
  <div class="container-fluid">
    <div class="row mb-2">
      <div class="col-sm-6">
        <h1 class="m-0 text-dark">
        	고객사 관리
        </h1>
      </div><!-- /.col -->
      <div class="col-sm-6">
      	<div class="float-sm-right">
      	  <button type="button" class="btn btn-info" id="insert">
      	  	등록
      	  </button>
      	  <button type="button" class="btn btn-success" id="update">
      	  	수정
      	  </button>
      	  <button type="button" class="btn btn-danger" id="delete">
      	  	삭제
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
          		고객사 목록
          	</h3>
          </div>
          <div class="card-body" id="MainInfo_List_contents">
          	<table class='table table-bordered nowrap table-hover' 
				   id="customerTable" style="width:100%">
				<thead>
					<tr>
					    <th>고객사아이디</th>
					    <th>고객사명</th>
					</tr>
				</thead>
				<tbody id="customerTableBody">		
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
      	<label for="basic-url">고객사아이디</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" id="customer-id">
		</div>
      	<label for="basic-url">고객사명</label>
		<div class="input-group mb-3">
		  <input type="text" class="form-control" id="customer-name">
		</div>
      </div>  
      <div class="modal-footer">  
        <button type="button" class="btn btn-primary" id="save">저장</button>  
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>  
      </div>  
    </div>  
      
  </div>  
</div>