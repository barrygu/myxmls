<?xml version="1.0"?>
<xsl:stylesheet 
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
>
    <xsl:strip-space elements="*"/>
    <xsl:output 
		method="html" 
		encoding="utf-8" 
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

	<xsl:key name="srcname" match="crossbar-inputs/*" use="@id"/>
	<xsl:key name="zonename" match="crossbar-zone-out/*" use="@id"/>
	<xsl:key name="snkname" match="crossbar-zone0-in/*" use="@id"/>
    <xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<style>
                    table {
                        text-align:center; 
                        border:1px solid #666; 
                        margin:1em;
                    }
                    
                    table tbody{
                        vertical-align: top;
                    }
                </style>
				<title>Audio Crossbar Configuration</title>
			</head>
			<body>
				<h1>
					<a name="shortNav">NTG7 Audio Crossbar Config XML</a> - v1.0.0
					<br/>
				</h1>
				<hr/>
				<xsl:apply-templates/>
				<xsl:call-template name="xpara"/>
			</body>
		</html>
    </xsl:template>

    <xsl:template name="connTable">
		<xsl:param name="key"/>
		<xsl:param name="title"/>
		<h1>
			<a name="#{$key}"><xsl:value-of select="$title"/></a>
		</h1>
		<table rules="all" cellpadding="4px">
			<tr bgcolor="lightgreen">
				<th>ID</th>
				<th>SourceID</th>
				<th>ZoneID</th>
				<th>SinkID</th>
			</tr>
			<xsl:for-each select="$key">
				<xsl:variable name="srcid">
					<xsl:value-of select="@sourceIdx"/>
				</xsl:variable>
				<xsl:variable name="srcname">
					<xsl:value-of select="key('srcname', $srcid)/@name"/>
				</xsl:variable>

				<xsl:variable name="zoneid">
					<xsl:value-of select="@zoneIdx"/>
				</xsl:variable>
				<xsl:variable name="zonename">
					<xsl:value-of select="key('zonename', $zoneid)/@name"/>
				</xsl:variable>

				<xsl:variable name="snkid">
					<xsl:value-of select="@sinkIdx"/>
				</xsl:variable>
				<xsl:variable name="snkname">
					<xsl:value-of select="key('snkname', $snkid)/@name"/>
				</xsl:variable>

				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="concat($srcname,' (',$srcid,')')"/></td>
					<td><xsl:value-of select="concat($zonename,' (',$zoneid,')')"/></td>
					<td><xsl:value-of select="concat($snkname,' (',$snkid,')')"/></td>
				</tr>
			</xsl:for-each>
		</table>
    </xsl:template>
	<xsl:template name="xtable">
		<xsl:param name="key"/>
		<xsl:param name="title"/>
		<h1>
			<a name="#{$key}"><xsl:value-of select="$title"/></a>
		</h1>
		<table rules="all" cellpadding="4px">
			<tr bgcolor="lightgreen">
				<th>ID</th>
				<th>Channels</th>
				<th>Offset</th>
				<th>Name</th>
			</tr>
			<xsl:for-each select="$key">
				<tr>
					<td><xsl:value-of select="@id"/></td>
					<td><xsl:value-of select="@channels"/></td>
					<td><xsl:value-of select="@offset"/></td>
					<td align="left"><xsl:value-of select="@name"/></td>
				</tr>
			</xsl:for-each>
		</table>
    </xsl:template>
	<xsl:template name="xpara">
		<xsl:for-each select="crossbar/*">
			<xsl:choose>
			<xsl:when test="name()!='crossbar-connects'">
				<xsl:call-template name="xtable">
					<xsl:with-param name="key" select="node()"/> 
					<xsl:with-param name="title" select='name()'/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="connTable">
					<xsl:with-param name="key" select="node()"/> 
					<xsl:with-param name="title" select='name()'/>
				</xsl:call-template>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
