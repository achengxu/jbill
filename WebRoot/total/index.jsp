<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.fusioncharts.com/jsp/core" prefix="fc"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<jsp:useBean id="chartData" class="bill.bean.total.TotalMoney" />
<%@page import="com.fusioncharts.sampledata.ChartType,bill.bean.total.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<c:set var="folderPath" value="FusionCharts/" />
<c:set var="title" value="消费统计" scope="request" />
<c:set var="jsPath" value="${folderPath}" scope="request" />
<c:set var="assetCSSPath" value="assets/ui/css/" scope="request" />
<c:set var="assetJSPath" value="assets/ui/js/" scope="request" />
<c:set var="assetImagePath" value="assets/ui/images/" scope="request" />
<%
	if (null == session.getAttribute("userId")) {
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		String newLocn = "../index.html";
		response.setHeader("Location", newLocn);
		return;
	}
	pageContext.setAttribute("col2dChart", ChartType.COLUMN2D
			.getFileName());
	pageContext.setAttribute("lineChart", ChartType.LINE.getFileName());
	pageContext.setAttribute("column3d", ChartType.COLUMN3D
			.getFileName());
	pageContext.setAttribute("pie3d", ChartType.PIE3D.getFileName());

	int userId = (Integer)session.getAttribute("userId");
	TotalMoney totalmoney = null;
	if (null == totalmoney) {
		totalmoney = new TotalMoney(userId);
	} else {
		totalmoney = new TotalMoney();
	}
	String subject = totalmoney.getSubject();
	String day7 = totalmoney.getDay7();
%>
<jsp:setProperty property="day7" name="chartData" value="<%=day7%>"/>
<jsp:setProperty property="subject" name="chartData" value="<%=subject%>"/>
<tags:template2>
	<%-- Now, create a Line2D Chart --%>
	<fc:render chartId="${chartData.uniqueId}" swfFilename="${folderPath}${lineChart}" width="${chartData.width}" height="${chartData.height}" debugMode="false" registerWithJS="false" xmlData="${chartData.day7}" />
	<fc:render chartId="${chartData.uniqueId}" swfFilename="${folderPath}${pie3d}" width="${chartData.width}" height="${chartData.height}" debugMode="false" registerWithJS="false" xmlData="${chartData.subject}" />
</tags:template2>