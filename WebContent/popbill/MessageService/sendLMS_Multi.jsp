<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
		<title>팝빌 SDK jsp Example.</title>
	</head>

<%@ include file="common.jsp" %>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.popbill.api.message.Message"%>
<%@page import="com.popbill.api.PopbillException"%>

<%
	/*
	 * [대량전송] LMS(장문)를 전송합니다.
	 *  - 메시지 내용이 2,000Byte 초과시 메시지 내용은 자동으로 제거됩니다.
	 *  - https://docs.popbill.com/message/java/api#SendLMS_Multi
	 */

	// 팝빌회원 사업자번호
	String testCorpNum = "1234567890";

	// 팝빌회원 아이디
	String testUserID = "testkorea";

	// 발신번호
	String sender = "07043042991";

	// 대량문자 제목, 개별전송정보 없는경우
	String subject = "대량문자 제목";

	// 대량문자 내용, 개별전송정보 없는경우
	String content = "대량문자 내용";

	// 광고문자 전송여부
	Boolean adsYN = false;

	// 수신정보배열, 최대 1000건.
	Message[] messages = new Message[2];

	Message msg1 = new Message();
	msg1.setSender("07043042991");      //발신번호
	msg1.setSenderName("발신자1");        //발신자명
	msg1.setReceiver("010111222");      //수신번호
	msg1.setReceiverName("수신자1");      //수신자명
	msg1.setSubject("장문 메시지 제목");    //문자제목
	msg1.setContent("메시지 내용1");       //메시지내용
	messages[0] = msg1;

	Message msg2 = new Message();
	msg2.setSender("07043042991");
	msg2.setSenderName("발신자2");
	msg2.setReceiver("010333444");
	msg2.setReceiverName("수신자2");
	msg2.setSubject("장문 메시지 제목");
	msg2.setContent("메시지 내용2");
	messages[1] = msg1;

	// 예약전송일시(yyyyMMddHHmmss), null인 경우 즉시전송
	Date reserveDT = null;
	//	예약전송시 아래의 코드 참조
	//	String reserveDTtxt ="20141229180000";
	//	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	//	reserveDT = formatter.parse(reserveDTtxt);

	// 전송요청번호
	// 파트너가 전송 건에 대해 관리번호를 구성하여 관리하는 경우 사용.
	// 1~36자리로 구성. 영문, 숫자, 하이픈(-), 언더바(_)를 조합하여 팝빌 회원별로 중복되지 않도록 할당.
	String requestNum = "";

	String receiptNum = null;

	try {

		receiptNum = messageService.sendLMS(testCorpNum, sender, subject, content, messages,
				reserveDT, adsYN, testUserID, requestNum);

	} catch (PopbillException pe) {
		//적절한 오류 처리를 합니다. pe.getCode() 로 오류코드를 확인하고, pe.getMessage()로 관련 오류메시지를 확인합니다.
		//예제에서는 exception.jsp 페이지에서 오류를 표시합니다.
		throw pe;
	}
%>
	<body>
		<div id="content">
			<p class="heading1">Response</p>
			<br/>
			<fieldset class="fieldset1">
				<legend>장문 문자메세지 대량전송</legend>
				<ul>
					<li>접수번호 : <%=receiptNum%></li>
				</ul>
			</fieldset>
		 </div>
	</body>
</html>
