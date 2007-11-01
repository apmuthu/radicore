<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:variable name="title" select="/root/params/title"/>

<xsl:variable name="imagedir">
  <xsl:choose>
    <xsl:when test="/root/params/application='sample'">
      <!-- this is for the sample application -->
      <xsl:text>images/</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <!-- this is for the full application -->
      <xsl:text>../images/</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template name="head">

  <!-- output standard <HEAD> element into HTML document -->
  <head>
    <title><xsl:value-of select="$title"/></title>

    <xsl:if test="/root/params/screen_refresh">
      <!-- cause the browser to refresh this screen every N seconds -->
      <meta http-equiv="refresh">
        <xsl:attribute name="content">
          <xsl:value-of select="/root/params/screen_refresh" />
          <xsl:text>;</xsl:text>
          <xsl:value-of select="$script"/>
        </xsl:attribute>
      </meta>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="/root/params/application='sample'">
        <!-- this is for the sample application -->
        <link rel="stylesheet" type="text/css" href="style_default.css" />
        <link rel="stylesheet" type="text/css" href="style_custom.css" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="/root/cssfiles/filename">
          <link rel="stylesheet" type="text/css" href="{node()}" />
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:for-each select="/root/javascript/head">
      <xsl:choose>
        <xsl:when test="@type='file'">
          <script language="javascript" src="{node()}" />
        </xsl:when>
        <xsl:when test="@type='code'">
          <script language="javascript">
            <xsl:value-of select="node()" disable-output-escaping="yes"/>
          </script>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>

  </head>

</xsl:template>

</xsl:stylesheet>
