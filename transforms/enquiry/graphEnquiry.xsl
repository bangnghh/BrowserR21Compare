<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="graphEnquiry">

  <SCRIPT language="Javascript">
  
   // startEvalScript
   if(!isFirefox())
	{
   		//firefox has it's own inbuilt SVG viewer so only check for IE
   		checkAndGetSVGViewer();
   	}

    DataItem_GLOBAL = function DataItem(
    <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataItem">
      <xsl:choose>
        <xsl:when test="position() != last()">
          <xsl:value-of select="variableName"/>,
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="variableName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    )
    {
    
        <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataItem">
          this.<xsl:value-of select="variableName"/> = <xsl:value-of select="variableName"/>;
        </xsl:for-each>
          this.Series = '';
          this.color = '';
          this.plottPoint = null;
          this.svgElement = null;
          this.tag = null;
    
    }

    <xsl:choose>
      <xsl:when test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataBreak">
        _dataBreak = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataBreak"/>;
      </xsl:when>
      <xsl:otherwise>
        _dataBreak = '';
      </xsl:otherwise>
    </xsl:choose>
  
  
  _width = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/graphWidth"/>;

  _height = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/graphHeight"/>;
    
  _graphType = "<xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/GraphType"/>";
  
  _topMargin = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/topMargin"/>;
  
  _bottomMargin = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/bottomMargin"/>;

  _rightMargin = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/rightMargin"/>;

  _leftMargin = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/leftMargin"/>;
  
  _amountFormat = "<xsl:value-of select="/responseDetails/userDetails/amountFormat"/>";
  
  _showGridX = false;
  <xsl:if test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/gridX" >
  	_showGridX = true;
  </xsl:if>
  
  _showGridY = false;
  <xsl:if test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/gridY" >
  	_showGridY = true;
  </xsl:if>
  
  _axisScaleX = 0;
  <xsl:if test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/scaleX" >
  	_axisScaleX = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/scaleX"/>;
  </xsl:if>
  
  _axisScaleY = 0;
  <xsl:if test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/scaleY" >
  	_axisScaleY = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/scaleY"/>;
  </xsl:if>
  
  <xsl:choose>
  	<xsl:when test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/legend">
  		_showLegend = true;
  		_legendX = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/legend/x"/>;
  		_legendY = <xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/legend/y"/>;  		
		_legendAttribute = "<xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/legend/attribute"/>";
  	</xsl:when>
  	<xsl:otherwise>
		_showLegend = false;
  		_legendX = 0;
  		_legendY = 0;
  		_legendAttribute = "";  		  	
  	</xsl:otherwise>
  </xsl:choose>
  
  _labelList = new Array();
  <xsl:if test="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/labels">	
  	  var aLabel = "";
	  <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/labels/label">
		  aLabel = { caption: "<xsl:value-of select="cap"/>",
		  			 x: <xsl:value-of select="x"/>,
		  			 y: <xsl:value-of select="y"/>,
		  			 isVertical: <xsl:choose><xsl:when test="vertical">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>
		  		   }
		  _labelList[_labelList.length] = aLabel;			   
	  </xsl:for-each>
  </xsl:if>
  
  _listOfColumns = new Array(
  <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataItem">
      <xsl:choose>
        <xsl:when test="position() != last()">
          <xsl:value-of select="colNum"/>,
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="colNum"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    )

    _listOfVariables = new Array(
    <xsl:for-each select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/DataItem">
      <xsl:choose>
        <xsl:when test="position() != last()">
          '<xsl:value-of select="variableName"/>',
        </xsl:when>
        <xsl:otherwise>
          '<xsl:value-of select="variableName"/>'
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    )

    _dataSet = new DataSet("<xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/GraphTitle"/>");
    _originalRows = new Array();
  <!-- Go through the data for each row -->
 
  <xsl:for-each select="r">
    <xsl:call-template name="graphEnqRowData" >
      <xsl:with-param name="headerrow" select="'false'"/>
    </xsl:call-template>
  </xsl:for-each>

  // endEvalScript
  
  </SCRIPT>


  <EMBED name="dataGraphic{$formFragmentSuffix}" src="../scripts/charting/svgObject.svg" width="700" height="500" type="image/svg+xml" >
  		<xsl:attribute name="wmode">transparent</xsl:attribute>
  		<xsl:attribute name="style">z-index: 0;</xsl:attribute>
  		<xsl:attribute name="width"><xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/graphWidth"/></xsl:attribute>
  		<xsl:attribute name="height"><xsl:value-of select="/responseDetails/window/panes/pane/dataSection/enqResponse/control/GraphEnq/graphHeight"/></xsl:attribute>
  </EMBED>
  
</xsl:template>


  <xsl:template name="graphEnqRowData" match="r">
  <xsl:param name="headerrow"/>


    nextRow = new Array(
    <xsl:for-each select="c">
      <xsl:choose>
        <xsl:when test="position() != last()">
          '<xsl:value-of select="cap"/>',
        </xsl:when>
        <xsl:otherwise>
          '<xsl:call-template name="mask-apos">
                <xsl:with-param name="string" select="cap"/>
          </xsl:call-template>'
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    )
    addOriginalRow(nextRow);
  </xsl:template>
     
  <xsl:template name="mask-apos">
		<xsl:param name="string"/>
		<!-- create an $apos variable to make it easier to refer to -->
		<xsl:variable name="apos" select='"&apos;"'/>
		<xsl:choose>
			<!-- if the string contains an apostrophe... -->
			<xsl:when test="contains($string, $apos)">
				<!-- ... give the value before the apostrophe... -->
				<xsl:value-of select="substring-before($string, $apos)"/>
				<!-- ...  replace apostrophe with character 'a' ... -->
				
				<xsl:text>a</xsl:text>
				<!-- ... and the result of applying the template to the string after the apostrophe -->
				<xsl:call-template name="mask-apos">
					<xsl:with-param name="string" select="substring-after($string, $apos)"/>
				</xsl:call-template>
			</xsl:when>
			<!-- otherwise... -->
			<xsl:otherwise>
				<!-- ... just give the value of the string -->
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet> 
