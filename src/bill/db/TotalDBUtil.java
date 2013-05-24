package bill.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TotalDBUtil {

	public static String getBasic(String caption, String xAxisName,
			String yAxisName, String sql) {
		StringBuilder xml = new StringBuilder();
		xml.append("<chart caption='" + caption + "' xAxisName='" + xAxisName);
		xml.append("' yAxisName='" + yAxisName);
		xml.append("' showValues='0' formatNumberScale='0' showBorder='0' >");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = getConn();
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		try {
			List<String> list = new ArrayList<String>();
			while (rs.next()) {
				String title = rs.getString(1);
				int total = rs.getInt(2);
				// xml += "<set label='" + title + "' value='" + total + "' />";
				list.add("<set label='" + title + "' value='" + total + "' />");
			}
			for (int i = list.size() - 1; i >= 0; i--) {
				xml.append(list.get(i));
			}
			stmt.close();
			rs.close();
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		xml.append("</chart>");
		return xml.toString();
	}

	public static String getTotalMoneyOut(int userId, int day) {
		String caption = "近" + day + "天支出走向";
		String xAxisName = "日期";
		String yAxisName = "金额";
		String sql = "select left(`billTime`,10),sum(`billMoney`) from `bill_list` where `userId`="
				+ userId
				+ " and `billType`=1 group by left(`billTime`,10) order by left(`billTime`,10) DESC LIMIT 0,"
				+ day + ";";
		String xml = getBasic(caption, xAxisName, yAxisName, sql);
		return xml;
	}

	public static String getTotalMoneyIn(int userId, int day) {
		String caption = "近" + day + "天收入金额走向";
		String xAxisName = "日期";
		String yAxisName = "金额";
		String sql = "select left(`billTime`,10),sum(`billMoney`) from `bill_list` where `userId`="
				+ userId
				+ " and `billType`=2 group by left(`billTime`,10) order by left(`billTime`,10) DESC LIMIT 0,"
				+ day + ";";
		String xml = getBasic(caption, xAxisName, yAxisName, sql);
		return xml;
	}

	public static String getTotalSubjectOut(int userId) {
		String caption = "支出统计概况";
		String xAxisName = "日期";
		String yAxisName = "金额";
		String sql = "select `billSubject`,sum(`billMoney`) from `bill_list` where `userId`="
				+ userId
				+ " and `billType`=1 group by `billSubject` order by left(`billTime`,10) asc;";
		String xml = getBasic(caption, xAxisName, yAxisName, sql);
		return xml;
	}

	public static String getTotalSubjectIn(int userId) {
		String caption = "收入统计概况";
		String xAxisName = "日期";
		String yAxisName = "金额";
		String sql = "select `billSubject`,sum(`billMoney`) from `bill_list` where `userId`="
				+ userId
				+ " and `billType`=2 group by `billSubject` order by left(`billTime`,10) asc;";
		String xml = getBasic(caption, xAxisName, yAxisName, sql);
		return xml;
	}

	private static Connection getConn() throws ClassNotFoundException,
			SQLException {
		return JDBServer.getInstance().getBillCP().getConnection();
	}
}
