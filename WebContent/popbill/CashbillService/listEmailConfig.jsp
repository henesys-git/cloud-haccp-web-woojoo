<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
		<title>팝빌 SDK jsp Example.</title>
	</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.PopbillException"%>
<%@page import="com.popbill.api.EmailSendConfig"%>

<%
	/*
	 * 현금영수증 관련 메일전송 항목에 대한 전송여부를 목록으로 반환합니다.
   * - https://docs.popbill.com/cashbill/java/api#ListEmailConfig
	 */

	// 팝빌회원 사업자번호
	String testCorpNum = "1234567890";

	EmailSendConfig[] emailSendConfigs = null;

	try {

		emailSendConfigs = cashbillService.listEmailConfig(testCorpNum);

	} catch (PopbillException pe) {
		//적절한 오류 처리를 합니다. pe.getCode() 로 오류코드를 확인하고, pe.getMessage()로 관련 오류메시지를 확인합니다.
		//예제에서는 exception.jsp 페이지에서 오류를 표시합니다.
		throw pe;
	}
%>
	<body>
	<div id="content">
		<p class="heading1">Response </p>
		<br/>
		<fieldset class="fieldset1">
			<legend>알림메일 전송목록 조회</legend>
			<ul>
				<%
					EmailSendConfig emailSendConfig = null;
					for ( int i = 0; i < emailSendConfigs.length; i++ ) {
						emailSendConfig = emailSendConfigs[i];

						if (emailSendConfig.getEmailType().equals("CSH_ISSUE")) {
				%>
				<li>CSH_ISSUE (고객에게 현금영수증이 발행 되었음을 알려주는 메일 전송 여부) : <%= emailSendConfig.getSendYN()%></li>
				<%
					}
					if (emailSendConfig.getEmailType().equals("CSH_CANCEL")) {
				%>
				<li>CSH_CANCEL (고객에게 현금영수증이 발행취소 되었음을 알려주는 메일 전송 여부) : <%= emailSendConfig.getSendYN()%></li>
				<%
						}
					}
				%>
			</ul>
		</fieldset>
		<ul>
	</div>
	</body>
</html>
