<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- HENESYS -->
<%@ page language="java" import="java.sql.*,java.util.*,javax.servlet.http.*"%>
<%@ page import="mes.client.comm.*"%>
<%@ page import="mes.client.common.*"%>
<%@ page import="mes.client.guiComponents.*"%>
<%@ page import="mes.client.util.*"%>
<%@ page import="mes.client.conf.*"%>
<!-- HENESYS END -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="popbill/resources/main.css" media="screen"/>
    <title>팝빌 SDK jsp Example.</title>
</head>

<%@ include file="common.jsp" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.popbill.api.PopbillException" %>
<%@page import="com.popbill.api.kakao.KakaoButton" %>



<%
	String loginID = session.getAttribute("login_id").toString();
	if(loginID==null||loginID.equals("")){                            // id가 Null 이거나 없을 경우
		response.sendRedirect("Contents/index.jsp");    // 로그인 페이지로 리다이렉트 한다.
	}
  	 
  	String censor_name = request.getParameter("censor_name");
  	String censor_value = request.getParameter("censor_value");
  	String min_value = request.getParameter("min_value");
  	String max_value = request.getParameter("max_value");
  	 
%>


<%
    /*
     * 알림톡 전송을 요청합니다.
     * 사전에 승인된 템플릿의 내용과 알림톡 전송내용(content)이 다를 경우 전송실패 처리됩니다.
     * - https://docs.popbill.com/kakao/java/api#SendATS_one
     */

    // 팝빌회원 사업자번호
    String testCorpNum = "6058632975";

    // 알림톡 템플릿코드
    // 승인된 알림톡 템플릿 코드는 ListATStemplate API, GetATSTemplateMgtURL API, 또는 팝빌사이트에서 확인 가능합니다.
    String templateCode = "020110000240";

    //발신번호 (팝빌에 등록된 발신번호만 이용가능)
    String senderNum = "01079007349";

    // 알림톡 내용 (최대 1000자)
//     String content = "[ 팝빌 ]\n";
//     content += "신청하신 #{템플릿코드}에 대한 심사가 완료되어 승인 처리되었습니다.\n";
//     content += "해당 템플릿으로 전송 가능합니다.\n\n";
//     content += "문의사항 있으시면 파트너센터로 편하게 연락주시기 바랍니다.\n\n";
//     content += "팝빌 파트너센터 : 1600-8536\n";
//     content += "support@linkhub.co.kr";
    
//     String content = " <#{"+censor_name+"}>\n";
//     content += "한계기준이탈\n";
//     content += "한계 기준 : #{"+min_value+"} ~ #{"+max_value+"}\n\n";
//     content += "센서 데이터 : #{"+censor_value+"}\n\n";
    
    String content = " <"+censor_name+">\n";
    content += "한계기준이탈\n";
    content += "한계 기준 : "+min_value+" ~ "+max_value+"\n\n";
    content += "센서 데이터 : "+censor_value+"\n\n";
    
    // 대체문자 내용 (최대 2000byte)
    String altContent = "대체문자 내용";

    // 대체문자 유형 [공백-미전송, C-알림톡내용, A-대체문자내용]
    String altSendType = "A";

    // 수신번호
    String receiverNum = "01079007349";
//     receiverNum += "01046485362";

    // 수신자 이름
    String receiverName = "김법중";

    // 예약일시 (작성형식 : yyyyMMddHHmmss)
    String sndDT = "";

    // 팝빌회원 아이디
    String testUserID = "don0420";

    // 전송요청번호
    // 파트너가 전송 건에 대해 관리번호를 구성하여 관리하는 경우 사용.
    // 1~36자리로 구성. 영문, 숫자, 하이픈(-), 언더바(_)를 조합하여 팝빌 회원별로 중복되지 않도록 할당.
    String requestNum = "";

    // 접수번호
    String receiptNum = null;

    // 알림톡 버튼정보를 템플릿 신청시 기재한 버튼정보와 동일하게 전송하는 경우 null 처리.
    KakaoButton[] btns = null;

    // 알림톡 버튼 URL에 #{템플릿변수}를 기재한경우 템플릿변수 영역을 변경하여 버튼정보 구성
    // KakaoButton[] btns = new KakaoButton[1];
    //
    // KakaoButton button = new KakaoButton();
    // button.setN("버튼명"); // 버튼명
    // button.setT("WL"); // 버튼타입
    // button.setU1("https://www.popbill.com"); // 버튼링크1
    // button.setU2("http://test.popbill.com"); // 버튼링크2
    // btns[0] = button;

    try {

        receiptNum = kakaoService.sendATS(testCorpNum, templateCode, senderNum, content, altContent, altSendType,
                receiverNum, receiverName, sndDT, testUserID, requestNum, btns);

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
        <legend>알림톡 전송</legend>
        <ul>
            <li>접수번호 : <%=receiptNum%></li>
        </ul>
    </fieldset>
</div>
</body>
</html>
