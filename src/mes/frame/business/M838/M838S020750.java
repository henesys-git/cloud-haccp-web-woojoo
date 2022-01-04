package mes.frame.business.M838;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import mes.client.conf.Config;
import mes.frame.business.M707.M707S010600;
import mes.frame.common.EventDefine;
import mes.frame.common.HashObject;
import mes.frame.common.MessageDefine;
import mes.frame.database.JDBCConnectionPool;
import mes.frame.database.SqlAdapter;
import mes.frame.serviceinterface.InoutParameter;
import mes.frame.serviceinterface.LoggingWriter;
import mes.frame.util.CommonFunction;


/*
 * 일일위생점검일지
 * 
 * 작성자: 서승헌
 * 일시: 2021-04-06
 * 
 * */


/**
 * 개요 : 이벤트ID별 메소드 정의
 */
public class M838S020750 extends SqlAdapter {

	static final Logger logger = Logger.getLogger(M838S020750.class.getName());
	
	Connection con = null;
	PreparedStatement pstmt = null;
	String resultString = "";
	int resultInt = -1;
	StringBuffer sql = new StringBuffer();
	
	String[][] v_paramArray = new String[0][0]; 
	Class[] optClass = null;
	Object[] optObj = null;
	Object obj = null;
	
	public M838S020750(){
	}
	
	/**
	 * 사용자가 정의해서 파라메터 검증하는 method.
	 * @param	ioParam , p_sql
	 * @return the desired integer.
	 */
	public int custParamCheck(InoutParameter ioParam, StringBuffer p_sql){
		int paramInt = 0;
		return paramInt;
	}
	/**
	 * 입력파라메타가 2차원 구조인경우 파라메터 검증하는 method.
	 * @param	ioParam , p_sql
	 * @return the desired integer.
	 */
	public int paramCheck(InoutParameter ioParam, StringBuffer p_sql){
		v_paramArray = super.getParamCheck(ioParam,p_sql);
		return v_paramArray[0].length;
	}
	/**
	 * 입력파라메타에서 이벤트ID별로 메소드 호출하는 method.
	 * @param	ioParam
	 * @return the desired integer.
	 */
	public int doExcute(InoutParameter ioParam){
		long startTime = System.currentTimeMillis();
		int doExcute_result = EventDefine.E_DOEXCUTE_INIT;;
		String event = ioParam.getEventSubID();

	    try{
            optClass = new Class[1];
			optClass[0] = ioParam.getClass() ;
			optObj = new Object[1];
			optObj[0] = ioParam;
			
			Method method = M838S020750.class.getMethod(event,optClass);
			logger.debug(event + " EventMethod Create Success");

			obj = method.invoke(M838S020750.class.newInstance(),optObj);
			doExcute_result = CommonFunction.getInt(obj.toString());
			
	    } catch (Exception ex) {
	    	doExcute_result = EventDefine.E_DOEXCUTE_INIT;
			ioParam.setMessage(MessageDefine.M_NO_EVENTID);
			logger.error("EventID Not define : EVENT ID [ " + ioParam.getEventID() + "]");
	    } finally {
	    	obj = null;
			optClass = null;
			optObj = null;
	    }
	    long endTime = System.currentTimeMillis();
		long runningTime = endTime - startTime;
		logger.debug("Query 수행시간  : " + runningTime + " ms");
		
		return doExcute_result;
	}
	
	// 등록
	public int E101(InoutParameter ioParam){ 
		resultInt = EventDefine.E_DOEXCUTE_INIT;

		try {
			con = JDBCConnectionPool.getConnection();
			con.setAutoCommit(false);
			
    		JSONObject jObj = new JSONObject();
    		jObj = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
    		
    		String checklist_id = jObj.get("checklist_id").toString();
    		String check_date = jObj.get("check_date").toString();
    		
    		JSONArray types = new JSONArray();
    		types = (JSONArray) jObj.get("types");
    		
    		String sql = new StringBuilder()
    				.append("INSERT INTO\n")
    				.append("	haccp_subsidiary_warehouse (\n")
    				.append("		check_date,\n")
    				.append("		checklist_id,\n")
    				.append("		checklist_rev_no,\n")
    				.append("		improve_action,\n")
    				.append("		unsuit_detail,\n")
    				.append("		person_write_id\n")
    				.append("	)\n")
    				.append("VALUES\n")
    				.append("	(\n")
    				.append("		'"+check_date+"',\n")
    				.append("		'"+checklist_id+"',\n")
    				.append("		(SELECT MAX(checklist_rev_no)				\n")
    				.append("		FROM checklist								\n")
    				.append("		WHERE checklist_id = '"+checklist_id+"'),	\n")
    				.append("		'"+jObj.get("unsuit_detail").toString()+"',\n")
    				.append("		'"+jObj.get("improve_action").toString()+"', \n")
    				.append("		'"+jObj.get("person_write_id").toString()+"'\n")
    				.append("	) \n")
    				.toString();

    		resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0) {
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
			
	    	logger.debug("just before loop");
	    	for(int i = 0; i < 11; i++) {
	    		logger.debug("##loop entered!");
	    		logger.debug(types);
	    		
	    		JSONObject result = (JSONObject) types.get(i);
	    		logger.debug(result);
	    		
				String question_id = result.get("question_id").toString(); 
				String name = result.get("name").toString(); 
				String value = result.get("value").toString();
				String type_id = result.get("type_id").toString(); 
				String type_id_s = result.get("type_id_s").toString();
				
				sql = new StringBuilder()
						.append("INSERT INTO\n")
						.append("	haccp_subsidiary_warehouse_result (\n")
						.append("		check_date,\n")
						.append("		type_id,\n")
						.append("		type_id_s,\n")
						.append("		type_rev_no,\n")
						.append("		question_id,\n")
						.append("		check_result\n")
						.append("	)\n")
						.append("VALUES\n")
						.append("	(\n")
						.append("		'"+check_date+"',\n")
						.append("		'"+type_id+"',\n")
						.append("		'"+type_id_s+"',\n")
						.append("		(SELECT MAX(type_rev_no)				\n")
						.append("		 FROM haccp_subsidiary_warehouse_check_type	\n")
						.append("		 WHERE type_id = '"+type_id+"'),		\n")
						.append("		'"+question_id+"',\n")
						.append("		'"+value+"'\n")
						.append("	) \n")
						.toString();

				logger.debug("question_id : "+question_id+ " / name : "+name+" / value : "+value);
				logger.debug("type_id : "+type_id+ " / type_id_s : "+type_id_s);
				
				resultInt = super.excuteUpdate(con, sql);
		    	if(resultInt < 0) {
					ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
					con.rollback();
					return EventDefine.E_DOEXCUTE_ERROR ;
				}
				
	    	}
	    	
			con.commit();
		} catch(Exception e) {
			e.getStackTrace();
			LoggingWriter.setLogError("M838S020750E101()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);
	    return EventDefine.E_QUERY_RESULT;
	}
		
	// 수정
	// result - delete / main - update / result - insert
	public int E102(InoutParameter ioParam){ 
		resultInt = EventDefine.E_DOEXCUTE_INIT;

		try {
			con = JDBCConnectionPool.getConnection();
			con.setAutoCommit(false);
			
    		JSONObject jObj = new JSONObject();
    		jObj = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
    		
    		String check_date = jObj.get("check_date").toString();
    		
    		JSONArray types = new JSONArray();
    		types = (JSONArray) jObj.get("types");
    		
    		String sql = new StringBuilder()
    				.append("DELETE FROM\n")
    				.append("	haccp_subsidiary_warehouse_result\n")
    				.append("WHERE\n")
    				.append("	check_date = '"+check_date+"'\n")
    				.toString();
    		
    		resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0) {
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
	    	
	    	sql = new StringBuilder()
	    			.append("UPDATE\n")
	    			.append("	haccp_subsidiary_warehouse\n")
	    			.append("SET\n")
	    			.append("	improve_action = '"+jObj.get("improve_action").toString()+"', \n")
	    			.append("	unsuit_detail = '"+jObj.get("unsuit_detail").toString()+"',	  \n")
	    			.append("	person_write_id = '"+jObj.get("person_write_id").toString()+"',\n")
	    			.append("	person_check_id  = '',\n")
	    			.append("	person_approve_id  = ''\n")
	    			.append("WHERE\n")
    				.append("	check_date = '"+check_date+"'\n")
	    			.toString();

    		resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0) {
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
			
	    	logger.debug("just before loop");
	    	for(int i = 0; i < 11; i++) {
	    		logger.debug("##loop entered!");
	    		logger.debug(types);
	    		
	    		JSONObject result = (JSONObject) types.get(i);
	    		logger.debug(result);
	    		
				String question_id = result.get("question_id").toString(); 
				String name = result.get("name").toString(); 
				String value = result.get("value").toString();
				String type_id = result.get("type_id").toString(); 
				String type_id_s = result.get("type_id_s").toString();
				
				sql = new StringBuilder()
						.append("INSERT INTO\n")
						.append("	haccp_subsidiary_warehouse_result (\n")
						.append("		check_date,\n")
						.append("		type_id,\n")
						.append("		type_id_s,\n")
						.append("		type_rev_no,\n")
						.append("		question_id,\n")
						.append("		check_result\n")
						.append("	)\n")
						.append("VALUES\n")
						.append("	(\n")
						.append("		'"+check_date+"',\n")
						.append("		'"+type_id+"',\n")
						.append("		'"+type_id_s+"',\n")
						.append("		(SELECT MAX(type_rev_no)				\n")
						.append("		 FROM haccp_subsidiary_warehouse_check_type	\n")
						.append("		 WHERE type_id = '"+type_id+"'),		\n")
						.append("		'"+question_id+"',\n")
						.append("		'"+value+"'\n")
						.append("	) \n")
						.toString();
				
				resultInt = super.excuteUpdate(con, sql);
		    	if(resultInt < 0) {
					ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
					con.rollback();
					return EventDefine.E_DOEXCUTE_ERROR ;
				}
	    	}
	    	
			con.commit();
		} catch(Exception e) {
			e.getStackTrace();
			LoggingWriter.setLogError("M838S020750E102()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);
	    return EventDefine.E_QUERY_RESULT;
	}
	
	// 삭제
	public int E103(InoutParameter ioParam){ 
		resultInt = EventDefine.E_DOEXCUTE_INIT;

		try {
			con = JDBCConnectionPool.getConnection();
			con.setAutoCommit(false);
			
    		JSONObject jObj = new JSONObject();
    		jObj = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
    		
    		String checklist_id = jObj.get("checklist_id").toString();
    		int checklist_rev_no = Integer.parseInt(jObj.get("checklist_rev_no").toString());
    		String check_date = jObj.get("check_date").toString();
    		
    		String sql = new StringBuilder()
    				.append("DELETE FROM\n")
    				.append("	haccp_subsidiary_warehouse_result \n")
    				.append("WHERE\n")
    				.append("	check_date = '"+check_date+"'\n")
    				.toString();
    		
    		resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0) {
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
	    	
	    	sql = new StringBuilder()
    				.append("DELETE FROM\n")
    				.append("	haccp_subsidiary_warehouse \n")
    				.append("WHERE\n")
    				.append("	checklist_id = '"+checklist_id+"'\n")
    				.append("	AND checklist_rev_no = "+checklist_rev_no+"\n")
    				.append("	AND check_date = '"+check_date+"'\n")
    				.toString();
    		
    		resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0) {
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
	    	
			con.commit();
		} catch(Exception e) {
			e.getStackTrace();
			LoggingWriter.setLogError("M838S020750E103()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);
	    return EventDefine.E_QUERY_RESULT;
	}
	
	// 메인 조회
	public int E104(InoutParameter ioParam){
		resultInt = EventDefine.E_DOEXCUTE_INIT;
		
		try {
			con = JDBCConnectionPool.getConnection();
			
			JSONObject jArray = new JSONObject();
			jArray = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
			
			String sql = new StringBuilder()
					.append("SELECT\n")
					.append("	checklist_id,\n")
					.append("	checklist_rev_no,\n")
					.append("	check_date,\n")
					.append("	improve_action,\n")
					.append("	unsuit_detail,\n")
					.append("	C.user_nm as person_write_id,\n")
					.append("	D.user_nm as person_check_id,\n")
					.append("	E.user_nm as person_approve_id\n")
					.append("FROM\n")
					.append("	haccp_subsidiary_warehouse B \n")
					.append("LEFT JOIN tbm_users C														\n")
					.append("	ON B.person_write_id = C.user_id										\n")
					.append("	AND  check_date BETWEEN CAST(C.start_date AS DATE) AND CAST(C.duration_date AS DATE) \n")
					.append("	LEFT JOIN tbm_users D													\n")
					.append("	ON B.person_check_id = D.user_id										\n")
					.append("	AND  check_date BETWEEN CAST(D.start_date AS DATE) AND CAST(D.duration_date AS DATE) \n")
					.append("	LEFT JOIN tbm_users E													\n")
					.append("	ON B.person_approve_id = E.user_id										\n")
					.append("	AND  check_date BETWEEN CAST(E.start_date AS DATE) AND CAST(E.duration_date AS DATE) \n")
					.append("ORDER BY check_date DESC \n")
					.toString();

			resultString = super.excuteQueryString(con, sql);
		} catch(Exception e) {
			e.printStackTrace();
			LoggingWriter.setLogError("M838S020750E104()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR ;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) {
						con.close();
					}
				} catch (Exception e) {
					LoggingWriter.setLogError("M838S020750E104()","==== finally ===="+ e.getMessage());
				}
	    	}
	    }

		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);

    	return EventDefine.E_QUERY_RESULT;
	}
	
	// 체크리스트 질문 목록 조회 쿼리 -> 등록부분에서 사용(0407)
	public int E114(InoutParameter ioParam){
		resultInt = EventDefine.E_DOEXCUTE_INIT;
		
		try {
			con = JDBCConnectionPool.getConnection();
			
			JSONObject jArray = new JSONObject();
			jArray = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
			
			String checkDate = jArray.get("check_date").toString();
			
			String sql = new StringBuilder()
					.append("WITH table1 AS													\n")
					.append("(																\n")
					.append("SELECT															\n")
					.append("	B.type_id,													\n")
					.append("	B.type_id_s,												\n")
					.append("	B.type_nm,													\n")
					.append("	A.question_id,												\n")
					.append("	A.question_detail											\n")
					.append("FROM															\n")
					.append("	haccp_subsidiary_warehouse_question A						\n")
					.append("INNER JOIN haccp_subsidiary_warehouse_check_type B				\n")
					.append("	ON A.type_id_s = B.type_id_s								\n")
					.append("	AND A.type_rev_no = B.type_rev_no							\n")
					.append(")																\n")
					.append("-- WITH절 끝														\n")
					.append("SELECT 														\n")
					.append("	DISTINCT type_nm,											\n")
					.append("	type_id,													\n")
					.append("	type_id_s,													\n")
					.append("	LIST(SELECT REPLACE(question_detail, ',', 'comma')			\n")
					.append("	-- 리스트 시 구분자가 콤마여서, 질문 안의 콤마는 comma 문자열로 대체, 클라이언트에서 재변환\n")
					.append("		 FROM table1 t1											\n")
					.append("		 WHERE t1.type_nm = t2.type_nm)							\n")
					.append("FROM table1 t2													\n")
					.append("ORDER BY t2.type_id_s ASC										\n")
					.toString();

			resultString = super.excuteQueryString(con, sql);
		} catch(Exception e) {
			e.printStackTrace();
			LoggingWriter.setLogError("M838S020750E114()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR ;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
					LoggingWriter.setLogError("M838S020750E114()","==== finally ===="+ e.getMessage());
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);

    	return EventDefine.E_QUERY_RESULT;
	}
	
	// 점검표 캔버스 조회용 쿼리
	public int E144(InoutParameter ioParam){
		resultInt = EventDefine.E_DOEXCUTE_INIT;
		
		try {
			con = JDBCConnectionPool.getConnection();
			
			JSONObject jArray = new JSONObject();
			jArray = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
			
	//		String check_date = jArray.get("checklistDate").toString();
			String checkDate = jArray.get("check_date").toString();
		
			String sql = new StringBuilder()
					.append("WITH table1 AS 															\n")
					.append("(																			\n")
					.append("SELECT 																	\n")
					.append("	dd - DAYOFWEEK(dd) + LEVEL  + 1 AS dates,								\n")
					.append("	TO_CHAR((dd - DAYOFWEEK(dd) + LEVEL + 1), 'day') AS days				\n")
					.append("FROM																		\n")
					.append("	(SELECT ADD_MONTHS(LAST_DAY('"+checkDate+"')+1,-1) AS dd)				\n")
					.append("CONNECT BY LEVEL <= 35														\n")
					.append(")																			\n")
					.append(",table2 AS 																\n")
					.append("(																			\n")
					.append("SELECT 																	\n")
					.append("	DISTINCT A.check_date,													\n")
					.append("	LIST(SELECT CASE WHEN A2.check_result = 'Y' THEN 'O' ELSE 'X' END		\n")
					.append("		 FROM haccp_subsidiary_warehouse_result A2							\n")
					.append("		 WHERE A2.check_date = A.check_date									\n")
					.append("		 ORDER BY question_id ASC) AS result,								\n")
					.append("	B.unsuit_detail,														\n")
					.append("	B.improve_action,														\n")
					.append("	C.user_nm AS person_write_id,											\n")
					.append("	D.user_nm AS person_check_id,											\n")
					.append("	E.user_nm AS person_approve_id											\n")
					.append("FROM haccp_subsidiary_warehouse_result  A									\n")
					.append("INNER JOIN haccp_subsidiary_warehouse  B									\n")
					.append("	ON A.check_date = B.check_date											\n")
					.append("LEFT JOIN tbm_users C														\n")
					.append("	ON B.person_write_id = C.user_id										\n")
					.append("AND  A.check_date BETWEEN CAST(C.start_date AS DATE) AND CAST(C.duration_date AS DATE) \n")
					.append("	LEFT JOIN tbm_users D													\n")
					.append("		ON B.person_check_id = D.user_id									\n")
					.append("	AND  A.check_date BETWEEN CAST(D.start_date AS DATE) AND CAST(D.duration_date AS DATE) \n")
					.append("	LEFT JOIN tbm_users E													\n")
					.append("		ON B.person_approve_id = E.user_id									\n")
					.append("	AND  A.check_date BETWEEN CAST(E.start_date AS DATE) AND CAST(E.duration_date AS DATE) 	\n")
					.append("	)																		\n")
					.append("	SELECT 																	\n")
					.append("		MONTH(table1.dates) || '/' || DAY(table1.dates) AS dates,			\n")
					.append("		table2.result,														\n")
					.append("		table2.unsuit_detail,												\n")
					.append("		table2.improve_action,												\n")
					.append("		person_write_id,													\n")
					.append("		person_check_id,													\n")
					.append("		person_approve_id													\n")
					.append("	FROM table1																\n")
					.append("	LEFT JOIN table2														\n")
					.append("		ON table1.dates = table2.check_date\n")
					.append("	WHERE TO_CHAR(table2.check_date,'YYYYMM') = TO_CHAR(date'"+checkDate+"', 'YYYYMM')	\n")
					.append("	AND ROWNUM <= 5\n")
					.toString();

			resultString = super.excuteQueryString(con, sql);
		} catch(Exception e) {
			e.printStackTrace();
			LoggingWriter.setLogError("M838S020750E144()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR ;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
					LoggingWriter.setLogError("M838S020750E144()","==== finally ===="+ e.getMessage());
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);

    	return EventDefine.E_QUERY_RESULT;
	}
	
	// 수정 시 기존 데이터 넣기 위한 쿼리
	public int E154(InoutParameter ioParam){
		resultInt = EventDefine.E_DOEXCUTE_INIT;
		
		try {
			con = JDBCConnectionPool.getConnection();
			
			JSONObject jArray = new JSONObject();
			jArray = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
			
			String checkDate = jArray.get("check_date").toString();
			
			String sql = new StringBuilder()
					.append("SELECT DISTINCT \n")
					.append("					A.check_date,								\n")
					.append("					LIST(SELECT check_result 					\n")
					.append("					 	  FROM haccp_subsidiary_warehouse_result A2		\n")
					.append("						  WHERE A2.check_date = A.check_date	\n")
					.append("						  ORDER BY question_id ASC) AS result,	\n")
					.append("					B.unsuit_detail,							\n")
					.append("					B.improve_action,							\n")
					.append("					C.user_nm AS person_write_id,				\n")
					.append("					D.user_nm AS person_check_id,				\n")
					.append("					E.user_nm  AS person_approve_id				\n")
					.append("	FROM haccp_subsidiary_warehouse_result A					\n")
					.append("			INNER JOIN haccp_subsidiary_warehouse B				\n")
					.append("				ON A.check_date = B.check_date					\n")
					.append("			LEFT JOIN tbm_users C								\n")
					.append("				ON B.person_write_id = C.user_id				\n")
					.append("				AND  A.check_date BETWEEN CAST(C.start_date AS DATE) AND CAST(C.duration_date AS DATE) \n")
					.append("			LEFT JOIN tbm_users D								\n")
					.append("				ON B.person_check_id = D.user_id				\n")
					.append("				AND  A.check_date BETWEEN CAST(D.start_date AS DATE) AND CAST(D.duration_date AS DATE) \n")
					.append("			LEFT JOIN tbm_users E								\n")
					.append("				ON B.person_approve_id = E.user_id				\n")
					.append("				AND  A.check_date BETWEEN CAST(E.start_date AS DATE) AND CAST(E.duration_date AS DATE) \n")
					.append("	WHERE A.check_date = '"+checkDate+"'						\n")
					.toString();
			
			resultString = super.excuteQueryString(con, sql);
		} catch(Exception e) {
			e.printStackTrace();
			LoggingWriter.setLogError("M838S020750E144()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR ;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
					LoggingWriter.setLogError("M838S020750E144()","==== finally ===="+ e.getMessage());
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);

    	return EventDefine.E_QUERY_RESULT;
	}
	
	// 점검표 승인자 서명
	public int E502(InoutParameter ioParam){ 
		
		resultInt = EventDefine.E_DOEXCUTE_INIT;

		try {
			con = JDBCConnectionPool.getConnection();
			con.setAutoCommit(false);
			
    		JSONObject jObj = new JSONObject();
    		jObj = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
    		
    		String sql = new StringBuilder()
    				.append("UPDATE haccp_subsidiary_warehouse								\n")
    				.append("SET															\n")
    				.append("	person_approve_id = '" + jObj.get("userId") + "'			\n")
    				.append("WHERE check_date = '"+ jObj.get("checklistDate") + "'			\n")
    				.append("  AND checklist_id = '"+ jObj.get("checklistId") + "'			\n")
    				.append("  AND checklist_rev_no = '"+ jObj.get("checklistRevNo") + "'	\n")
					.toString();
		
			resultInt = super.excuteUpdate(con, sql);
	    	if(resultInt < 0){
				ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
				con.rollback();
				return EventDefine.E_DOEXCUTE_ERROR ;
			}
			con.commit();
		} catch(Exception e) {
			e.getStackTrace();
			LoggingWriter.setLogError("M838S020750E502()","==== SQL ERROR ===="+ e.getMessage());
			return EventDefine.E_DOEXCUTE_ERROR ;
	    } finally {
	    	if (Config.useDataSource) {
				try {
					if (con != null) con.close();
				} catch (Exception e) {
				}
	    	} else {
	    	}
	    }
		ioParam.setResultString(resultString);
		ioParam.setColumnCount("" + super.COLUMN_COUNT);
    	ioParam.setMessage(MessageDefine.M_QUERY_OK);
	    return EventDefine.E_QUERY_RESULT;
	}
	
	// 점검표 확인자 서명 --> 원래 있던거에서 수정
		public int E522(InoutParameter ioParam){ 
			
			resultInt = EventDefine.E_DOEXCUTE_INIT;

			try {
				con = JDBCConnectionPool.getConnection();
				con.setAutoCommit(false);
				
	    		JSONObject jObj = new JSONObject();
	    		jObj = (JSONObject)((ioParam.getInputHashObject()).get("rcvData", HashObject.YES));
	    		
	    		String sql = new StringBuilder()
	    				.append("UPDATE haccp_subsidiary_warehouse 								\n")
	    				.append("SET															\n")
	    				.append("	person_check_id = '" + jObj.get("userId") + "'				\n")
	    				.append("WHERE check_date = '"+ jObj.get("checklistDate") + "'			\n")
	    				.append("  AND checklist_id = '"+ jObj.get("checklistId") + "'			\n")
	    				.append("  AND checklist_rev_no = '"+ jObj.get("checklistRevNo") + "'	\n")
						.toString();
			
				resultInt = super.excuteUpdate(con, sql);
		    	if(resultInt < 0){
					ioParam.setMessage(MessageDefine.M_INSERT_FAILED);
					con.rollback();
					return EventDefine.E_DOEXCUTE_ERROR ;
				}
				con.commit();
			} catch(Exception e) {
				e.getStackTrace();
				LoggingWriter.setLogError("M838S020750E522()","==== SQL ERROR ===="+ e.getMessage());
				return EventDefine.E_DOEXCUTE_ERROR ;
		    } finally {
		    	if (Config.useDataSource) {
					try {
						if (con != null) con.close();
					} catch (Exception e) {
					}
		    	} else {
		    	}
		    }
			ioParam.setResultString(resultString);
			ioParam.setColumnCount("" + super.COLUMN_COUNT);
	    	ioParam.setMessage(MessageDefine.M_QUERY_OK);
		    return EventDefine.E_QUERY_RESULT;
		}
}