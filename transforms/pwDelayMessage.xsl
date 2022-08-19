<?xml version="1.0" encoding="UTF-8"?>
    
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="userDetails.xsl"/>
	<xsl:import href="messages.xsl" />
	<xsl:import href="ARC/T24_constants.xsl" />
	<xsl:import href="utilityRequestForm.xsl" />
	<xsl:import href="generalForm.xsl"/>
	
<!-- Extract the Skin name for identifying CSS and Images directory -->
	<xsl:variable name="skin"><xsl:value-of select='/responseDetails/userDetails/skin'/></xsl:variable>
	<xsl:variable name="pwprocessargs"><xsl:value-of select="/responseDetails/userDetails/pwprocessargs"/></xsl:variable>

    <xsl:variable name="formFragmentSuffix">
        <xsl:choose>
            <xsl:when test="responseDetails/webDetails/WS_FragmentName!=''">_<xsl:value-of select="/responseDetails/webDetails/WS_FragmentName"/></xsl:when>
            <xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
	<xsl:variable name="multiPane">
	    <xsl:choose>
	    	<xsl:when test="/responseDetails/webDetails/WS_subPaneRequest!=''">true</xsl:when>
            <xsl:when test="count(responseDetails/window/panes/pane) > 1">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
	</xsl:variable>
   
	<xsl:template match="/">
         <html>
               <head>
                   <link rel="icon" href="../plaf/icon/favicon.ico"/>
                   <!-- Include the required stylesheets - using a skin version if specified -->
                                                
                   <link rel="stylesheet" type="text/css">
                  		<xsl:attribute name="href">../plaf/style/<xsl:copy-of select="$skin"/>/general.css</xsl:attribute>
                   	</link>
                   	 <!-- JavaScript files  -->
                   	 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                        <script src="../scripts/request.js"/>
						<script src="../scripts/enquiry.js"/> 
						<script src="../scripts/menu.js"/>
						<script src="../scripts/Deal.js"/>
						<script src="../scripts/ARC/T24_constants.js"/>
						<script src="../scripts/commandline.js"/>
                        <script src="../scripts/general.js"/>
                        <script src="../scripts/help.js"/>
                        <script src="../scripts/version/version.js" />
                        <script src="../scripts/ARC/Logger.js" />
                        <script src="../scripts/ARC/Fragment.js" />
                        <script src="../scripts/ARC/FragmentUtil.js" />								
                </head>
                
                	<xsl:element name="body">     
                  		<xsl:choose>
							<xsl:when test="(substring($pwprocessargs,1,3)='ENQ')">
							<!-- No more Request ,hence display hyperlink to launch enquiry -->
							<div class="display_box">
								<p>No pending tasks for the current process. To go back to enquiry, please 					
								<a>
									<xsl:attribute name="onclick">javascript:docommand('<xsl:value-of select="/responseDetails/userDetails/pwprocessargs"/>')</xsl:attribute>
									<xsl:attribute name="href">javascript:void(0)</xsl:attribute>
									<font face="Verdana" color="#336699" size="2" >Click Here</font>
								</a>
								</p>
							</div>
                             </xsl:when>   
                         <xsl:otherwise>
							<xsl:attribute name="onload">javascript:submitUtilityRequest();</xsl:attribute>
							<!-- call utilityRequestform template and submit the request -->
                            <div class="display_box">
                             	<h5><p>Please wait</p></h5>
								 <xsl:call-template name="utilityRequestForm"/>
                              </div>
                          </xsl:otherwise>
                        </xsl:choose>
					 	<xsl:if test="(substring($pwprocessargs,1,3)='ENQ')">
							<form name="enquiry" id="enquiry" method="POST" action="BrowserServlet"></form>
							<!-- A general form for submitting requests -->
							<xsl:call-template name="generalForm"/>
						</xsl:if>
                     </xsl:element>
        </html>
	</xsl:template>

</xsl:stylesheet>
