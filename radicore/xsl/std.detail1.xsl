<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:output method='xml'
            indent="yes"
            omit-xml-declaration="yes"
            doctype-public = "-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
            encoding="UTF-8"
/>

<!-- include common templates -->
<xsl:include href="std.buttons.xsl"/>
<xsl:include href="std.column_hdg.xsl"/>
<xsl:include href="std.data_field.xsl"/>
<xsl:include href="std.head.xsl"/>
<xsl:include href="std.pagination.xsl"/>

<!-- get the name of the MAIN table -->
<xsl:variable name="main" select="/root/structure/main/@id"/>
<xsl:variable name="numrows">1</xsl:variable>

<xsl:template match="/">

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>

    <xsl:call-template name="body-head" />

    <form id="{/root/params/script_short}" method="post" action="{$script}">
  
      <div>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="$mode='logon'">logon</xsl:when>
            <xsl:when test="$mode='recover'">recover</xsl:when>
            <xsl:otherwise>universe</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
  
        <!-- create help button -->
        <xsl:call-template name="help" />
  
        <xsl:choose>
          <xsl:when test="$mode='logon'"></xsl:when>
          <xsl:when test="$mode='recover'"></xsl:when>
          <xsl:otherwise>
            <!-- create menu buttons -->
            <xsl:call-template name="menubar" />
          </xsl:otherwise>
        </xsl:choose>
  
        <div class="body">
  
          <div class="title">
            <h1 class="title"><xsl:value-of select="$title"/></h1>
          </div>
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar_detail" />
  
          <div class="main">
  
            <!-- insert dummy table for use by optional javascript functions -->
            <xsl:if test="/root/javascript/tbody">
              <table>
                <tbody>
                  <xsl:for-each select="/root/javascript/tbody[@*]">
                    <!-- add javascript events to the <tbody> tag -->
                    <xsl:copy-of select="@*" />
                  </xsl:for-each>
                </tbody>
              </table>
            </xsl:if>
  
            <!-- table contains a row for each database field -->
            <table>
  
              <!-- process the first row in the MAIN table of the XML file -->
              <xsl:for-each select="/root/*[name()=$main][1]">
  
                <!-- display all the fields in the current record -->
                <xsl:call-template name="display_vertical">
                  <xsl:with-param name="zone" select="'main'"/>
                  <xsl:with-param name="noedit" select="string(/root/params/main_noedit)"/>
                </xsl:call-template>
  
              </xsl:for-each>
  
            </table>
          </div>
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- insert the scrolling links for MAIN table -->
          <xsl:call-template name="scrolling" >
            <xsl:with-param name="object" select="$main"/>
          </xsl:call-template>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar"/>
  
        </div>
  
      </div>
  
    </form>

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>

</xsl:stylesheet>
