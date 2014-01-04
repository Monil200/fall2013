<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
<head>
<title>Monil-Tennis</title></head>
<body>
<h2><center>Welcome to the Tennis world- For-each Example</center></h2>
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
	<td><xsl:value-of select="titles"/></td>	
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