package model;

public class EventInfo {
	private String eventCode;
	private String eventName;
	private String processName;
	private double minValue;
	private double maxValue;
	
	public String getEventCode() {
		return eventCode;
	}
	
	public String getEventName() {
		return eventName;
	}

	public String getProcessName() {
		return processName;
	}
	
	public double getMinValue() {
		return minValue;
	}
	
	public double getMaxValue() {
		return maxValue;
	}

	public void setEventCode(String eventCode) {
		this.eventCode = eventCode;
	}
	
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public void setProcessName(String processName) {
		this.processName = processName;
	}
	
	public void setMinValue(double minValue) {
		this.minValue = minValue;
	}
	
	public void setMaxValue(double maxValue) {
		this.maxValue = maxValue;
	}
	
	@Override
	public String toString() {
		return "EventInfo [eventCode=" + eventCode + ", eventName=" + eventName + ", processName=" + processName
				+ ", minValue=" + minValue + ", maxValue=" + maxValue + "]";
	}
}
