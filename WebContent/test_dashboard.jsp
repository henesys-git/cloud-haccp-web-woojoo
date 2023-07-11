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

	<%-- <!-- Font Awesome -->
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

<div class="main" onbeforeunload="">
    <div class="content-wrapper" style = "margin-left:0;">
        <div class="row" id="autonixTemp">
        	
        </div>
        <div class="content" id="graph">
        	
         <div class="card">
              <div class="card-header border-0">
                <div class="d-flex justify-content-between">
                  <h3 class="card-title">검출횟수</h3>
                <!--   <a href="javascript:void(0);">View Report</a> -->
                </div>
              </div>
              <div class="card-body">
                <!-- <div class="d-flex">
                  <p class="d-flex flex-column">
                    <span class="text-bold text-lg">820</span>
                    <span>Visitors Over Time</span>
                  </p>
                  <p class="ml-auto d-flex flex-column text-right">
                    <span class="text-success">
                      <i class="fas fa-arrow-up"></i> 12.5%
                    </span>
                    <span class="text-muted">Since last week</span>
                  </p>
                </div> -->

                <div class="position-relative mb-4">
                  <canvas id="ottogi-metal-chart" height="200"></canvas>
                </div>

                <div class="d-flex flex-row justify-content-end">
                  <span class="mr-2">
                    <i class="fas fa-square text-primary"></i> 내포장실1
                  </span>
                  <span class="mr-2">
                    <i class="fas fa-square text-gray"></i> 내포장실2
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-red"></i> 내포장실3
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-yellow"></i> 내포장실4
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-green"></i> 내포장실5
                  </span>
                   <span class="mr-2">
                    <i class="fas fa-square text-orange"></i> 내포장실6
                  </span>
                </div>
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
/*
var sulbiName = new Array("내포장실1", "내포장실2", "내포장실3", "내포장실4", "내포장실5", "내포장실6");
var startTime = new Array("13:40:23", "13:40:24", "13:40:25", "13:40:26", "13:40:27", "13:40:28");
var endTime = new Array("15:40:23", "15:40:24", "15:40:26", "15:40:26", "15:40:27", "15:40:28");
var detectCount = new Array("5", "6", "7", "8", "9", "10");
*/

var sulbiName = new Array();
var startTime = new Array();
var endTime = new Array();
var detectCount = new Array();

var detectTime = new Array();
var detectCount2 = new Array();

$(document).ready(function(){
	
	
	
	async function getData() {
		
        var fetchedData = $.ajax({
            type: "GET",
            url: "<%=Config.this_SERVER_path%>/dashboard",
            data: "method=dashboard1Table",
            success: function (result) {
            	return result;
            }
        });

        return fetchedData;
    };
    
	async function getData2() {
		
        var fetchedData = $.ajax({
            type: "GET",
            url: "<%=Config.this_SERVER_path%>/dashboard",
            data: "method=dashboard1Graph",
            success: function (result) {
            	return result;
            }
        });

        return fetchedData;
    };
	
    async function initTable() {
    	
    	var data = await getData();
    	var parseData = JSON.parse(data);
    	console.log(parseData);
    	console.log(parseData.length);
    	
    	for (var j = 0; j < 6; j++) {
    		console.log(parseData[j]);
    		console.log(parseData[j].sensorName);
    		console.log(parseData[j].detectCount);
    		console.log(parseData[j].curTestTime);
    		console.log(parseData[j].nextTestTime);
    		
    		sulbiName.push(parseData[j].sensorName);
    		startTime.push(parseData[j].curTestTime);
    		endTime.push(parseData[j].nextTestTime);
    		detectCount.push(parseData[j].detectCount);
    	}
    	
    	console.log(sulbiName);
    	console.log(startTime);
    	console.log(endTime);
    	console.log(detectCount);
    	
    	for(var i = 0; i < 6; i++) {
    		console.log("ini");
     		$('#autonixTemp').append('<div class="col-lg-2"><div class="info-box mb-3 bg-warning"><div class="info-box-content"><span class="info-box-text"></span><span class="info-box-number">' + sulbiName[i] + '</span></div></div><div class="info-box mb-3 bg-success"><div class="info-box-content"><span class="info-box-text">최종테스트</span><span class="info-box-number">' + startTime[i] + '</span></div></div><div class="info-box mb-3 bg-danger"><div class="info-box-content"><span class="info-box-text">다음테스트</span><span class="info-box-number">' + endTime[i] + '</span></div></div><div class="info-box mb-3 bg-info"><div class="info-box-content"><span class="info-box-text">검출횟수</span><span class="info-box-number">' + detectCount[i] + '</span></div></div></div>');
    	
     	} 
    }
    
	 async function initGraph() {
    	
    	var data = await getData2();
    	var parseData = JSON.parse(data);
    	console.log(parseData);
    	console.log(parseData.length);
    	
    	for (var j = 0; j < 6; j++) {
    		console.log(parseData[j]);
    		//console.log(parseData[j].detectTime);
    		//console.log(parseData[j].detectCount);
    		
    		//detectTime.push(parseData[j].detectTime);
    		//detectCount2.push(parseData[j].detectCount);
    	}
    	
    	console.log(detectTime);
    	console.log(detectCount);
    	
    	
    	$(function () {
    		  'use strict'

    		  var ticksStyle = {
    		    fontColor: '#495057',
    		    fontStyle: 'bold'
    		  }

    		  var mode      = 'index'
    		  var intersect = true
    	
    	var $visitorsChart = $('#ottogi-metal-chart')
    	  var visitorsChart  = new Chart($visitorsChart, {
    	    data   : {
    	      labels  : ['09H', '10H', '11H', '12H', '13H', '14H', '15H'],
    	      datasets: [{
    	        type                : 'line',
    	        data                : [100, 120, 170, 167, 180, 177, 160],
    	        backgroundColor     : 'transparent',
    	        borderColor         : '#007bff',
    	        pointBorderColor    : '#007bff',
    	        pointBackgroundColor: '#007bff',
    	        fill                : false
    	        // pointHoverBackgroundColor: '#007bff',
    	        // pointHoverBorderColor    : '#007bff'
    	      },
    	        {
    	          type                : 'line',
    	          data                : [60, 80, 70, 67, 80, 77, 100],
    	          backgroundColor     : 'tansparent',
    	          borderColor         : '#ced4da',
    	          pointBorderColor    : '#ced4da',
    	          pointBackgroundColor: '#ced4da',
    	          fill                : false
    	          // pointHoverBackgroundColor: '#ced4da',
    	          // pointHoverBorderColor    : '#ced4da'
    	        },
    			{
    	          type                : 'line',
    	          data                : [65, 86, 76, 72, 85, 82, 105],
    	          backgroundColor     : 'tansparent',
    	          borderColor         : '#eb3434',
    	          pointBorderColor    : '#eb3434',
    	          pointBackgroundColor: '#eb3434',
    	          fill                : false
    	          // pointHoverBackgroundColor: '#ced4da',
    	          // pointHoverBorderColor    : '#ced4da'
    	        },
    			{
    	          type                : 'line',
    	          data                : [20, 15, 30, 42, 27, 18, 15],
    	          backgroundColor     : 'tansparent',
    	          borderColor         : '#ebdf34',
    	          pointBorderColor    : '#ebdf34',
    	          pointBackgroundColor: '#ebdf34',
    	          fill                : false
    	          // pointHoverBackgroundColor: '#ced4da',
    	          // pointHoverBorderColor    : '#ced4da'
    	        },
    			{
    	          type                : 'line',
    	          data                : [80, 73, 72, 88, 73, 91, 120],
    	          backgroundColor     : 'tansparent',
    	          borderColor         : '#3deb34',
    	          pointBorderColor    : '#3deb34',
    	          pointBackgroundColor: '#3deb34',
    	          fill                : false
    	          // pointHoverBackgroundColor: '#ced4da',
    	          // pointHoverBorderColor    : '#ced4da'
    	        },
    			{
    	          type                : 'line',
    	          data                : [101, 105, 102, 88, 73, 99, 110],
    	          backgroundColor     : 'tansparent',
    	          borderColor         : '#ebb134',
    	          pointBorderColor    : '#ebb134',
    	          pointBackgroundColor: '#ebb134',
    	          fill                : false
    	          // pointHoverBackgroundColor: '#ced4da',
    	          // pointHoverBorderColor    : '#ced4da'
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
    	            beginAtZero : true,
    	            suggestedMax: 200
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
    
    
    initTable();
    initGraph();
    
    
	
    // 최초 온도값을 받아온 후 1시간 단위로 적정 온도가 지켜지는지 확인
    
    //async function getData() {
   <%--  
   	//브리에잇일  경우
    if ('<%=bizNo%>' == 'B37487014970')	 {
    	commonOpts = {
    			width: 300,
    		    height: 300,
    		    units: "°C",
    		    minValue: 0,
    		    maxValue: 200,
    		    majorTicks: [ 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200 ],
    		    minorTicks: 2,
    		    strokeTicks: true,
    		    ticksAngle: 225,
    		    startAngle: 67.5,
    		    colorMajorTicks: "#ddd",
    		    colorMinorTicks: "#ddd",
    		    colorTitle: "#eee",
    		    colorUnits: "#ccc",
    		    colorNumbers: "#eee",
    		    colorPlate: "#222",
    		    borderShadowWidth: 0,
    		    borders: true,
    		    needleType: "arrow",
    		    needleWidth: 2,
    		    needleCircleSize: 7,
    		    needleCircleOuter: true,
    		    needleCircleInner: false,
    		    animationDuration: 1500,
    		    animationRule: "linear",
    		    colorBorderOuter: "#333",
    		    colorBorderOuterEnd: "#111",
    		    colorBorderMiddle: "#222",
    		    colorBorderMiddleEnd: "#111",
    		    colorBorderInner: "#111",
    		    colorBorderInnerEnd: "#333",
    		    colorNeedleShadowDown: "#333",
    		    colorNeedleCircleOuter: "#333",
    		    colorNeedleCircleOuterEnd: "#111",
    		    colorNeedleCircleInner: "#111",
    		    colorNeedleCircleInnerEnd: "#222",
    		    valueBoxBorderRadius: 0,
    		    colorValueBoxRect: "#222",
    		    colorValueBoxRectEnd: "#333"
    	}
    }
    
    else {
    	commonOpts = {
    			width: 300,
    		    height: 300,
    		    units: "°C",
    		    minValue: -50,
    		    maxValue: 50,
    		    majorTicks: [ -50, -40, -30, -20, -10, 0, 10, 20, 30, 40, 50 ],
    		    minorTicks: 2,
    		    strokeTicks: true,
    		    ticksAngle: 225,
    		    startAngle: 67.5,
    		    colorMajorTicks: "#ddd",
    		    colorMinorTicks: "#ddd",
    		    colorTitle: "#eee",
    		    colorUnits: "#ccc",
    		    colorNumbers: "#eee",
    		    colorPlate: "#222",
    		    borderShadowWidth: 0,
    		    borders: true,
    		    needleType: "arrow",
    		    needleWidth: 2,
    		    needleCircleSize: 7,
    		    needleCircleOuter: true,
    		    needleCircleInner: false,
    		    animationDuration: 1500,
    		    animationRule: "linear",
    		    colorBorderOuter: "#333",
    		    colorBorderOuterEnd: "#111",
    		    colorBorderMiddle: "#222",
    		    colorBorderMiddleEnd: "#111",
    		    colorBorderInner: "#111",
    		    colorBorderInnerEnd: "#333",
    		    colorNeedleShadowDown: "#333",
    		    colorNeedleCircleOuter: "#333",
    		    colorNeedleCircleOuterEnd: "#111",
    		    colorNeedleCircleInner: "#111",
    		    colorNeedleCircleInnerEnd: "#222",
    		    valueBoxBorderRadius: 0,
    		    colorValueBoxRect: "#222",
    		    colorValueBoxRectEnd: "#333"
    	}
    }
    	 --%>
    	 
    <%-- $.ajax({
        type: "GET",
        url: "<%=Config.this_SERVER_path%>/cpvm"
        	 + "?method=" + 'monitoring'
        	 + "&processCode=PC60",
        success: function (data) {
        	tempData = data;
        	console.log(data);
        	console.log(data[0].sensorId);
        	for(let i in data) {
        		var censor_no = data[i].sensorId;
        		$('#autonixTemp').append('<canvas id="' + censor_no + '" class="test"></canvas>');
        		gaugeBuilder(censor_no, commonOpts).draw();
        	}
        	
        	gaugeList = document.gauges;
            
            for(var i = 0; i < gaugeList.length; i++) {
            	var temperature = data[i].sensorValue;
            	var location = data[i].sensorName;
            	var minValue = data[i].minValue;
            	var maxValue = data[i].maxValue;

            	gaugeList[i].update({
            		value: temperature,
            		title: location,
            		highlights: setHighlightsValue(minValue, maxValue)
            	});
            	
            	gaugeList[i].minLimit = minValue;
            	gaugeList[i].maxLimit = maxValue;
            	
                judgeTemp(i);
            }
            
            checkAndUpdateTempOnScreen();
        }
    }); --%>
	
    //}
    
    //getData();
    
    <%-- // Check and update temperature on screen
    var checkAndUpdateTempOnScreen = function() {
	    interVal = setInterval(function() {
	        $.ajax({
	            type: "GET",
	            url: "<%=Config.this_SERVER_path%>/cpvm"
	           	 + "?method=" + 'monitoring'
	           	 + "&processCode=PC60",
	            success: function (data) {
	                gaugeList = document.gauges;
	                
	                for(var i=0; i<gaugeList.length; i++) {
	                    gaugeList[i].value = data[i].sensorValue;
	                    //judgeTemp(i);
	                }
	            }
	        });
	    }, 1000*10*1);
    }
     --%>
 	
     
});

//Check temperature and change circle color as red or blue in the gauge
function judgeTemp(index) {
	var gauge = gaugeList[index];

	// this will draw red or blue circle on a gauge plate depending on
    // current value
    gauge.on('beforeNeedle', function () {
    	var curTemp = Number(this.options.value);
    	var min = Number(this.minLimit);
    	var max = Number(this.maxLimit);
    	
        // getting canvas 2d drawing context
        var context = this.canvas.context;
 
        // we can use gauge context special 'max' property which represents
        // gauge radius in a real pixels and calculate size of relative pixel
        // for our drawing needs
        var pixel = context.max / 100;

        // step out our circle center coordinate by 30% of its radius from
        // gauge center
        var centerX = 30 * pixel;
        // stay in center by Y-coordinate
        var centerY = 0;
        // use circle radius equal to 5%
        var radius = 5 * pixel;
        // save previous context state
        context.save();

        // draw circle using canvas JS API
        context.beginPath();
        context.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);

        var gradient = context.createRadialGradient(
			            centerX, centerY, 0,
			            centerX, centerY, radius);
        
        if(curTemp <= max && curTemp >= min) {
            gradient.addColorStop(0, '#aaf');
            gradient.addColorStop(0.82, '#00f');
            gradient.addColorStop(1, '#88a');
        } else {
            gradient.addColorStop(0, '#faa');
            gradient.addColorStop(0.82, '#f00');
            gradient.addColorStop(1, '#a88');
        }
        
        context.fillStyle = gradient;
        context.fill();
        context.closePath();

        // restore previous context state to prevent break of
        // further drawings
        context.restore();
	});

    // redraw the gauge if it has been already drawn
    gauge.draw();
}

function mergeOptions(obj1, obj2) {
	var newObj = new Object();
	
	return Object.assign(newObj, obj1, obj2);
}

function setHighlightsValue(min, max) {
	var highlights = [
		{"from": -50, "to": min, "color": "rgba(255, 0, 0, .3)"},
        {"from": min, "to": max, "color": "rgba(0, 0, 255, .3)"},
        {"from": max, "to": 50, "color": "rgba(255, 0, 0, .3)"}	
	];
	
	return highlights;
}

function gaugeBuilder(canvasId, additionalOption) {
	return new RadialGauge(
				mergeOptions({ renderTo: canvasId }, additionalOption)
     	   );
}

</script>
