<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
		<title>팝빌 SDK jsp Example.</title>
	</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.PopbillException"%>
<%@page import="com.popbill.api.Response"%>
<%@page import="com.popbill.api.taxinvoice.MgtKeyType"%>

<%
	/*
	 * 역발행 세금계산서를 [취소] 처리합니다.
	 * - [취소]한 세금계산서의 문서번호를 재사용하기 위해서는 삭제 (Delete API) 를 호출해야 합니다.
   * - https://docs.popbill.com/taxinvoice/java/api#CancelRequest
	 */

	// 팝빌회원 사업자번호
	String testCorpNum = "1234567890";

	// 세금계산서 유형. SELL :매출 , BUY : 매입  , TRUSTEE : 수탁
	MgtKeyType keyType = MgtKeyType.BUY;

	// 세금계산서 문서번호
	String mgtKey = "20190107-001";

	// 메모
	String memo = "역발행요청 취소 메모";

	Response CheckResponse = null;

	try {

		CheckResponse = taxinvoiceService.cancelRequest(testCorpNum, keyType, mgtKey, memo);

	} catch (PopbillException pe) {
		//적절한 오류 처리를 합니다. pe.getCode() 로 오류코드를 확인하고, pe.getMessage()로 관련 오류메시지를 확인합니다.
		//예제에서는 exception.jsp 페이지에서 오류를 표시합니다.
		throw pe;
	}

%>
	<div id="content">
		<p class="heading1">Response</p>
		<br/>
		<fieldset class="fieldset1">
			<legend>역발행요청 취소</legend>
			<ul>
				<li>Response.code : <%=CheckResponse.getCode()%></li>
				<li>Response.message : <%=CheckResponse.getMessage()%></li>
			</ul>
		</fieldset>
	 </div>
</html>
