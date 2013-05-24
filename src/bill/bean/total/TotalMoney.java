package bill.bean.total;

import bill.db.TotalDBUtil;

import com.fusioncharts.sampledata.ChartType;

/**
 * Bean containing sample chart data. Default values for all the fields have
 * been set. These can be changed using the set methods. This class has been
 * used as a backing bean in JSP examples.
 * 
 * @author Infosoft Global (P) Ltd.
 * 
 */
public class TotalMoney {

	protected String day7;
	protected String day30;
	protected String day90;
	protected String day180;
	protected String day360;
	protected String subject;
	protected String chartId = "basicChart";
	protected String url = "Data/Data.xml";
	protected String jsonUrl = "Data/Data.json";
	protected String width = "600";
	protected String height = "300";
	protected String swfFilename = ChartType.PIE3D.getFileName();
	protected String uniqueId = "";

	/**
	 * Constructor - constructs the xml string
	 */
	public TotalMoney() {
		this(0);
	}
	
	public TotalMoney(int userId) {
		day7 = TotalDBUtil.getTotalMoneyOut(userId, 7);
		day30 = TotalDBUtil.getTotalMoneyOut(userId, 30);
		day90 = TotalDBUtil.getTotalMoneyOut(userId, 90);
		day180 = TotalDBUtil.getTotalMoneyOut(userId, 180);
		day360 = TotalDBUtil.getTotalMoneyOut(userId, 360);
		subject = TotalDBUtil.getTotalSubjectOut(userId);
	}

	/**
	 * Returns the value in the field chartId
	 * 
	 * @return the chartId
	 */
	public String getChartId() {
		return chartId;
	}

	/**
	 * Returns the value in the field height
	 * 
	 * @return the height
	 */
	public String getHeight() {
		return height;
	}

	/**
	 * Returns the value in the field jsonUrl
	 * 
	 * @return the jsonUrl
	 */
	public String getJsonUrl() {
		return jsonUrl;
	}

	/**
	 * Returns the value in the field swfFilename
	 * 
	 * @return the swfFilename
	 */
	public String getSwfFilename() {
		return swfFilename;
	}

	/**
	 * Returns a UniqueId
	 * 
	 * @return the uniqueId
	 */
	public String getUniqueId() {
		int randomNum = (int) Math.floor(Math.random() * 100);
		uniqueId = "Chart" + "_" + randomNum;
		return uniqueId;
	}

	/**
	 * Returns the value in the field url
	 * 
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * Returns the value in the field width
	 * 
	 * @return the width
	 */
	public String getWidth() {
		return width;
	}

	/**
	 * Sets the value for chartId
	 * 
	 * @param chartId
	 *            the chartId to set
	 */
	public void setChartId(String chartId) {
		this.chartId = chartId;
	}

	/**
	 * Sets the value for height
	 * 
	 * @param height
	 *            the height to set
	 */
	public void setHeight(String height) {
		this.height = height;
	}

	/**
	 * Sets the value for jsonUrl
	 * 
	 * @param jsonUrl
	 *            the jsonUrl to set
	 */
	public void setJsonUrl(String jsonUrl) {
		this.jsonUrl = jsonUrl;
	}

	/**
	 * Sets the value for swfFilename
	 * 
	 * @param swfFilename
	 *            the swfFilename to set
	 */
	public void setSwfFilename(String swfFilename) {
		this.swfFilename = swfFilename;
	}

	/**
	 * Sets the value for uniqueId
	 * 
	 * @param uniqueId
	 *            the uniqueId to set
	 */
	public void setUniqueId(String uniqueId) {
		this.uniqueId = uniqueId;
	}

	/**
	 * Sets the value for url
	 * 
	 * @param url
	 *            the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * Sets the value for width
	 * 
	 * @param width
	 *            the width to set
	 */
	public void setWidth(String width) {
		this.width = width;
	}

	public final String getDay7() {
		return day7;
	}

	public final void setDay7(String day7) {
		this.day7 = day7;
	}

	public final String getDay30() {
		return day30;
	}

	public final void setDay30(String day30) {
		this.day30 = day30;
	}

	public final String getDay90() {
		return day90;
	}

	public final void setDay90(String day90) {
		this.day90 = day90;
	}

	public final String getDay180() {
		return day180;
	}

	public final void setDay180(String day180) {
		this.day180 = day180;
	}

	public final String getDay360() {
		return day360;
	}

	public final void setDay360(String day360) {
		this.day360 = day360;
	}

	public final String getSubject() {
		return subject;
	}

	public final void setSubject(String subject) {
		this.subject = subject;
	}

}
