package bill.bean;

import java.util.HashMap;

public final class BillData {
	private long billId;
	private int userId;
	private String billSubject;
	private String billTime;
	private int billType;
	private float billMoney;
	private String billDetial;

	public final long getBillId() {
		return billId;
	}

	public final void setBillId(long billId) {
		this.billId = billId;
	}

	public final int getUserId() {
		return userId;
	}

	public final void setUserId(int userId) {
		this.userId = userId;
	}

	public final String getBillSubject() {
		return billSubject;
	}

	public final void setBillSubject(String billSubject) {
		this.billSubject = billSubject;
	}

	public final String getBillTime() {
		return billTime;
	}

	public final void setBillTime(String billTime) {
		this.billTime = billTime;
	}

	public final int getBillType() {
		return billType;
	}

	public final void setBillType(int billType) {
		this.billType = billType;
	}

	public final float getBillMoney() {
		return billMoney;
	}

	public final void setBillMoney(float billMoney) {
		this.billMoney = billMoney;
	}

	public final String getBillDetial() {
		return billDetial;
	}

	public final void setBillDetial(String billDetial) {
		this.billDetial = billDetial;
	}

	public HashMap<String, Object> toMap() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("billId", billId);
		map.put("userId", userId);
		map.put("billSubject", billSubject);
		map.put("billTime", billTime);
		map.put("billType", billType);
		map.put("billMoney", billMoney);
		map.put("billDetial", billDetial);
		return map;
	}

	public String toString() {
		return toMap().toString();
	}
}
