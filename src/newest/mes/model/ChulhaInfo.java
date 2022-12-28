package newest.mes.model;

public class ChulhaInfo {
	private String chulhaNo;
	private String chulhaDate;
	private String customerCode;
	
	public ChulhaInfo() {}
	
	public ChulhaInfo(String chulhaNo, String chulhaDate, String customerCode) {
		this.chulhaNo = chulhaNo;
		this.chulhaDate = chulhaDate;
		this.customerCode = customerCode;
	}
	
	public String getChulhaNo() {
		return chulhaNo;
	}
	public String getChulhaDate() {
		return chulhaDate;
	}
	public String getCustomerCode() {
		return customerCode;
	}
	public void setChulhaNo(String chulhaNo) {
		this.chulhaNo = chulhaNo;
	}
	public void setChulhaDate(String chulhaDate) {
		this.chulhaDate = chulhaDate;
	}
	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}
}
