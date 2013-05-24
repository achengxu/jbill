package bill.init;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class BillConfig extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
		super.init();
		String url = getInitParameter("jdbc.url");
		String userName = getInitParameter("jdbc.userName");
		String password = getInitParameter("jdbc.password");
		bill.db.JDBServer.init(url, userName, password);
		bill.db.JDBServer.getInstance().start();
	}
}
