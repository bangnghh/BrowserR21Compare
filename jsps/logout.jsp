<!--The logou.jsp is invoked only when SSO with SAML and ADFS is enabled and its customizable jsp page -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="icon" href="../plaf/icon/favicon.ico"/>
<meta http-equiv="Content-Type" content="text/html">
<title>T24 SSO Sign in</title>
<style type="text/css">
					html {
						background-image: none;
					
						
					}
					body {
						margin: 2px;
						height: 98%;
						font-family: Arial, sans-serif;
						font-size: smaller;
						overflow: auto;
						white-space: nowrap;
					}
					li{
					list-style-type: none;
					}
					a{
						font-size:smaller;
							white-space: nowrap;
						}
					img{
						border: 0px;
						margin-right: 2px;
					}
					input {
						border: 1px solid silver;
					}
					label {
						padding: 0 20px 0 10px;
						font-size: medium;
					}
					.input-ro {
						border: 1px solid black;
						background-color: #e0e0e0;
					}
					.navbar{
						background-color: white;
						padding: 5px 5px;
						float: left;
						width: 30%;
					}
					.error{
						text-align: left;
						color: #ff0000;
						font-size: smaller;
					}
						
					#sign-in
					{
						border:1px double white;
						color: white;
						padding: 0px 10px 0px 10px;
						background-color: #334988;
					}
				
					#login-window {
						padding: 10px 10px 30px 20px;
						float: left;
						width: 68%;
					}
					#logo-window {
						border-left: 2px solid silver;
					}
					#topspacer {
						padding: 50px;
						background-color: white;
					}
					#title {
						padding-top: 5px;
						padding-bottom: 15px;
						font-size:large;
						color: #334988;
					}
					#container{
						width: 100%;
					}
					.spacer{
						padding: 5px;
					}
					#case-sensitive {
						font-size: smaller;
						color: #a1a1a1;
					}
					#copyright {
						color: #a1a1a1;
					}
					</style>
<body>
<div id="topspacer"></div>
<table id="container">
	<tbody>
		<tr>
			<td nowrap width="100%">
				<div id="logo-window" class="navbar">
					<li><a href="http://www.temenos.com"><img
						alt="Temenos Web Site" src="../plaf/images/default/banner_start.gif"></a></li>
					<li class="spacer"></li>
					<li><a href="../portal/portal.htm">T24 Portal</a></li>
					<li><a href="http://www.temenos.com">Temenos Web Site</a></li>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<div class="spacer"><span id="copyright">Copyright &copy;
Temenos Headquarters SA. All rights reserved.</span></div>
</body>
</html>