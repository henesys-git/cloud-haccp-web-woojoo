package mes.frame.business.M606;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Vector;

import mes.frame.common.ApprovalActionNo;
import mes.client.conf.Config;
import mes.frame.common.EventDefine;
import mes.frame.common.HashObject;
import mes.frame.common.MessageDefine;
import mes.frame.common.QueueProcessing;
import mes.frame.database.JDBCConnectionPool;
import mes.frame.database.SqlAdapter;
import mes.frame.serviceinterface.InoutParameter;
import mes.frame.serviceinterface.LoggingWriter;
import mes.frame.util.CommonFunction;

public class M606S080100 extends SqlAdapter {
	Connection con = null;
	PreparedStatement pstmt = null;
	String resultString = "";
	int resultInt = -1;
	StringBuffer sql = new StringBuffer();

	String[][] v_paramArray = new String[0][0];
	Class[] optClass = null;
	Object[] optObj = null;
	Object obj = null;

	QueueProcessing Queue = new QueueProcessing();

	public M606S080100() {
	}

	/**
	 * 사용자가 정의해서 파라메터 검증하는 method.
	 * 
	 * @param ioParam , p_sql
	 * @return the desired integer.
	 */
	public int custParamCheck(InoutParameter ioParam, StringBuffer p_sql) {
		int paramInt = 0;
		return paramInt;
	}

	/**
	 * 입력파라메타가 2차원 구조인경우 파라메터 검증하는 method.
	 * 
	 * @param ioParam , p_sql
	 * @return the desired integer.
	 */
	public int paramCheck(InoutParameter ioParam, StringBuffer p_sql) {
		v_paramArray = super.getParamCheck(ioParam, p_sql);
		return v_paramArray[0].length;
	}

	/**
	 * 입력파라메타에서 이벤트ID별로 메소드 호출하는 method.
	 * 
	 * @param ioParam
	 * @return the desired integer.
	 */
	public int doExcute(InoutParameter ioParam) {
		long startTime = System.currentTimeMillis();
		int doExcute_result = EventDefine.E_DOEXCUTE_INIT;
		;
		String event = ioParam.getEventSubID();

		try {
			optClass = new Class[1];
			optClass[0] = ioParam.getClass();
			optObj = new Object[1];
			optObj[0] = ioParam;

			Method method = M606S080100.class.getMethod(event, optClass);
			LoggingWriter.setLogDebug(M606S080100.class.getName(),
					"==== " + event + " EventMethod Create Success ====");

			obj = method.invoke(M606S080100.class.newInstance(), optObj);
			doExcute_result = CommonFunction.getInt(obj.toString());

		} catch (Exception ex) {
			doExcute_result = EventDefine.E_DOEXCUTE_INIT;
			ioParam.setMessage(MessageDefine.M_NO_EVENTID);
			LoggingWriter.setLogError(M606S080100.class.getName(),
					"==== EventID Not define : EVENT ID [ " + ioParam.getEventID() + "]");
		} finally {
			obj = null;
			optClass = null;
			optObj = null;
		}
		long endTime = System.currentTimeMillis();
		long runningTime = endTime - startTime;
		LoggingWriter.setLogAll(M606S080100.class.getName(), "==== Query [수행시간  : " + runningTime + " ms]");

		return doExcute_result;
	}

	//외부 문서 등록이 체크된 항목 조회
	public int E104(InoutParameter ioParam) {
		resultInt = EventDefine.E_DOEXCUTE_INIT;

		try {
			con = JDBCConnectionPool.getConnection();

			// 클라이언트로 부터 받은 파라미터를 옮겨 담는다.
			String rcvData = (String) ((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
			// 클라이언트로 부터 받은 파라미터를 쪼개어서 배열에 담는다.
			// rcvData = [위경도]
			String[][] c_paramArray = CommonFunction.getConvString2DoubleArray(rcvData);
			
			String sql = new StringBuilder()
					.append("SELECT * FROM \n")
					.append("(SELECT A.reg_gubun,\n")
					.append("        A.document_no,\n")
					.append("        B.document_name,\n")
					.append("        B.gubun_code,\n")
					.append("        V.code_name,\n")
					.append("        file_view_name,\n")
					.append("        A.regist_no,\n")
					.append("        A.revision_no,\n")
					.append("        file_real_name,\n")
					.append("        external_doc_yn,\n")
					.append("        regist_reason_code,\n")
					.append("        destroy_reason_code,\n")
					.append("        total_page,\n")
					.append("        gwanribon_yn,\n")
					.append("        keep_yn,\n")
					.append("        hold_yn,\n")
					.append("        d.action_date AS regist_date,\n")
					.append("        d.user_id AS  regist_user_id, \n")
					.append("         A.document_no_rev \n")
					.append("FROM\n")
					.append("		tbi_doc_regist_info A\n")
					.append("		INNER JOIN tbm_doc_base B\n")
					.append("			ON A.document_no       	= B.document_no\n")
					.append("			AND A.member_key = B.member_key\n")
					.append("		INNER JOIN tbi_approval_action D \n")
					.append("			ON A.regist_no = D.actionno\n")
					.append("			AND A.member_key = D.member_key\n")
					.append("		INNER JOIN v_doc_gubun V\n")
					.append("			ON B.gubun_code = V.code_value\n")
					.append("			AND B.member_key = V.member_key\n")
					.append("where B.gubun_code like '" 	+ c_paramArray[0][0] + "%'	\n")
					.append("  AND    A.reg_gubun = 'DOCREG02' \n")
					.append("  AND A.member_key = '" 	+ c_paramArray[0][1] + "'	\n")
					.append("  ORDER BY A.revision_no DESC ) AS AA\n")
					.append("GROUP BY AA.reg_gubun , AA.regist_no\n")
					
//					.append("and   D.action_process like '" 	+ c_paramArray[0][1] + "%'	\n")
					.toString();
			
			String ActionCommand = ioParam.getActionCommand();
			if (ActionCommand.startsWith("doQueryTableFieldName")) {
				resultString = super.excuteQueryStringTableFieldName(con, sql.toString());
			} else {
				;
				resultString = super.excuteQueryString(con, sql.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			LoggingWriter.setLogError("M606S080100E104()", "==== SQL ERROR ====" + e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR;
		} finally {
			if (Config.useDataSource) {
				try {
					if (con != null)
						con.close();
				} catch (Exception e) {
					LoggingWriter.setLogError("M606S080100E104()","==== finally ===="+ e.getMessage());
				}
			} else {
			}
		}
		// 결과 전문 구성을 위한 파라미터들을 아이오 파라미터에 저장한다.
		ioParam.setResultString(resultString);
		// 수퍼에서 처리된 칼럼의 갯수를 클라이언트에게 보내기 위해 가져온다.
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
		// 잘 처리되었다는 메시지를 클라이언트에게 보내기 위해 I/O파라미터에 저장한다.
		ioParam.setMessage(MessageDefine.M_QUERY_OK);
		return EventDefine.E_QUERY_RESULT;
	}

}