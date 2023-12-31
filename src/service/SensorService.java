package service;

import java.sql.Connection;
import java.util.List;

import org.apache.log4j.Logger;

import dao.SensorDao;
import mes.frame.database.JDBCConnectionPool;
import model.Sensor;

public class SensorService {

	private SensorDao sensorDao;
	private String bizNo;
	private Connection conn;
	
	static final Logger logger = Logger.getLogger(SensorService.class.getName());

	public SensorService(SensorDao sensorDao, String bizNo) {
		this.sensorDao = sensorDao;
		this.bizNo = bizNo;
	}
	
	public List<Sensor> getAllSensors() {
		List<Sensor> sensorList = null;
		
		try {
			conn = JDBCConnectionPool.getTenantDB(bizNo);
			sensorList = sensorDao.getAllSensors(conn);
		} catch(Exception e) {
			logger.error(e.getMessage());
		} finally {
		    try { conn.close(); } catch (Exception e) { /* Ignored */ }
		}
		
		return sensorList;
	}
	
	public Sensor getSensorById(String id) {
		Sensor sensor = null;
		
		try {
			conn = JDBCConnectionPool.getTenantDB(bizNo);
			sensor = sensorDao.getSensor(conn, id);
		} catch(Exception e) {
			logger.error(e.getMessage());
		} finally {
		    try { conn.close(); } catch (Exception e) { /* Ignored */ }
		}
		
		return sensor;
	}
	
	public boolean insert(Sensor sensor) {
		try {
			conn = JDBCConnectionPool.getTenantDB(bizNo);
			return sensorDao.insert(conn, sensor);
		} catch(Exception e) {
			logger.error(e.getMessage());
		} finally {
		    try { conn.close(); } catch (Exception e) { /* Ignored */ }
		}
		
		return false;
	}
	
	public boolean update(Sensor sensor) {
		try {
			conn = JDBCConnectionPool.getTenantDB(bizNo);
			return sensorDao.update(conn, sensor);
		} catch(Exception e) {
			logger.error(e.getMessage());
		} finally {
		    try { conn.close(); } catch (Exception e) { /* Ignored */ }
		}
		
		return false;
	}
	
	public boolean delete(String sensorId) {
		try {
			conn = JDBCConnectionPool.getTenantDB(bizNo);
			return sensorDao.delete(conn, sensorId);
		} catch(Exception e) {
			logger.error(e.getMessage());
		} finally {
		    try { conn.close(); } catch (Exception e) { /* Ignored */ }
		}
		
		return false;
	}
}
