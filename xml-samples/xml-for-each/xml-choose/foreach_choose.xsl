<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
<head>
<title>Monil-Tennis</title></head>
<body>
<h2><center>Welcome to the Tennis world-Choose Example</center></h2>
<h5><center>Color formatting when titles &gt; 40</center></h5>
<table border="1">
	<tr>
	<th>Name</th>
	<th>Rank</th>
	<th>Titles</th>
	<th>DOB</th>
	<th>GS Count</th>
	</tr>
	<xsl:for-each select="tennis/player">		
	<tr>		
	<td><xsl:value-of select="name"/></td>
	<td><xsl:value-of select="rank"/></td>	
	<xsl:choose>
	<xsl:when test="titles &gt; 40">
	<td bgcolor="#ff00ff"><xsl:value-of select="titles"/></td>	
	</xsl:when>
	<xsl:otherwise>
	<td bgcolor="#ff0000"><xsl:value-of select="titles"/></td>	
	</xsl:otherwise>
	</xsl:choose>
	<td><xsl:value-of select="dob/d"/>-
	      <xsl:value-of select="dob/m"/>-
	      <xsl:value-of select="dob/y"/></td>
	<td><xsl:value-of select="gs"/></td>
	</tr>		
	</xsl:for-each>
</table>	
</body>
</html>
</xsl:template>
</xsl:stylesheet>