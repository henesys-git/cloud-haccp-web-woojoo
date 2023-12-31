<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen" />
    <title>팝빌 SDK jsp Example.</title>
</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.PopbillException"%>
<%@page import="com.popbill.api.cashbill.CashbillInfo"%>
<%@page import="com.popbill.api.cashbill.CBSearchResult"%>

<%
  /*
	 * 검색조건을 사용하여 현금영수증 목록을 조회합니다.
	 * - https://docs.popbill.com/cashbill/java/api#Search
   */

    // 팝빌회원 사업자번호
    String testCorpNum = "1234567890";

    // 검색일자 유형, R-등록일자, T-거래일자, I-발행일자ㄴ
    String DType = "T";

    // 시작일자, 날짜형태(yyyyMMdd)
    String SDate = "20181201";

    // 종료일자, 날짜형태(yyyyMMdd)
    String EDate = "20190107";

    // 현금영수증 상태코드 배열, 2,3번째 자리에 와일드카드(*) 사용가능
    String[] State = {"100", "2**", "3**", "4**"};

    // 현금영수증 형태 배열, N-일반 현금영수증, C-취소 현금영수증
    String[] TradeType = {"N", "C"};

    // 거래구분 배열, P-소득공제용, C-지출증빙용
    String[] TradeUsage = {"P", "C"};

    // 거래유형 배열, N-일반, B-도서공연, T-대중교통
    String[] TradeOpt = {"N", "B", "T"};

    // 과세형태 배열, T-과세, N-비과세
    String[] TaxationType = {"T", "N"};

    // 현금영수증 식별번호 조회
    String QString = "";

    // 페이지 번호
    int Page = 1;

    // 페이지당 검색개수, 최대 1000개
    int PerPage = 20;

    // 정렬방향, D-내림차순, A-오름차순
    String Order = "D";

    CBSearchResult searchResult = null;

    try {

        searchResult = cashbillService.search(testCorpNum, DType, SDate, EDate, State,
                TradeType, TradeUsage, TaxationType, TradeOpt, QString, Page, PerPage, Order);

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
				<legend>현금영수증 목록 조회</legend>
				<ul>
					<li>code (응답코드) : <%= searchResult.getCode()%></li>
					<li>message (응답메시지) : <%= searchResult.getMessage()%></li>
					<li>total (총 검색결과 건수) : <%= searchResult.getTotal()%></li>
					<li>perPage (페이지당 검색개수) : <%= searchResult.getPerPage()%> </li>
					<li>pageNum (페이지 번호) : <%= searchResult.getPageNum()%></li>
					<li>pageCount (페이지 개수) : <%= searchResult.getPageCount()%></li>
				</ul>
				<%
					CashbillInfo cashbillInfo = null;

          for ( int i = 0; i < searchResult.getList().size(); i++ ) {
                    cashbillInfo = searchResult.getList().get(i);
				%>
				<fieldset class="fieldset2">
					<legend>현금영수증 상태/요약정보 [ <%=i+1%> / <%=searchResult.getList().size()%> ] </legend>
					<ul>
						<li>itemKey (현금영수증 아이템키) : <%= cashbillInfo.getItemKey()%></li>
						<li>mgtKey (문서번호) : <%= cashbillInfo.getMgtKey()%></li>
						<li>tradeDate (거래일자) : <%= cashbillInfo.getTradeDate()%></li>
						<li>tradeType (문서형태) : <%= cashbillInfo.getTradeType()%></li>
						<li>tradeUsage (거래구분) : <%= cashbillInfo.getTradeUsage()%></li>
						<li>tradeOpt (거래유형) : <%= cashbillInfo.getTradeOpt()%></li>
						<li>taxationType (과세형태) : <%= cashbillInfo.getTaxationType()%></li>
						<li>totalAmount (거래금액) : <%= cashbillInfo.getTotalAmount()%></li>
						<li>issueDT (발행일시) : <%= cashbillInfo.getIssueDT()%></li>
						<li>regDT (등록일시) : <%= cashbillInfo.getRegDT()%></li>
						<li>stateMemo (상태메모) : <%= cashbillInfo.getStateMemo()%></li>
						<li>stateCode (상태코드) : <%= cashbillInfo.getStateCode()%></li>
						<li>stateDT (상태변경일시) : <%= cashbillInfo.getStateDT()%></li>
						<li>identityNum (거래처 식별번호) : <%= cashbillInfo.getIdentityNum()%></li>
						<li>itemName (주문 상품명) : <%= cashbillInfo.getItemName()%></li>
						<li>customerName (주문자명) : <%= cashbillInfo.getCustomerName()%></li>
						<li>confirmNum (국세청승인번호) : <%= cashbillInfo.getConfirmNum()%></li>
						<li>orgConfirmNum (원본 현금영수증 승인번호) : <%= cashbillInfo.getOrgConfirmNum()%></li>
						<li>orgTradeDate (원본 현금영수증 거래일자) : <%= cashbillInfo.getOrgTradeDate()%></li>
						<li>ntssendDT (국세청 전송일시) : <%= cashbillInfo.getNtssendDT()%></li>
						<li>ntsresultDT (국세청 처리결과 수신일시) : <%= cashbillInfo.getNtsresultDT()%></li>
						<li>ntsresultCode (국세청 처리결과 상태코드) : <%= cashbillInfo.getNtsresultCode()%></li>
						<li>ntsresultMessage (국세청 처리결과 메시지) : <%= cashbillInfo.getNtsresultMessage()%></li>
						<li>printYN (인쇄여부) : <%= cashbillInfo.isPrintYN()%></li>
					</ul>
				</fieldset>
				<%
					}
				%>
			</fieldset>
		 </div>
	</body>
</html>
