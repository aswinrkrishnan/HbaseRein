<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/loginStyles.css" />
<link rel="shortcut icon" href="images/favIcon.png">
<script src="js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$.fn.center = function() {
					this.css("top", ($(window).height() - this.height()) / 2
							+ $(window).scrollTop() + "px");
					this.css("left", ($(window).width() - this.width()) / 2
							+ $(window).scrollLeft() + "px");
					return this;
				};
				$('#loginContainer').center();
				window.onresize = function() {
					$('#loginContainer').center();
				};
			});
</script>
<title>H-Base R E I N</title>
</head>
<body>
	<div id="container">
		<div id="loginContainer">
			<s:form action="loginAction" theme="simple">
				<div id="login">
					<div id="h2"></div>
					<div>
						<s:textfield type="text" cssClass="textbox" placeholder="Username"
							theme="simple" name="username" />
					</div>
					<div>
						<s:password cssClass="textbox" placeholder="Password"
							theme="simple" name="password" />
					</div>
					<div>
						<span><a href="#">Forgot Password?</a></span>
						<s:submit type="submit" cssClass="button" value="Sign In"
							theme="simple" />
					</div>
				</div>
			</s:form>
		</div>
	</div>
</body>
</html>