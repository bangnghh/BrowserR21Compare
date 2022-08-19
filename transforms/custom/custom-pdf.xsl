<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:attribute-set name="CustomStyles">
    <!-- This file is introduced for embedding custom fonts/hyphenation in pdf -->

    <!--#################### FONTS #################### -->
        <!--Start -->
            <!--You can provide multple comma seperated font-family, Please donot remove Helvetica as its required to render unicode characters. 
            Uncomment the line below and Enter the title of the font to be used for eg, SimHei for Chinese characters.-->
     
            <!-- <xsl:attribute name="font-family">Helvetica, SimHei</xsl:attribute> -->

        <!-- End -->

    <!--#################### HYPHENATION  ############# -->
        <!--Start -->
            <!-- Below lines control the hyphenation -->

		<xsl:attribute name="hyphenate">true</xsl:attribute>
		<xsl:attribute name="language">en</xsl:attribute> 

        <!-- End -->
	</xsl:attribute-set>
	
    <!--For languages with typographical ligatures,for example Arabic-->
	<xsl:attribute-set name="CustomStyles-ar">
		<xsl:attribute name="font-family">Helvetica, Arabic Typesetting</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>