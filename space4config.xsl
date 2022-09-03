<?xml version="1.0" encoding="UTF-8"?>
  <!-- xmlns:exsl="http://exslt.org/common" -->
  <!-- xmlns:dyn="http://exslt.org/dynamic" -->
  <!-- extension-element-prefixes="dyn" -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="exsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"
  doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

<xsl:template match="/">
<html>
  <head>
    <!--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>-->
  	<style>
      table {
        text-align:center; 
        border:1px solid #666; 
        margin:1em;
		page-break-inside:avoid;
      }
      table tbody{
        vertical-align: center;
      }
      <!-- @media all { -->
        <!-- .page-break { display: none; } -->
      <!-- } -->
      <!-- @media print { -->
        <!-- .page-break { display: block; page-break-before: always; } -->
      <!-- } -->
  	</style>
  	<title>Space4 Audio Configurations</title>
  </head>
  <body width="90%">
    <h1>Space4 Audio Configurations - <xsl:value-of select="/Space4Config/Versions/Config"/></h1><hr/>
    <xsl:apply-templates select="*"/>
  </body>
</html>
</xsl:template>

<xsl:template match="Space4Config">
  <!-- <xsl:for-each select="*[not(name()='Versions')]"> -->
  <!-- <xsl:for-each select="*[position()>1]"> -->
  <xsl:for-each select="*">
    <!-- <xsl:if test="name()='Processings'"> -->
	  <!-- <div class="page-break"></div> -->
	<!-- </xsl:if> -->
    <h2><xsl:value-of select="name()"/>:</h2>
	<xsl:apply-templates select="."/>
    <hr/><br/>
  </xsl:for-each>
</xsl:template>

<!-- <xsl:template match="DMA/*"> -->
  <!-- <td> -->
    <!-- <xsl:value-of select="name()"/> -->
    <!-- <xsl:text>: </xsl:text> -->
    <!-- <xsl:value-of select="text()"/> -->
  <!-- </td> -->
<!-- </xsl:template> -->
<!-- <xsl:template match="DMA"> -->
  <!-- <table rules="all" cellpadding="4px"> -->
  <!-- <xsl:for-each select="*"> -->
    <!-- <tr> -->
      <!-- <td bgcolor="skyblue"><xsl:value-of select="name()"/></td> -->
      <!-- <xsl:apply-templates select="."/> -->
    <!-- </tr> -->
  <!-- </xsl:for-each> -->
  <!-- </table> -->
<!-- </xsl:template> -->

<xsl:template match="Versions|InputInfo|OutputInfo|SampleSpec|DMA|Buffers">
  <table rules="all" cellpadding="4px">
  <xsl:for-each select="*">
    <tr>
      <td bgcolor="skyblue"><xsl:value-of select="name()"/></td>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="Preprocessings|Postprocessings">
  <table rules="all" cellpadding="4px">
    <tr bgcolor="springgreen">
      <!--<td bgcolor="skyblue"><xsl:value-of select="name(*)"/></td>-->
      <xsl:for-each select="*">
        <td><xsl:apply-templates select="." mode="leaf"/></td>
      </xsl:for-each>
    </tr>
  </table>
</xsl:template>

<xsl:template name="unique">
  <xsl:param name="para"/>
  <xsl:variable name="_StoredItems">
    <xsl:for-each select="$para/*">
      <item><xsl:value-of select="name()"/></item>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="_NodeOfItems" select="exsl:node-set($_StoredItems)/item"/>
  <xsl:for-each select="$_NodeOfItems">
    <xsl:variable name="t" select="text()"/>
    <xsl:if test="generate-id(.)=generate-id($_NodeOfItems[text()=$t][1])">
      <uniprop><xsl:value-of select="text()"/></uniprop>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="*">
  <xsl:variable name="xprops">
    <xsl:call-template name="unique">
      <xsl:with-param name="para" select="*"/> 
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="uniprops" select="exsl:node-set($xprops)/uniprop"/>

  <table rules="all" cellpadding="4px">
    <tr bgcolor="lightgreen">
      <xsl:if test="*/@*">
        <th>
          <xsl:text>@</xsl:text>
          <xsl:value-of select="name(*/@*)"/>
        </th>
      </xsl:if>
      <xsl:for-each select="$uniprops">
        <th><xsl:value-of select="text()"/></th>
      </xsl:for-each>
    </tr>
    <xsl:for-each select="*">
      <tr>
        <xsl:for-each select="@*">
          <td><xsl:value-of select="."/></td>
        </xsl:for-each>
        <xsl:for-each select="*">
          <td><xsl:apply-templates select="." mode="leaf"/></td>
        </xsl:for-each>
      </tr>
    </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="Source" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//Sources/Source/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="Target" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//Target/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="InputInterface" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//InputInterfaces/Interface/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="OutputInterface" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//OutputInterfaces/Interface/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="Crossbar" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//Crossbar/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="_Processing" mode="leaf">
  <xsl:variable name="t" select="text()"/>
  <xsl:value-of select="//Processing/Name[../Index[text()=$t]]"/>
</xsl:template>

<xsl:template match="Processing" mode="leaf">
  <!-- <xsl:variable name="r" select="concat('//',name(),'/Name[../Index[text()=',text(),']]')"/> -->
  <xsl:variable name="t" select="text()"/>
  <!-- <xsl:value-of select="dyn:evaluate($r)"/> -->
  <xsl:value-of select="//Processing/Name[../Index[.=$t]]"/>
</xsl:template>

<xsl:template match="*" mode="leaf">
  <xsl:choose>
    <xsl:when test="*">
  	  <xsl:apply-templates select="."/>
    </xsl:when>
    <xsl:otherwise>
  	  <xsl:value-of select="text()"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>