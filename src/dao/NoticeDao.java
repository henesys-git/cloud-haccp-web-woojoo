package dao;

import java.sql.Connection;
import java.util.List;

import model.Notice;

public interface NoticeDao {
	public List<Notice> getNoticeByTenant(Connection conn);
	public List<Notice> getAllNotice(Connection conn);
	public Notice getNotice(Connection conn, String regDatetime);
	public boolean insert(Connection conn, Notice notice);
	public boolean update(Connection conn, Notice notice, String regDatetimeOrg);
	public boolean delete(Connection conn, String registerDatetime);
}
