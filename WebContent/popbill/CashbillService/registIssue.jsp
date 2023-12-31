<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
		<title>팝빌 SDK jsp Example.</title>
	</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.Response"%>
<%@page import="com.popbill.api.PopbillException"%>
<%@page import="com.popbill.api.cashbill.Cashbill"%>

<%
    /*
     * 1건의 현금영수증을 [즉시발행]합니다.
     * - 발행일 기준 오후 5시 이전에 발행된 현금영수증은 다음날 오후 2시에 국세청 전송결과를 확인할 수 있습니다.
     * - https://docs.popbill.com/cashbill/java/api#RegistIssue
     */

    // 팝빌회원 사업자번호, '-'제외 10자리
    String testCorpNum = "1234567890";

    // 팝빌회원 아이디
    String testUserID = "testkorea";

    // 메모
    String memo = "발행 메모";

    // 발행안내 메일 제목, 미기재시 기본 양식으로 전송
    String emailSubject = "";

    // 현금영수증 정보 객체
    Cashbill cashbill = new Cashbill();

    // 현금영수증 문서번호, 최대 24자리, 영문, 숫자 '-', '_'를 조합하여 사업자별로 중복되지 않도록 구성
    cashbill.setMgtKey("20191022-007");

    // 문서형태, {승인거래, 취소거래} 중 기재
    cashbill.setTradeType("승인거래");

    // [취소거래 시 필수] 원본 현금영수증 승인번호
    cashbill.setOrgConfirmNum("");

    // [취소거래 시 필수] 원본 현금영수증 거래일자
    cashbill.setOrgTradeDate("");

    // 거래구분, {소득공제용, 지출증빙용} 중 기재
    cashbill.setTradeUsage("소득공제용");

    // 거래유형, {일반, 도서, 대중교통} 중 기재
    cashbill.setTradeOpt("일반");

    //거래처 식별번호, 거래구분에 따라 작성
    //소득공제용 - 주민등록/휴대폰/카드번호 기재가능
    //지출증빙용 - 사업자번호/주민등록/휴대폰/카드번호 기재가능
    cashbill.setIdentityNum("0101112222");

    // 과세형태, {과세, 비과세} 중 기재
    cashbill.setTaxationType("과세");

    // 공급가액, 숫자만 가능
    cashbill.setSupplyCost("10000");

    // 부가세, 숫자만 가능
    cashbill.setTax("1000");

    // 봉사료, 숫자만 가능
    cashbill.setServiceFee("0");

    // 거래금액, 숫자만 가능, 봉사료 + 공급가액 + 부가세
    cashbill.setTotalAmount("11000");

    // 가맹점 사업자번호, '-'제외 10자리
    cashbill.setFranchiseCorpNum(testCorpNum);

    // 가맹점 상호
    cashbill.setFranchiseCorpName("가맹점 상호");

    // 가맹점 대표자성명
    cashbill.setFranchiseCEOName("가맹점 대표자");

    // 가맹점 주소
    cashbill.setFranchiseAddr("가맹점 주소");

    // 가맹점 연락처
    cashbill.setFranchiseTEL("07043042991");

    // 발행시 안내문자 전송여부
    cashbill.setSmssendYN(false);

    // 거래처 주문자명
    cashbill.setCustomerName("주문자명");

    // 거래처 주문상품명
    cashbill.setItemName("주문상품명");

    // 거래처 주문번호
    cashbill.setOrderNumber("주문번호");

    // 거래처 이메일
    // 팝빌 개발환경에서 테스트하는 경우에도 안내 메일이 전송되므로,
    // 실제 거래처의 메일주소가 기재되지 않도록 주의
    cashbill.setEmail("test@test.com");

    // 거래처 휴대폰
    cashbill.setHp("010111222");

    // 거래처 팩스
    cashbill.setFax("070111222");

    Response CheckResponse = null;

    try {

        CheckResponse = cashbillService.registIssue(testCorpNum, cashbill, memo, testUserID, emailSubject);

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
				<legend>현금영수증 즉시발행</legend>
				<ul>
					<li>Response.code : <%=CheckResponse.getCode()%></li>
					<li>Response.message : <%=CheckResponse.getMessage()%></li>
				</ul>
			</fieldset>
		 </div>
	</body>
</html>
