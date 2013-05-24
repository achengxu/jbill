package bill.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import bill.bean.BillData;
import bill.bean.BillShow;

import com.jolbox.bonecp.BoneCP;
import com.jolbox.bonecp.BoneCPConfig;

/**
 * DataBase Server by MYSQL BoneCP
 * 
 * @author LINXK
 * @version 20100802
 */
public class JDBServer {

	private final static Logger _logger = LoggerFactory
			.getLogger(JDBServer.class);

	private static String JdbcUrl = "jdbc:mysql://127.0.0.1:3306/jbill?characterEncoding=UTF-8";
	private static String UserName = "root";
	private static String password = "";

	private volatile static JDBServer _instance = null;

	private BoneCP _bill_cp;

	public static void init(String url, String userName, String password) {
		JDBServer.JdbcUrl = url;
		JDBServer.UserName = userName;
		JDBServer.password = password;
	}

	protected void initCache() {
	}

	private void initCommonCP() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			BoneCPConfig config = new BoneCPConfig();
			config.setJdbcUrl(JDBServer.JdbcUrl);
			config.setUsername(JDBServer.UserName);
			config.setPassword(JDBServer.password);
			config.setMaxConnectionsPerPartition(20);
			config.setMinConnectionsPerPartition(10);
			config.setIdleMaxAge(5);
			config.setIdleConnectionTestPeriod(1);
			_bill_cp = new BoneCP(config);
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
	}

	private JDBServer() {
	}

	public static JDBServer getInstance() {
		if (_instance == null) {
			synchronized (JDBServer.class) {
				if (_instance == null) {
					_instance = new JDBServer();
				}
			}
		}
		return _instance;
	}

	public void start() {
		if (null == _bill_cp) {
			initCommonCP();
		}
	}

	public void stop() {
		_bill_cp.shutdown();
	}

	public BoneCP getBillCP() {
		return _bill_cp;
	}

	public boolean addBill(BillData billData) {
		boolean flag = false;
		Connection connection = null;
		CallableStatement cs = null;
		try {
			connection = _bill_cp.getConnection();
			connection.setAutoCommit(false);
			cs = connection
					.prepareCall("{call proc_jbill_bill_add(?,?,?,?,?,?)}");
			cs.setInt(1, billData.getUserId());
			cs.setString(2, billData.getBillSubject());
			cs.setString(3, billData.getBillTime());
			cs.setInt(4, billData.getBillType());
			cs.setFloat(5, (float) billData.getBillMoney());
			cs.setString(6, billData.getBillDetial());
			cs.execute();
			connection.commit();
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
			_logger.error("addBill sql exception:{}", e.getMessage());
		} finally {
			try {
				if (cs != null) {
					cs.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				flag = false;
				_logger.error("close connection exception:{}", e.getMessage());
			}
		}
		return flag;
	}

	public BillShow getUserBillList(int userId) {
		BillShow show = new  BillShow();
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			connection = _bill_cp.getConnection();
			connection.setAutoCommit(false);
			String sql = "SELECT  `billId`, `billSubject`, `billTime`, `billType`, `billMoney`, `billDetial` FROM `bill_list`  WHERE `userId`=? ORDER BY `billTime` DESC ;";
			stmt = connection.prepareStatement(sql);
			stmt.setInt(1, userId);
			stmt.execute();
			rs = (ResultSet) stmt.executeQuery();
			while (rs.next()) {
				long billId = rs.getInt(1);
				String billSubject = rs.getString(2);
				String billTime = rs.getString(3);
				int billType = rs.getInt(4);
				float billMoney = rs.getFloat(5);
				String billDetial = rs.getString(6);
				BillData billData = new BillData();
				billData.setBillId(billId);
				billData.setBillSubject(billSubject);
				billData.setBillTime(billTime);
				billData.setBillType(billType);
				billData.setBillMoney(billMoney);
				billData.setBillDetial(billDetial);
				billData.setUserId(userId);
				show.add(billData);
			}
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			_logger.error("getUserBillList sql exception:{}", e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				_logger.error("close connection exception:{}", e.getMessage());
			}
		}
		return show;
	}

	public int checkLogin(String userName, String userPassword) {
		int userId = -1;
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			connection = _bill_cp.getConnection();
			connection.setAutoCommit(false);
			String sql = "SELECT `userId` FROM `bill_user` WHERE `userName`=? AND `userPassword`=?;";
			stmt = connection.prepareStatement(sql);
			stmt.setString(1, userName);
			stmt.setString(2, userPassword);
			stmt.execute();
			rs = (ResultSet) stmt.executeQuery();
			if (rs.next()) {
				userId = rs.getInt(1);
			}
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			_logger.error("checkLogin sql exception:{}", e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				_logger.error("close connection exception:{}", e.getMessage());
			}
		}
		return userId;
	}

	public boolean delKey(int userId, long billId) {
		boolean flag = false;
		Connection connection = null;
		PreparedStatement stmt = null;
		try {
			connection = _bill_cp.getConnection();
			connection.setAutoCommit(false);
			String sql = "DELETE FROM `bill_list` WHERE `billId`=? AND `userId`=?;";
			stmt = connection.prepareStatement(sql);
			stmt.setLong(1, billId);
			stmt.setInt(2, userId);
			int num = stmt.executeUpdate();
			if (num==1) {
				//System.out.println(rs.getInt(1));
				flag = true;
			}
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			_logger.error("delKey sql exception:{}", e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				_logger.error("close connection exception:{}", e.getMessage());
			}
		}
		return flag;
	}

}