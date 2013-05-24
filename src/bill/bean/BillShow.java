package bill.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillShow {

	private Map<String, BillInfo> _list;

	public BillShow() {
		_list = new HashMap<String, BillInfo>();
	}

	public final void add(BillData data) {
		String date = data.getBillTime();
		if (_list.containsKey(date)) {
			_list.get(date).add(data);
		} else {
			BillInfo info = new BillInfo(date);
			info.add(data);
			_list.put(date, info);
		}
	}

	public final void add(BillInfo info) {
		_list.put(info.getDate(), info);
	}

	public List<BillInfo> getList(int num) {
		List<BillInfo> list = new ArrayList<BillInfo>();
		
		List<Map.Entry<String, BillInfo>> infoIds =
		    new ArrayList<Map.Entry<String, BillInfo>>(_list.entrySet());
		Collections.sort(infoIds, new Comparator<Map.Entry<String, BillInfo>>() {   
		    public int compare(Map.Entry<String, BillInfo> o1, Map.Entry<String, BillInfo> o2) {      
		        //return (o2.getValue() - o1.getValue()); 
		        return (o2.getKey()).toString().compareTo(o1.getKey());
		    }
		});
		int size = infoIds.size();
		for(Map.Entry<String, BillInfo> entry:infoIds){
			list.add(entry.getValue());
		}
		
		if (num > 0 && num <= size) {
			list = list.subList(0, num);
		}
		
		return list;
	}

	public String getDetail(String date) {
		if (this._list.containsKey(date)) {
			List<BillData> list = _list.get(date).getSubjects();
			StringBuilder sb = new StringBuilder();
			sb.append("<ul>");
			for (BillData data : list) {
				sb.append("<li>");
				sb.append("项目:");
				sb.append(data.getBillSubject());
				sb.append("\t,");
				sb.append("金额:");
				sb.append(data.getBillType() == 1 ? "-" : "+");
				sb.append(data.getBillMoney());
				sb.append("\t,");
				sb.append("备注:");
				sb.append(data.getBillDetial().replaceAll("\r|\n", ""));
				sb.append("\t;");
				sb.append("<a onclick=deleteInfo(" + data.getUserId() + ","
						+ data.getBillId() + ")>删除</a>");
				sb.append("</li>");
			}
			sb.append("</ul>");
			return sb.toString();
		}
		return "";
	}

	public static class BillInfo {

		String date;

		float money;

		List<BillData> subjects;

		private BillInfo() {
			subjects = new ArrayList<BillData>();
		}

		public BillInfo(String date) {
			this();
			this.date = date;
		}

		public final void add(BillData data) {
			if (data.getBillTime().equals(date)) {
				subjects.add(data);
				if (data.getBillType() == 1) {
					money -= data.getBillMoney();
				} else {
					money += data.getBillMoney();
				}
			}
		}

		public final String getDate() {
			return date;
		}

		public final void setDate(String date) {
			this.date = date;
		}

		public final float getMoney() {
			return money;
		}

		public final void setMoney(float money) {
			this.money = money;
		}

		public final List<BillData> getSubjects() {
			return subjects;
		}

		public final void setSubjects(List<BillData> subjects) {
			this.subjects = subjects;
		}
	}
}
