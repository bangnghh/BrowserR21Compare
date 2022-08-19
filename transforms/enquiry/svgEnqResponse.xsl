<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
								
<xsl:template match="/">
<HTML>
<HEAD>
</HEAD>
<xsl:element name="body">
        <xsl:call-template name="MpPopulate"/>
        
        
        <EMBED src="../plaf/chart/mpChart.svg" type="image/svg+xml" width="500" height="290" pluginspage="http://www.adobe.com/svg/viewer/install/"></EMBED>
        
        <SCRIPT language="Javascript">
            var enqPrntWndw = "<xsl:value-of select="/responseDetails/userDetails/EnqParentWindow" />";
            var prntWndw;
            if(enqPrntWndw){
                prntWndw = parent.frames[enqPrntWndw];
            }
            if(prntWndw){
                var prntForm = prntWndw.document.getElementById("generalForm");
                if(prntForm){
                    prntForm.drilltarget.value = "";
                } 
            }   
        </SCRIPT>
        
        </xsl:element>
</HTML>
</xsl:template>
<xsl:template name="MpPopulate">
 <xsl:choose>
  <xsl:when test="/responseDetails/window/panes/pane/dataSection/enqResponse/mpPie!=''">
  
      <p style="display: none" id="mpSliceData">
          <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/mpPie/mpSlice">
              <xsl:choose>
                  <xsl:when test="position() != last()"><xsl:value-of select="mpAmount" />~Com#<xsl:value-of select="mpLabel" />~Com#false~Com#<xsl:value-of select="mpLevel"/>|</xsl:when>
                  <xsl:otherwise><xsl:value-of select="mpAmount" />~Com#<xsl:value-of select="mpLabel" />~Com#true~Com#<xsl:value-of select="mpLevel"/></xsl:otherwise>
              </xsl:choose>
          </xsl:for-each>
      </p>
  </xsl:when>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="/responseDetails/window/panes/pane/message!=''">
      <p style="display: none" id="mpMsgData">
          <xsl:for-each select="/responseDetails/window/panes/pane/message">
              <xsl:for-each select="msg">
                  <xsl:value-of select="." />|
              </xsl:for-each>
          </xsl:for-each>
      </p>
  </xsl:when>
  </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
