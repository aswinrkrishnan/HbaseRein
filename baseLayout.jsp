<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/boxStyles.css" />
<link rel="stylesheet" type="text/css" href="css/contentStyles.css" />
<link rel="stylesheet" type="text/css" href="css/graphStyles.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-1.9.1.js"></script>
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<sx:head />
</head>
<body onload="activeJobReload()">
	<!-- Main Wrapper Starts -->
	<div id="main_wrapper">

		<!-- Header Section Starts -->
		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>
		<!-- Header Section Ends -->

		<!-- Content Section Starts -->
		<div id="content">
			<tiles:insertAttribute name="leftContent" />
			<tiles:insertAttribute name="rightContent" />
			<div class="clear"></div>
		</div>
		<!-- Content Section Ends -->

		<!-- Footer Section Starts -->
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
		<!-- Footer Section Ends -->
		<div class="clear"></div>
	</div>
	<!-- Main Wrapper Ends -->
</body>
</html>