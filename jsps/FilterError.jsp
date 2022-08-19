 
<%
    response.setHeader("Cache-Control", "no-cache,no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
<link rel="icon" href="../plaf/icon/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html" />
<link rel="stylesheet" type="text/css"
	href="../plaf/style/default/general.css" />
</head>
<body>
	<div class="display_box">
		<title>Error Message</title>
        <table>
            <tbody>
                <tr>
                    <td class="caption" colspan="3">Error Message</td>
                </tr>
                <tr>
                    <td class="message">SECURITY VIOLATION (Code: SV-07). Your
                        session has been invalidated. Please login again.</td>
                </tr>
            </tbody>
        </table>
	</div>
	<%
        HttpSession sessionObj = request.getSession(false);
        //Invalidate the session for XSS attacks
        if (sessionObj != null) {
            sessionObj.invalidate();
        }
    %>
</body>
</html>