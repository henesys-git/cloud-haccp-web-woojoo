<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
		<title>팝빌 SDK jsp Example.</title>
	</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.PopbillException"%>

<%
	/*
	 * 은행 계좌 관리 팝업 URL을 확인한다.
	 * - 반환된 URL은 보안정책에 따라 30초의 유효시간을 갖습니다.
   * - https://docs.popbill.com/easyfinbank/java/api#GetBankAccountMgtURL
	 */

	// 팝빌회원 사업자번호
	String testCorpNum = "1234567890";

	String url = null;

	try {

		url = easyFinBankService.getBankAccountMgtURL(testCorpNum);

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
				<legend>은행 계좌 관리 팝업 URL</legend>
				<ul>
					<li>url : <%=url%> </li>
				</ul>
		  </fieldset>
		</div>
	</body>
</html>
