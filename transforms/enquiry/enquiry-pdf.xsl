<?xml version="1.0" encoding="UTF-8"?>
<!-- Motivation: Transforms a XML to XSL-FO Author: PuthumaiSamy -->
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:java="http://xml.apache.org/xslt/java" exclude-result-prefixes="java">
    <xsl:include href="../custom/custom-pdf.xsl" />
    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
    <xsl:strip-space elements="*" />
    <xsl:decimal-format name="defcur" NaN="0.00" />
    <xsl:template match="enqResponse">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="New-Pdf" page-width="8.26in" page-height="11.69in">
                    <fo:region-body margin-left="12mm" margin-right="12mm" margin-top="35mm" margin-bottom="20mm" />
                    <fo:region-before extent="35mm" />
                    <fo:region-after extent="20mm" />
                    <fo:region-start extent="12mm" />
                    <fo:region-end extent="12mm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <!-- The static content will be displayed in all pages -->
            <fo:page-sequence master-reference="New-Pdf">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block>
                        <fo:table table-layout="fixed" width="100%">
                            <fo:table-column column-width="proportional-column-width(100)" />
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:table table-layout="fixed" width="100%">
                                            <fo:table-column column-width="proportional-column-width(100)" />
                                            <fo:table-body>
                                                <fo:table-row>
                                                    <fo:table-cell display-align="before">
                                                        <xsl:variable name="pdfLogo">
                                                            <xsl:value-of select="pdfImage" />
                                                        </xsl:variable>
                                                        <fo:block-container height="10mm">
													        <fo:block>
													        </fo:block>
														</fo:block-container>
                                                        <fo:block text-align="left">
                                                            <fo:external-graphic src="{$pdfLogo}" content-height="scale-to-fit" height="11.7mm"
                                                                content-width="30mm" scaling="non-uniform" />
                                                        </fo:block>
                                                        <fo:block font-weight="bold" font-size="2.5mm" font-family="Helvetica" text-align="right"
                                                            white-space="pre">
                                                            <fo:block xmlns:date="http://exslt.org/dates-and-times">
                                                                <xsl:variable name="now" select="date:date-time()" />
                                                                <xsl:value-of select="date:day-in-month($now)" />
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="date:month-name($now)" />
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="date:year($now)" />
                                                                <fo:block />
                                                                <xsl:value-of select="date:hour-in-day($now)" />
                                                                <xsl:text>:</xsl:text>
                                                                <xsl:value-of select="date:minute-in-hour($now)" />
                                                                <xsl:text>:</xsl:text>
                                                                <xsl:value-of select="date:second-in-minute($now)" />
                                                            </fo:block>
                                                        </fo:block>
                                                    </fo:table-cell>
                                                </fo:table-row>
                                            </fo:table-body>
                                        </fo:table>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                    <fo:block>
					</fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">

                    <fo:block>
                        <fo:leader leader-length="100%" leader-pattern="rule"></fo:leader>
                    </fo:block>
                    <fo:block font-size="2.5mm" text-align="right">
                        Page
                        <fo:page-number />
                        of
                        <fo:page-number-citation ref-id="last-page" />
                    </fo:block>
                </fo:static-content>
                <!-- The body of the PDF paage contains the static header portion , data 
                    portion and footer portion -->
                <fo:flow flow-name="xsl-region-body">
                    <xsl:choose>
                        <xsl:when test="pageData!=''">
                            <xsl:for-each select="pageData">
                                <fo:block font-weight="bold" font-family="Helvetica" break-before="page">
                                    <xsl:apply-templates select="header" />
                                </fo:block>
                                <fo:block font-family="Helvetica">
                                    <xsl:for-each select="r">
                                        <xsl:variable name="Rowpos">
                                            <xsl:value-of select="(position() mod 2)" />
                                        </xsl:variable>
                                        <xsl:call-template name="Dataportion">
                                            <xsl:with-param name="Rowpos" select="$Rowpos" />
                                        </xsl:call-template>
                                    </xsl:for-each>
                                </fo:block>
                                <fo:block space-after="5mm" font-weight="bold" font-family="Helvetica">
                                    <xsl:apply-templates select="footer" />
                                </fo:block>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:block font-weight="bold" font-family="Helvetica">
                                <xsl:apply-templates select="header" />
                            </fo:block>
                            <fo:block font-family="Helvetica">
                                <xsl:for-each select="r">
                                    <xsl:variable name="Rowpos">
                                        <xsl:value-of select="(position() mod 2)" />
                                    </xsl:variable>
                                    <xsl:call-template name="Dataportion">
                                        <xsl:with-param name="Rowpos" select="$Rowpos" />
                                    </xsl:call-template>
                                </xsl:for-each>
                            </fo:block>
                            <fo:block space-after="5mm" font-weight="bold" font-family="Helvetica">
                                <xsl:apply-templates select="footer" />
                            </fo:block>
                        </xsl:otherwise>
                    </xsl:choose>
                    <fo:block id="last-page" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <!-- Template for header -->
    <xsl:template match="header">
        <xsl:if test="r">
            <xsl:variable name="maxHeaderColumnCount">
	        	<xsl:for-each select="r">
	        		<xsl:sort select="count(current()//cap)" data-type="number" />
	        		<xsl:if test="position() = last()"> 
						<xsl:value-of select="count(current()//cap)" />
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>
            <xsl:for-each select="r">
                <fo:table table-layout="fixed" width="100%">
                    <fo:table-body>
                        <fo:table-row>
                            <xsl:choose>
                                <xsl:when test="c">
                                    <xsl:for-each select="c">
                                        <xsl:choose>
                                            <xsl:when test="cap != '' ">
                                                <fo:table-cell>
                                                    <xsl:choose>
                                                    <!-- Donot concat the text with unicode character(zero width space) if they are joined. -->
                                                        <xsl:when test="lngDir='RTL'">
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles-ar">
                                                                <xsl:value-of select="cap" />
                                                            </fo:block>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles">
                                                                <xsl:call-template name="zero_width_space_1">
                                                                    <xsl:with-param name="data" select="cap" />
                                                                </xsl:call-template>
                                                            </fo:block>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:table-cell>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:choose>
                                                    <xsl:when test="class!=''">
                                                        <fo:table-cell>
                                                            <xsl:choose>
                                                                <xsl:when test="lngDir='RTL'">
                                                                    <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                        xsl:use-attribute-sets="CustomStyles-ar">
                                                                        <xsl:value-of select="cap" />
                                                                    </fo:block>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                        xsl:use-attribute-sets="CustomStyles">
                                                                        <xsl:call-template name="zero_width_space_1">
                                                                            <xsl:with-param name="data" select="cap" />
                                                                        </xsl:call-template>
                                                                    </fo:block>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </fo:table-cell>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <fo:table-cell>
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm">
                                                                <xsl:call-template name="zero_width_space_1">
                                                                    <xsl:with-param name="data" select="." />
                                                                </xsl:call-template>
                                                            </fo:block>
                                                        </fo:table-cell>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                    <!-- To Insert empty Header blocks -->
                                    <xsl:if test="count(c) &lt; $maxHeaderColumnCount and count(c)!= 1">
                                        <xsl:call-template name="addEmptyBlock">
                                            <xsl:with-param name="counter1" select="($maxHeaderColumnCount)-(count(c))" />
                                        </xsl:call-template>
									</xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-cell>
                                        <fo:block>&#x00A0;</fo:block>
                                    </fo:table-cell>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:for-each>
        </xsl:if>
        <fo:block space-after="2.5mm" font-weight="bold" font-family="Helvetica">
            <xsl:call-template name="ColumnHeaders" />
        </fo:block>
    </xsl:template>

	<xsl:template name="addEmptyBlock">
		<xsl:param name="counter1" />
        <xsl:if test="$counter1 &gt; 0">
			<fo:table-cell>
				<fo:block>
				</fo:block>
			</fo:table-cell>
			<xsl:call-template name="addEmptyBlock">
				<xsl:with-param name="counter1" select="($counter1)-1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
    <!-- Template for column header -->
    <xsl:template name="ColumnHeaders">
        <xsl:if test="//cols/c != ''">
            <xsl:for-each select="//cols">
                <fo:table table-layout="fixed" width="100%">
                    <fo:table-body>
                        <!--fo:table-row border="1pt solid" -->
                        <fo:table-row>
                            <xsl:choose>
                                <xsl:when test="*">
                                    <xsl:for-each select="c">
                                        <xsl:variable name="Colswidth">
                                            <xsl:value-of select="string-length(.)" />
                                        </xsl:variable>
                                        <fo:table-cell background-color="#DEDEDE">
                                            <xsl:choose>
                                                <xsl:when test="lngDir='RTL'">
                                                    <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                        xsl:use-attribute-sets="CustomStyles-ar">
                                                        <xsl:value-of select="." />
                                                    </fo:block>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                        xsl:use-attribute-sets="CustomStyles">
                                                        <xsl:value-of select="." />
                                                    </fo:block>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </fo:table-cell>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-cell>
                                        <fo:block>&#x00A0;</fo:block>
                                    </fo:table-cell>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <!-- Template for Data -->

    <xsl:template name="Dataportion">
        <xsl:param name="Rowpos" />
        <xsl:if test="c/cap != ''">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-body>
                    <fo:table-row>
                        <xsl:for-each select="c">
                            <xsl:choose>
                                <xsl:when test="cap!=''">
                                    <xsl:choose>
                                        <xsl:when test="$Rowpos!=0">
                                            <fo:table-cell>
                                                <xsl:choose>
                                                    <xsl:when test="lngDir='RTL'">
                                                        <fo:block font-size="2.5mm" white-space="normal" margin="1.5mm" xsl:use-attribute-sets="CustomStyles-ar">
                                                            <xsl:if test="i!=''">
                                                                <xsl:attribute name="text-align">right</xsl:attribute>
                                                                <xsl:attribute name="padding-right">5mm</xsl:attribute>
                                                            </xsl:if>
                                                            <xsl:value-of select="cap" />
                                                        </fo:block>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <fo:block font-size="2.5mm" white-space="normal" margin="1.5mm" xsl:use-attribute-sets="CustomStyles">
                                                            <xsl:if test="i!=''">
                                                                <xsl:attribute name="text-align">right</xsl:attribute>
                                                                <xsl:attribute name="padding-right">5mm</xsl:attribute>
                                                            </xsl:if>
                                                            <xsl:call-template name="zero_width_space_1">
                                                                <xsl:with-param name="data" select="cap" />
                                                            </xsl:call-template>
                                                        </fo:block>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <fo:table-cell background-color="#F6F7EF">
                                                <xsl:choose>
                                                    <xsl:when test="lngDir='RTL'">
                                                        <fo:block font-size="2.5mm" white-space="normal" margin="1.5mm" background-color="#F6F7EF"
                                                            xsl:use-attribute-sets="CustomStyles-ar">
                                                            <xsl:if test="i!=''">
                                                                <xsl:attribute name="text-align">right</xsl:attribute>
                                                                <xsl:attribute name="padding-right">5mm</xsl:attribute>
                                                            </xsl:if>
                                                            <xsl:value-of select="cap" />
                                                        </fo:block>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <fo:block font-size="2.5mm" white-space="normal" margin="1.5mm" background-color="#F6F7EF"
                                                            xsl:use-attribute-sets="CustomStyles">
                                                            <xsl:if test="i!=''">
                                                                <xsl:attribute name="text-align">right</xsl:attribute>
                                                                <xsl:attribute name="padding-right">5mm</xsl:attribute>
                                                            </xsl:if>
                                                            <xsl:call-template name="zero_width_space_1">
                                                                <xsl:with-param name="data" select="cap" />
                                                            </xsl:call-template>
                                                        </fo:block>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:table-cell>
                                        </xsl:otherwise>
                                    </xsl:choose>

                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:choose>
                                        <xsl:when test="$Rowpos!=0">
                                            <fo:table-cell>
                                                <fo:block>&#x00A0;</fo:block>
                                            </fo:table-cell>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <fo:table-cell background-color="#F6F7EF">
                                                <fo:block background-color="#F6F7EF">&#x00A0;</fo:block>
                                            </fo:table-cell>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:if>
    </xsl:template>


    <!-- Template for footer -->
    <xsl:template match="footer">
        <xsl:if test="r">
            <xsl:variable name="maxFooterColumnCount">
                <xsl:for-each select="r">
                    <xsl:sort select="count(current()//cap)" data-type="number" />
                    <xsl:if test="position() = last()"> 
                        <xsl:value-of select="count(current()//cap)" />
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:for-each select="r">
                <fo:table table-layout="fixed" width="100%">
                    <fo:table-body>
                        <fo:table-row>
                            <xsl:choose>
                                <xsl:when test="c">
                                    <xsl:for-each select="c">
                                        <xsl:choose>
                                            <xsl:when test="cap != '' ">
                                                <fo:table-cell>
                                                    <xsl:choose>
                                                        <xsl:when test="lngDir='RTL'">
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles-ar">
                                                                <xsl:value-of select="cap" />
                                                            </fo:block>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles">
                                                                <xsl:call-template name="zero_width_space_1">
                                                                    <xsl:with-param name="data" select="cap" />
                                                                </xsl:call-template>
                                                            </fo:block>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:table-cell>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <fo:table-cell>
                                                    <xsl:choose>
                                                        <xsl:when test="lngDir='RTL'">
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles-ar">
                                                                <xsl:value-of select="." />
                                                            </fo:block>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <fo:block font-size="2.5mm" font-weight="bold" text-align="left" white-space="normal" margin="1.5mm"
                                                                xsl:use-attribute-sets="CustomStyles">
                                                                <xsl:call-template name="zero_width_space_1">
                                                                    <xsl:with-param name="data" select="." />
                                                                </xsl:call-template>
                                                            </fo:block>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:table-cell>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>

								    <!-- To Insert empty Footer blocks -->
									<xsl:if test="count(c) &lt; $maxFooterColumnCount and count(c)!= 1">
                                        <xsl:call-template name="addEmptyBlock">
                                            <xsl:with-param name="counter1" select="($maxFooterColumnCount)-(count(c))" />
                                        </xsl:call-template>
                                    </xsl:if>
									
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-cell>
                                        <fo:block>&#x00A0;</fo:block>
                                    </fo:table-cell>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:for-each>

        </xsl:if>
    </xsl:template>
    <!-- Template for word wrap to fit the data content into table cell -->
    <xsl:template name="zero_width_space_1">
        <xsl:param name="data" />
        <xsl:param name="counter" select="0" />
        <xsl:choose>
            <xsl:when test="$counter &lt; string-length($data)+1">
                <xsl:value-of select='concat(substring($data,$counter,1),"&#8203;")' />
                <xsl:call-template name="zero_width_space_2">
                    <xsl:with-param name="data" select="$data" />
                    <xsl:with-param name="counter" select="$counter+1" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="zero_width_space_2">
        <xsl:param name="data" />
        <xsl:param name="counter" />
        <xsl:value-of select='concat(substring($data,$counter,1),"&#8203;")' />
        <xsl:call-template name="zero_width_space_1">
            <xsl:with-param name="data" select="$data" />
            <xsl:with-param name="counter" select="$counter+1" />
        </xsl:call-template>
    </xsl:template>

</xsl:stylesheet>
