<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen"/>
    <title>팝빌 SDK jsp Example.</title>
</head>
<body>
<div id="content">
    <p class="heading1">팝빌 카카오톡 API SDK jsp Example.</p>
    <br/>
    <fieldset class="fieldset1">
        <legend>플리스친구 계정관리</legend>
        <ul>
            <li><a href="popbill/KakaoService/getPlusFriendMgtURL.jsp">getPlusFriendMgtURL</a> - 카카오톡 채널 계정관리 팝업 URL</li>
            <li><a href="popbill/KakaoService/listPlusFriendID.jsp">listPlusFriendID</a> - 카카오톡 채널 목록 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>발신번호 관리</legend>
        <ul>
            <li><a href="popbill/KakaoService/getSenderNumberMgtURL.jsp">getSenderNumberMgtURL</a> - 발신번호 관리 팝업 URL</li>
            <li><a href="popbill/KakaoService/getSenderNumberList.jsp">getSenderNumberList</a> - 발신번호 목록 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>알림톡 템플릿 관리</legend>
        <ul>
            <li><a href="popbill/KakaoService/getATSTemplateMgtURL.jsp">getATSTemplateMgtURL</a> - 알림톡 템플릿관리 팝업 URL</li>
            <li><a href="popbill/KakaoService/listATSTemplate.jsp">listATSTemplate</a> - 알림톡 템플릿 목록 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>알림톡 / 친구톡 전송</legend>
        <fieldset class="fieldset2">
            <legend>알림톡 전송</legend>
            <ul>
                <li><a href="popbill/KakaoService/sendATS_one.jsp">sendATS</a> - 알림톡 단건 전송</li>
                <li><a href="popbill/KakaoService/sendATS_same.jsp">sendATS</a> - 알림톡 동일내용 대량 전송</li>
                <li><a href="popbill/KakaoService/sendATS_multi.jsp">sendATS</a> - 알림톡 개별내용 대량 전송</li>
            </ul>
        </fieldset>
        <fieldset class="fieldset2">
            <legend>친구톡 텍스트 전송</legend>
            <ul>
                <li><a href="popbill/KakaoService/sendFTS_one.jsp">sendFTS</a> - 친구톡 텍스트 단건 전송</li>
                <li><a href="popbill/KakaoService/sendFTS_same.jsp">sendFTS</a> - 친구톡 텍스트 동일내용 대량전송</li>
                <li><a href="popbill/KakaoService/sendFTS_multi.jsp">sendFTS</a> - 친구톡 텍스트 개별내용 대량전송</li>
            </ul>
        </fieldset>
        <fieldset class="fieldset2">
            <legend>친구톡 이미지 전송</legend>
            <ul>
                <li><a href="popbill/KakaoService/sendFMS_one.jsp">sendFMS</a> - 친구톡 이미지 단건 전송</li>
                <li><a href="popbill/KakaoService/sendFMS_same.jsp">sendFMS</a> - 친구톡 이미지 동일내용 대량전송</li>
                <li><a href="popbill/KakaoService/sendFMS_multi.jsp">sendFMS</a> - 친구톡 이미지 개별내용 대량전송</li>
            </ul>
        </fieldset>
        <fieldset class="fieldset2">
            <legend>예약전송 취소</legend>
            <ul>
                <li><a href="popbill/KakaoService/cancelReserve.jsp">cancelReserve</a> - 예약전송 취소</li>
                <li><a href="popbill/KakaoService/cancelReserveRN.jsp">cancelReserveRN</a> - 예약전송 취소 (요청번호 할당)</li>
            </ul>
        </fieldset>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>정보확인</legend>
        <ul>
            <li><a href="popbill/KakaoService/getMessages.jsp">getMessages</a> - 알림톡/친구톡 전송내역 확인</li>
            <li><a href="popbill/KakaoService/getMessagesRN.jsp">getMessagesRN</a> - 알림톡/친구톡 전송내역 확인 (요청번호 할당)</li>
            <li><a href="popbill/KakaoService/search.jsp">search</a> - 전송내역 목록 조회</li>
            <li><a href="popbill/KakaoService/getSentListURL.jsp">getSentListURL</a> - 카카오톡 전송내역 팝업 URL</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>포인트관리</legend>
        <ul>
            <li><a href="popbill/KakaoService/getBalance.jsp">getBalance</a> - 연동회원 잔여포인트 확인</li>
            <li><a href="popbill/KakaoService/getChargeURL.jsp">getChargeURL</a> 연동회원 포인트충전 URL</li>
            <li><a href="popbill/KakaoService/getPartnerBalance.jsp">getPartnerBalance</a> - 파트너 잔여포인트 확인</li>
            <li><a href="popbill/KakaoService/getPartnerURL.jsp">getPartnerURL</a> - 파트너 포인트충전 URL</li>
            <li><a href="popbill/KakaoService/getUnitCost.jsp">getUnitCost</a> - 전송단가 확인</li>
            <li><a href="popbill/KakaoService/getChargeInfo.jsp">getChargeInfo</a> - 과금정보 확인</li>
        </ul>
    </fieldset>
    <fieldset class="fieldset1">
        <legend>회원관리</legend>
        <ul>
            <li><a href="popbill/KakaoService/checkIsMember.jsp">checkIsMember</a> - 연동회원 가입여부 확인</li>
            <li><a href="popbill/KakaoService/checkID.jsp">checkID</a> - 연동회원 아이디 중복 확인</li>
            <li><a href="popbill/KakaoService/joinMember.jsp">joinMember</a> - 연동회원사 신규가입</li>
            <li><a href="popbill/KakaoService/getAccessURL.jsp">getAccessURL</a> 팝빌 로그인 URL</li>
            <li><a href="popbill/KakaoService/registContact.jsp">registContact</a> - 담당자 추가</li>
            <li><a href="popbill/KakaoService/listContact.jsp">listContact</a> - 담당자 목록 확인</li>
            <li><a href="popbill/KakaoService/updateContact.jsp">updateContact</a> - 담당자 정보 수정</li>
            <li><a href="popbill/KakaoService/getCorpInfo.jsp">getCorpInfo</a> - 회사정보 확인</li>
            <li><a href="popbill/KakaoService/updateCorpInfo.jsp">updateCorpInfo</a> - 회사정보 수정</li>
        </ul>
    </fieldset>
</div>
</body>
</html>
