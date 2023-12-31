<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen"/>
    <title>팝빌 SDK jsp Example.</title>
</head>
<body>
<div id="content">
    <p class="heading1">팝빌 홈택스연동(현금영수증) SDK jsp Example.</p>
    <br/>
    <fieldset class="fieldset1">
        <legend>홈택스 현금영수증 매입/매출 내역 수집</legend>
        <ul>
            <li><a href="popbill/HTCashbillService/requestJob.jsp">requestJob</a> - 수집 요청</li>
            <li><a href="popbill/HTCashbillService/getJobState.jsp">getJobState</a> - 수집 상태 확인</li>
            <li><a href="popbill/HTCashbillService/listActiveJob.jsp">listActiveJob</a> - 수집 상태 목록 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>홈택스 현금영수증 매입/매출 내역 수집 결과 조회</legend>
        <ul>
            <li><a href="popbill/HTCashbillService/search.jsp">search</a> - 수집 결과 조회</li>
            <li><a href="popbill/HTCashbillService/summary.jsp">summary</a> - 수집 결과 요약정보 조회</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>홈택스연동 인증 관리</legend>
        <ul>
            <li><a href="popbill/HTCashbillService/getCertificatePopUpURL.jsp">getCertificatePopUpURL</a> - 홈택스연동 인증 관리 팝업 URL</li>
            <li><a href="popbill/HTCashbillService/getCertificateExpireDate.jsp">getCertificateExpireDate</a> - 홈택스연동 공인인증서 만료일자 확인</li>
            <li><a href="popbill/HTCashbillService/checkCertValidation.jsp">checkCertValidation</a> - 홈택스 공인인증서 로그인 테스트</li>
            <li><a href="popbill/HTCashbillService/registDeptUser.jsp">registDeptUser</a> - 부서사용자 계정등록</li>
            <li><a href="popbill/HTCashbillService/checkDeptUser.jsp">checkDeptUser</a> - 부서사용자 등록정보 확인</li>
            <li><a href="popbill/HTCashbillService/checkLoginDeptUser.jsp">checkLoginDeptUser</a> - 부서사용자 로그인 테스트</li>
            <li><a href="popbill/HTCashbillService/deleteDeptUser.jsp">deleteDeptUser</a> - 부서사용자 등록정보 삭제</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>포인트 관리 / 정액제 신청</legend>
        <ul>
            <li><a href="popbill/HTCashbillService/getBalance.jsp">getBalance</a> - 연동회원 잔여포인트 확인</li>
            <li><a href="popbill/HTCashbillService/getChargeURL.jsp">getChargeURL</a> - 연동회원 포인트충전 URL</li>
            <li><a href="popbill/HTCashbillService/getPartnerBalance.jsp">getPartnerBalance</a> - 파트너 잔여포인트 확인</li>
            <li><a href="popbill/HTCashbillService/getPartnerURL.jsp">getPartnerURL</a> - 파트너 포인트충전 URL</li>
            <li><a href="popbill/HTCashbillService/getChargeInfo.jsp">getChargeInfo</a> - 과금정보 확인</li>
            <li><a href="popbill/HTCashbillService/getFlatRatePopUpURL.jsp">getFlatRatePopUpURL</a> - 정액제 서비스 신청 URL</li>
            <li><a href="popbill/HTCashbillService/getFlatRateState.jsp">getFlatRateState</a> - 정액제 서비스 상태 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>회원정보</legend>
        <ul>
            <li><a href="popbill/HTCashbillService/checkIsMember.jsp">checkIsMember</a> - 연동회원 가입여부 확인</li>
            <li><a href="popbill/HTCashbillService/checkID.jsp">checkID</a> - 아이디 중복 확인</li>
            <li><a href="popbill/HTCashbillService/joinMember.jsp">joinMember</a> - 연동회원 신규가입</li>
            <li><a href="popbill/HTCashbillService/getAccessURL.jsp">getAccessURL</a> - 팝빌 로그인 URL</li>
            <li><a href="popbill/HTCashbillService/getCorpInfo.jsp">getCorpInfo</a> - 회사정보 확인</li>
            <li><a href="popbill/HTCashbillService/updateCorpInfo.jsp">updateCorpInfo</a> - 회사정보 수정</li>
            <li><a href="popbill/HTCashbillService/registContact.jsp">registContact</a> - 담당자 등록</li>
            <li><a href="popbill/HTCashbillService/listContact.jsp">listContact</a> - 담당자 목록 확인</li>
            <li><a href="popbill/HTCashbillService/updateContact.jsp">updateContact</a> - 담당자 정보 수정</li>
        </ul>
    </fieldset>    
</div>
</body>
</html>
