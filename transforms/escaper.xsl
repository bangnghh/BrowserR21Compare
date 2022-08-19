<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="escape-apos">
		<xsl:variable name="mne" select='"\"' />
		<xsl:variable name="mnemonic" select="string(/responseDetails/userDetails/mnemonic)" />
		<xsl:param name="string" />
		<xsl:variable name="AccVal">
			<xsl:value-of select="substring-before($string, $mne)" />
		</xsl:variable>
		<!-- create an $apos variable to make it easier to refer to -->
		<xsl:variable name="apos" select='"&apos;"' />
		<!-- create an ~Siq# variable to make it easier to refer to -->
		<xsl:variable name="siq" select='"~Siq#"' />
		<xsl:choose>
			<!-- if the string contains an apostrophe... -->
			<xsl:when test="contains($string, $apos)">
				<!-- ... give the value before the apostrophe... -->
				<xsl:value-of select="substring-before($string, $apos)" />
				<!-- ... the escaped apostrophe ... -->
				<xsl:text>\'</xsl:text>
				<!-- ... and the result of applying the template to the string after the apostrophe -->
				<xsl:call-template name="escape-apos">
					<xsl:with-param name="string" select="substring-after($string, $apos)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="contains($string, $siq)">
				<!-- ... give the value before the single quote encoded value... -->
				<xsl:value-of select="substring-before($string, $siq)" />
				<!-- ... the escaped single quote encoded value ... -->
				<xsl:text>\'</xsl:text>
				<!-- ... and the result of applying the template to the string after the single quote -->
				<xsl:call-template name="escape-apos">
					<xsl:with-param name="string" select="substring-after($string, $siq)" />
				</xsl:call-template>
			</xsl:when>
			<!-- check account is internal and add corresponding mnemonic to acc.. -->
			<xsl:when test="(contains($string,$mne))and(string(number(substring($string,1,3)))='NaN') and (not(number (string-length ($AccVal) &gt;= 16))) ">
				<xsl:variable name="mnemo">
					<xsl:value-of select="substring-after($string, $mne)" />
				</xsl:variable>
				<xsl:choose>
					<!-- if internal acc belongs to same company,not to add mnemonic info.. -->
					<xsl:when test="$mnemonic != $mnemo ">
						<xsl:value-of select="substring-before($string, $mne)" />
						<xsl:text>\\</xsl:text>
						<xsl:value-of select="substring-after($string, $mne)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring-before($string, $mne)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- For customer account,only acc info has to provide.. -->
			<xsl:when test="(contains($string, $mne))and(string(number(substring($string,1,3))) !='NaN')">
				<xsl:value-of select="substring-before($string, $mne)" />
			</xsl:when>
			<!-- otherwise... -->
			<xsl:otherwise>
				<!-- ... just give the value of the string -->
				<xsl:value-of select="$string" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Parentheses character are black listed in T24 Browser to prevent XSS cross site scripting. Use the below template to remove the parentheses -->
	<xsl:template name="remove-parentheses">
		<xsl:param name="string" />
		<xsl:variable name="opb" select='"~Opb#"' />
		<xsl:variable name="clb" select='"~Clb#"' />
		<xsl:choose>
			<!-- when open parenthesis is present remove it -->
			<xsl:when test="contains($string, $opb)">
				<xsl:value-of select="substring-before($string, $opb)" />
				<xsl:call-template name="remove-parentheses">
					<xsl:with-param name="string" select="substring-after($string, $opb)" />
				</xsl:call-template>
			</xsl:when>
			<!-- when close parenthesis is present remove it -->
			<xsl:when test="contains($string, $clb)">
				<xsl:value-of select="substring-before($string, $clb)" />
				<xsl:call-template name="remove-parentheses">
					<xsl:with-param name="string" select="substring-after($string, $clb)" />
				</xsl:call-template>
			</xsl:when>
			<!-- otherwise... -->
			<xsl:otherwise>
				<!-- ... just give the value of the string -->
				<xsl:value-of select="$string" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Encode apostrophe, double quote and escape with \ before passing the value as parameter in javascript function -->
	<xsl:template name="encodeAndEscape-quote">

		<xsl:param name="string" />
		<!-- create variables to make it easier to refer to -->
		<xsl:variable name="apos" select='"&apos;"' />
		<xsl:variable name="siq" select='"~Siq#"' />
		<xsl:variable name="quot" select="'&quot;'" />
		<xsl:variable name="doq" select='"~Doq#"' />

	<xsl:choose>
		<!-- if the string contains an apostrophe... -->
		<xsl:when test="contains($string, $apos)">
			<!-- ... give the value before the apostrophe... -->
			<xsl:value-of select="substring-before($string, $apos)" />
			<!-- ... the encoded and escaped apostrophe ... -->
			<xsl:text>\&apos;</xsl:text>
			<!-- ... and the result of applying the template to the string after the apostrophe -->
			<xsl:call-template name="encodeAndEscape-quote">
				<xsl:with-param name="string" select="substring-after($string, $apos)" />
			</xsl:call-template>
		</xsl:when>

		<!-- if the string contains ~Siq#... -->
		<xsl:when test="contains($string, $siq)">
			<!-- ... give the value before the ~Siq# encoded value... -->
			<xsl:value-of select="substring-before($string, $siq)" />
			<!-- ... the encoded and escaped single quote ... -->
			<xsl:text>\&apos;</xsl:text>
			<!-- ... and the result of applying the template to the string after the single quote -->
			<xsl:call-template name="encodeAndEscape-quote">
				<xsl:with-param name="string" select="substring-after($string, $siq)" />
			</xsl:call-template>
		</xsl:when>

		<!-- if the string contains a quote... -->
		<xsl:when test="contains($string, $quot)">
			<!-- ... give the value before the quote... -->
			<xsl:value-of select="substring-before($string, $quot)" />
			<!-- ... the encoded and escaped quote ... -->
			<xsl:text>\&quot;</xsl:text>
			<!-- ... and the result of applying the template to the string after the quote -->
			<xsl:call-template name="encodeAndEscape-quote">
				<xsl:with-param name="string" select="substring-after($string, $quot)" />
			</xsl:call-template>
		</xsl:when>		

		<!-- if the string contains ~Doq#... -->
		<xsl:when test="contains($string, $doq)">
			<!-- ... give the value before the quote... -->
			<xsl:value-of select="substring-before($string, $doq)" />
			<!-- ... the encoded and escaped quote ... -->
			<xsl:text>\&quot;</xsl:text>
			<!-- ... and the result of applying the template to the string after the quote -->
			<xsl:call-template name="encodeAndEscape-quote">
				<xsl:with-param name="string" select="substring-after($string, $doq)" />
			</xsl:call-template>
		</xsl:when>

		<!-- otherwise... -->
		<xsl:otherwise>
			<!-- ... just give the value of the string -->
			<xsl:value-of select="$string" />
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>

</xsl:stylesheet>