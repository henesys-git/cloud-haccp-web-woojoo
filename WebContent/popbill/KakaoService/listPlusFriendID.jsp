<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen"/>
    <title>팝빌 SDK jsp Example.</title>
</head>

<%@ include file="common.jsp" %>
<%@page import="com.popbill.api.PopbillException" %>
<%@page import="com.popbill.api.kakao.PlusFriendID" %>

<%
    /*
     * 팝빌에 등록된 카카오톡 채널 목록을 반환 합니다.
     * - https://docs.popbill.com/kakao/java/api#ListPlusFriendID
     */

    // 팝빌회원 사업자번호
    String testCorpNum = "6058632975";

    PlusFriendID[] plusFriendIDs = null;

    try {

        plusFriendIDs = kakaoService.listPlusFriendID(testCorpNum);

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
        <legend>카카오톡 채널 목록 확인</legend>
        <%
            for (int i = 0; i < plusFriendIDs.length; i++) {
        %>
        <fieldset class="fieldset2">
            <legend>카카오톡 채널 정보 [<%=i + 1%> / <%=plusFriendIDs.length%>]</legend>
            <ul>
                <li>plusFriendID (카카오톡 채널 아이디) : <%=plusFriendIDs[i].getPlusFriendID()%></li>
                <li>plusFriendName (카카오톡 채널 이름) : <%=plusFriendIDs[i].getPlusFriendName()%></li>
                <li>regDT (등록일시) : <%=plusFriendIDs[i].getRegDT()%></li>
            </ul>
        </fieldset>
        <%
            }
        %>
    </fieldset>
</div>
</html>
