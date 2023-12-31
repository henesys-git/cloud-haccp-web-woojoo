<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*" %>
<%@ page import="mes.client.guiComponents.*" %>
<%@ page import="mes.client.util.*" %>
<%@ page import="mes.client.conf.*" %>
<%@ page import="org.json.simple.*"%>
<% 
	String bizNo = session.getAttribute("bizNo").toString();
%>

<%-- 	<!-- Font Awesome -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/fontawesome-free/css/all.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/ionicons-2.0.1/css/ionicons.min.css">
	<!-- Tempusdominus Bbootstrap 4 -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
	<!-- iCheck -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
	<!-- JQVMap -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jqvmap/jqvmap.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/dist/css/adminlte.min.css">
	<!-- overlayScrollbars -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
	<!-- Daterange picker -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/daterangepicker/daterangepicker.css">
	<!-- summernote -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/summernote/summernote-bs4.css">
	<!-- Google Font: Source Sans Pro -->
	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	<!-- Henesys Icon -->
	<link rel="shotcut icon" type="image/x-icon" href="<%=Config.this_SERVER_path%>/images/henesys.jpg"/>
	<!-- SweetAlert2 -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/sweetalert2/sweetalert2.min.css">
 	<!-- DataTables -->
    <link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-select/css/select.bootstrap4.min.css">
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/cdnjs/select2.min.css">
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  	<!-- FullCalendar CSS -->
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/fullcalendar-5.5.0/lib/main.css">
  	<!-- Henesys CSS -->
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/css/henesys.css">
  	<!-- TimePicker -->
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-timepicker/jquery.timepicker.css">
  	<!-- datetimepicker -->
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datetimepicker/css/bootstrap-datetimepicker.css">
  		<!-- Date Picker -->
	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css"></link>
	
	 <!-- Font Awesome Icons -->
  	<link rel="stylesheet" href="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/fontawesome-free/css/all.min.css">
  	<!-- IonIcons -->
  	<link rel="stylesheet" href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  	<!-- Google Font: Source Sans Pro -->
  	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
	

<!-- jQuery -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery/jquery.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-ui/jquery-ui.js"></script>
	<!-- jQuery -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery/jquery.min.js"></script>
	<!-- jQuery Mapael -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-mousewheel/jquery.mousewheel.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/raphael/raphael.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-mapael/jquery.mapael.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-mapael/maps/usa_states.min.js"></script>
<script src="<%=Config.this_SERVER_path%>/Lib/canvas-gauges-master/gauge.min.js"></script>
<!-- Bootstrap 4 -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- ChartJS -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/chart.js/Chart.min.js"></script>
	<!-- Sparkline -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/sparklines/sparkline.js"></script>
	<!-- JQVMap -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jqvmap/jquery.vmap.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
	<!-- jQuery Knob Chart -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jquery-knob/jquery.knob.min.js"></script>
	<!-- daterangepicker -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/moment/moment.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/daterangepicker/daterangepicker.js"></script>
	<!-- Tempusdominus Bootstrap 4 -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
	<!-- Summernote -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/summernote/summernote-bs4.min.js"></script>
	<!-- overlayScrollbars -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
	<!-- AdminLTE App -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/dist/js/adminlte.js"></script>
	<!-- DataTables -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables/jquery.dataTables.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-select/js/dataTables.select.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
	<!-- DataTables Buttons -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-buttons/js/buttons.html5.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/datatables-buttons/js/buttons.print.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/jszip/jszip.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/pdfmake/pdfmake.min.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/pdfmake/vfs_fonts.js"></script>
	<!-- Bootstrap -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- OPTIONAL SCRIPTS -->
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/dist/js/demo.js"></script>
	<script src="<%=Config.this_SERVER_path%>/AdminLTE-3.0.5/dist/js/pages/dashboard3.js"></script>
	<script src="<%=Config.this_SERVER_path%>/js/ottogiDashboard.js"></script> --%>
	
 
<style>
    .main .content { text-align: center; }

    .swal-overlay {
        background-color: rgba(255,0,0,0.3);
    }
    .content-wrapper {
     	margin-left : 0;
    }
</style>

<div class="main">
    <div class="content-wrapper" style = "margin-left:0;">
        <div class="row" id="autonixTemp2">
        
        </div>
                
            <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">라인별 이탈정보(회)</h3>
                </div>
            </div>
				<div class="card-body">
				
				<div class="position-relative mb-4">
                  <canvas id="ottogi-heating-chart" height="200"></canvas>
                </div>
				
                <div class="d-flex flex-row justify-content-end">
                  <span class="mr-2">
                    <i class="fas fa-square text-primary"></i> 1차측Hz
                  </span>
                  <span class="mr-2">
                    <i class="fas fa-square text-gray"></i> 1차측온도
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-red"></i> 2차측Hz
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-yellow"></i> 2차측온도
                  </span>
                </div>
               </div>
            </div>
           </div>
            
</div>

<script>



//온도계 공통 옵션
var commonOpts;
var gaugeList;
var tempData;
//var sulbiName = new Array("만두동 1라인", "만두동 2라인", "만두동 3라인", "만두동 4라인", "만두동 5라인");
//var firstHz = new Array("23.5", "23.5", "23.6", "23.7", "23.8");
//var firstTemp = new Array("53", "55", "57", "57", "57");
//var secondHz = new Array("23.6", "23.6", "23.7", "23.8", "23.9");
//var secondTemp = new Array("10.2", "10.4", "10.5", "10.6", "10.6");

var sulbiName = new Array();
var firstHz = new Array();
var firstTemp = new Array();
var secondHz = new Array();
var secondTemp = new Array();
var chartArray2 = new Array();

var firstHz2 = new Array();
var firstTemp2 = new Array();
var secondHz2 = new Array();
var secondTemp2 = new Array();


$(document).ready(function(){
	
	// 전체
	document.body.style.overflow = "hidden";
	
	async function getData3() {
		
        var fetchedData = $.ajax({
            type: "GET",
            url: "<%=Config.this_SERVER_path%>/dashboard",
            data: "method=dashboard2Table",
            success: function (result) {
            	return result;
            }
        });

        return fetchedData;
    };
    
	async function getData4() {
		
        var fetchedData = $.ajax({
            type: "GET",
            url: "<%=Config.this_SERVER_path%>/dashboard",
            data: "method=dashboard2Table",
            success: function (result) {
            	return result;
            }
        });

        return fetchedData;
    };
	
 	async function initTable2() {
    	
    	var data = await getData3();
    	var parseData = JSON.parse(data);
    	console.log(parseData);
    	console.log(parseData.length);
    	
    	for (var j = 0; j < 5; j++) {
    		console.log(parseData[j]);
    		console.log(parseData[j].sensorName);
    		console.log(parseData[j].firstTemp);
    		console.log(parseData[j].firstRpm);
    		console.log(parseData[j].secondRpm);
    		console.log(parseData[j].secondTemp);
    		
    		sulbiName.push(parseData[j].sensorName);
    		firstTemp.push(parseData[j].firstTemp);
    		firstHz.push(parseData[j].firstRpm);
    		secondHz.push(parseData[j].secondRpm);
    		secondTemp.push(parseData[j].secondTemp);
    	}
    	
    	console.log(sulbiName);
    	console.log(firstTemp);
    	console.log(firstHz);
    	console.log(secondHz);
    	console.log(secondTemp);
    	
    	
    	for(var i = 0; i < 5; i++) {
    		console.log("ini");
     		$('#autonixTemp2').append('<div class="col"><div class="info-box mb-3 bg-warning"><div class="info-box-content"><span class="info-box-text"></span><span class="info-box-number" style="text-align:center;">' + sulbiName[i] + '</span></div></div><div class="info-box mb-3 bg-success"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">증숙온도</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + firstHz[i] + '</span></div></div><div class="info-box mb-3 bg-success"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">1차 RPM (HZ)</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + firstTemp[i] + '</span></div></div><div class="info-box mb-3 bg-info"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">2차 RPM(HZ)</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + secondHz[i] + '</span></div></div><div class="info-box mb-3 bg-info"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">동결온도</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + secondTemp[i] + '</span></div></div></div>');
    	
     	}
    	
    }
    
    
	
	/* 
	for(var i = 0; i < 5; i++) {
 		$('#autonixTemp2').append('<div class="col"><div class="info-box mb-3 bg-warning"><div class="info-box-content"><span class="info-box-text"></span><span class="info-box-number" style="text-align:center;">' + sulbiName[i] + '</span></div></div><div class="info-box mb-3 bg-success"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">증숙온도</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + firstHz[i] + '</span></div></div><div class="info-box mb-3 bg-success"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">1차 RPM (HZ)</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + firstTemp[i] + '</span></div></div><div class="info-box mb-3 bg-info"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">2차 RPM(HZ)</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + secondHz[i] + '</span></div></div><div class="info-box mb-3 bg-info"><div class="info-box-content"><span class="info-box-text" style="text-align:center;">동결온도</span><span class="info-box-number" style="text-align:center; font-size:40px;">' + secondTemp[i] + '</span></div></div></div>');
	
 	} 
	 */
	 
	 async function initGraph2() {
	    	
	    	var data = await getData3();
	    	var parseData = JSON.parse(data);
	    	console.log(parseData);
	    	console.log(parseData.length);
	 
	   for (var j = 0; j < 5; j++) {
		   
		   		firstTemp2.push(parseData[j].firstTemp);
   				firstHz2.push(parseData[j].firstRpm);
   				secondHz2.push(parseData[j].secondRpm);
   				secondTemp2.push(parseData[j].secondTemp);
	    		
	   }   	
	    	
	 
	   
	   
 	 $(function () {
		  'use strict'

		  var ticksStyle = {
		    fontColor: '#495057',
		    fontStyle: 'bold'
		  }

		  var mode      = 'index'
		  var intersect = true

		  var $salesChart = $('#ottogi-heating-chart')
		  var salesChart  = new Chart($salesChart, {
		    type   : 'bar',
		    data   : {
		      labels  : ['만두동1라인', '만두동2라인', '만두동3라인', '3층라인', '5층라인'],
		      datasets: [
		        {
		          backgroundColor: '#007bff',
		          borderColor    : '#007bff',
		          data           : firstHz2
		        },
		        {
		          backgroundColor: '#ced4da',
		          borderColor    : '#ced4da',
		          data           : firstTemp2
		        },
				{
		          backgroundColor: '#eb3434',
		          borderColor    : '#eb3434',
		          data           : secondHz2
		        },
				{
		          backgroundColor: '#ebdf34',
		          borderColor    : '#ebdf34',
		          data           : secondTemp2
		        }
		      ]
		    },
		    options: {
		      maintainAspectRatio: false,
		      tooltips           : {
		        mode     : mode,
		        intersect: intersect
		      },
		      hover              : {
		        mode     : mode,
		        intersect: intersect
		      },
		      legend             : {
		        display: false
		      },
		      scales             : {
		        yAxes: [{
		          // display: false,
		          gridLines: {
		            display      : true,
		            lineWidth    : '4px',
		            color        : 'rgba(0, 0, 0, .2)',
		            zeroLineColor: 'transparent'
		          },
		          ticks    : $.extend({
		            beginAtZero: true,
					suggestedMax: 1.2
		          

		          }, ticksStyle)
		        }],
		        xAxes: [{
		          display  : true,
		          gridLines: {
		            display: false
		          },
		          ticks    : ticksStyle
		        }]
		      }
		    }
		  })
		})
		
	 }
	 
	 initTable2();
     initGraph2();
		
});



</script>
