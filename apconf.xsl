<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
>
<xsl:output method="html" encoding="utf-8" indent="yes"
  doctype-public="-//W3C//DTD XHTML Basic 1.1//EN"
  doctype-system="http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd"/>

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
  	</style>
  	<title>Space4 Audio Processing Configurations</title>
  </head>
  <body width="90%">
    <h1>Space4 Audio Processing Configurations</h1><hr/>
    <xsl:apply-templates select="*"/>
  </body>
</html>
</xsl:template>

<xsl:template match="channelmaps">
  <h2>uuid:<xsl:value-of select="@uuid"/></h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>id</th>
    <th>name</th>
    <th>chidx</th>
    <th>channels</th>
    <th>io</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <td><xsl:value-of select="@id"/></td>
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="@chidx"/></td>
      <td><xsl:value-of select="@channels"/></td>
      <td><xsl:value-of select="@io"/></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>


</xsl:stylesheet>
