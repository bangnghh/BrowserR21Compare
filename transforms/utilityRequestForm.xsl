<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="utilityRequestForm">
			<!-- Submit the utility request with proper values -->
		<form name="utilityRequestForm" method="POST" action="BrowserServlet">
			<xsl:attribute name="id">utilityRequestForm</xsl:attribute>			
            <input type="hidden" name="requestType" value="{$_UTILITY__ROUTINE_}"/>
			<input type="hidden" name="routineName" value="NEXT.TASK.BPM.PROCESS"/>
			<input type="hidden" name="routineArgs">
				<xsl:attribute name="value"><xsl:value-of select="/responseDetails/userDetails/pwprocessargs"/></xsl:attribute>
			</input>
			<input type="hidden" name="command" value="globusCommand"/>
			<input type="hidden" name="companyId">
				<xsl:attribute name="value"><xsl:value-of select="/responseDetails/userDetails/companyId"/></xsl:attribute>
			</input>		  
            <input type="hidden" name="compScreen">
             	<xsl:attribute name="value"><xsl:value-of select="/responseDetails/userDetails/compScreen"/></xsl:attribute>
             </input>		
			<input type="hidden" name="windowName">
				<xsl:attribute name="value"><xsl:value-of select="/responseDetails/userDetails/windowName"/></xsl:attribute>
			</input>	
			<input type="hidden" name="user">
				<xsl:attribute name="value"><xsl:value-of select="/responseDetails/userDetails/user"/></xsl:attribute>
			</input>			
		</form>
		
	</xsl:template>
	
</xsl:stylesheet>
