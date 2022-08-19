
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
                    <td class="message">The request could not be processed due to
                        some error. Please contact System Administrator.</td>
                </tr>
            </tbody>
        </table>
	</div>
</body>
</html>