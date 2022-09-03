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
  	<title>Space4 Audio Configurations</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});
    </script>
  </head>
  <body width="90%">
    <h1>Space4 Audio Configurations - <xsl:value-of select="/audioRoutingConfiguration/@version"/></h1><hr/>
    <xsl:apply-templates select="*"/>
  </body>
</html>
</xsl:template>

<xsl:template match="audioswitch">
  <h2><xsl:value-of select="name()"/>:</h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>name</th>
    <th>enable</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="@enable"/></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="devicesconf">
  <h2><xsl:value-of select="name()"/>:</h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>id</th>
    <th>type</th>
    <th>source</th>
    <th>busaddress</th>
    <th>ecnrcase</th>
    <th>channelmap</th>
    <th>rate</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <td><xsl:value-of select="@id"/></td>
      <td><xsl:value-of select="@type"/></td>
      <td><xsl:value-of select="@source"/></td>
      <td><xsl:value-of select="@busaddress"/></td>
      <td><xsl:value-of select="@ecnrcase"/></td>
      <td><xsl:value-of select="@channelmap"/></td>
      <td><xsl:value-of select="@rate"/></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="alsaportsconf">
  <h2><xsl:value-of select="name()"/>:</h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>id</th>
    <th>name</th>
    <th>sndhwdev</th>
    <th>vendorid</th>
    <th>channels</th>
    <th>rate</th>
    <th>bitwidth</th>
    <th>periodsize</th>
    <th>periodcount</th>
    <th>startthreshold</th>
    <th>stopthreshold</th>
    <th>silencethreshold</th>
    <th>silencesize</th>
    <th>availmin</th>
    <th>clock</th>
    <th>access</th>
    <th>channelmap</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <td><xsl:value-of select="@id"/></td>
      <td><xsl:value-of select="@name"/></td>
      <td><xsl:value-of select="@sndhwdev"/></td>
      <td><xsl:value-of select="@vendorid"/></td>
      <td><xsl:value-of select="@channels"/></td>
      <td><xsl:value-of select="@rate"/></td>
      <td><xsl:value-of select="@bitwidth"/></td>
      <td><xsl:value-of select="@periodsize"/></td>
      <td><xsl:value-of select="@periodcount"/></td>
      <td><xsl:value-of select="@startthreshold"/></td>
      <td><xsl:value-of select="@stopthreshold"/></td>
      <td><xsl:value-of select="@silencethreshold"/></td>
      <td><xsl:value-of select="@silencesize"/></td>
      <td><xsl:value-of select="@availmin"/></td>
      <td><xsl:value-of select="@clock"/></td>
      <td><xsl:value-of select="@access"/></td>
      <td><xsl:value-of select="@channelmap"/></td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="moduleslist">
  <h2><xsl:value-of select="name()"/>:</h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>id</th>
    <th>uuid</th>
    <th>name</th>
    <th>type</th>
    <th>rate</th>
    <th>channels</th>
    <th>bitwidth</th>
    <th>periodsize</th>
    <th>periodcount</th>
    <th>inputportnum</th>
    <th>outputportnum</th>
    <th>threadcount</th>
    <th>library</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <xsl:for-each select="@*">
        <td><xsl:value-of select="."/></td>
      </xsl:for-each>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="pathconf">
  <h2><xsl:value-of select="name()"/>:</h2>
  <table rules="all" cellpadding="4px">
  <tr bgcolor="darkgray">
    <th>name</th>
    <th>dir</th>
    <th>mode</th>
    <th>period</th>
    <th>rate</th>
    <th>path</th>
  </tr>
  <xsl:for-each select="*">
    <tr>
      <xsl:for-each select="@*">
        <td><xsl:value-of select="."/></td>
      </xsl:for-each>
	    <td>
        <div class="mermaid">
        <xsl:text>graph LR;</xsl:text>
          <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </div>
	    </td>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="includes">
  <xsl:for-each select="*">
    <xsl:apply-templates select="//pathconf/path[@name=current()/@pathname]/connections"/>
  </xsl:for-each>
</xsl:template>

<xsl:template name="normText">
  <xsl:param name="text"/>
  <xsl:value-of select="translate($text, '[]', '')" />
  <xsl:if test="contains($text,':')">
    <xsl:text>["</xsl:text>
    <xsl:value-of select="substring-before($text, ':')" />
    <xsl:text>&lt;br&gt;</xsl:text>
    <xsl:value-of select="substring-after($text, ':')" />
    <xsl:text>"]</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="connections">
  <xsl:for-each select="*">
    <xsl:call-template name="normText">
      <xsl:with-param name="text" select="@from"/> 
    </xsl:call-template>
    <xsl:text>--></xsl:text>
    <xsl:if test="@outchmap!='' or @inchmap!=''"><xsl:text>|</xsl:text></xsl:if>
    <xsl:if test="@outchmap!=''"><xsl:value-of select="@outchmap"/></xsl:if>
    <xsl:if test="@outchmap!='' and @inchmap!=''"><xsl:text>:</xsl:text></xsl:if>
    <xsl:if test="@inchmap!=''"><xsl:value-of select="@inchmap"/></xsl:if>
    <xsl:if test="@outchmap!='' or @inchmap!=''"><xsl:text>|</xsl:text></xsl:if>
    <xsl:call-template name="normText">
      <xsl:with-param name="text" select="@to"/> 
    </xsl:call-template>
    <xsl:text>;</xsl:text>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
