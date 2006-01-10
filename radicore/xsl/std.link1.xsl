<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:output method='xml'
            indent="yes"
            omit-xml-declaration="yes"
            doctype-public = "-//W3C//DTD XHTML 1.0 Strict//EN"
            doctype-system = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
/>

<!-- include common templates -->
<xsl:include href="std.buttons.xsl"/>
<xsl:include href="std.column_hdg.xsl"/>
<xsl:include href="std.data_field.xsl"/>
<xsl:include href="std.head.xsl"/>
<xsl:include href="std.pagination.xsl"/>

<!-- get the name of the OUTER and LINK tables -->
<xsl:variable name="outer" select="//structure/outer/@id"/>
<xsl:variable name="link" select="//structure/link/@id"/>
<xsl:variable name="numrows" select="//pagination/page[@id='link']/@numrows"/>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">
    <xsl:call-template name="head" />
  <body>

  <xsl:if test="//header">
    <xsl:value-of select="//header" disable-output-escaping="yes"/>
  </xsl:if>

  <form method="post" action="{$script}">

    <div class="universe">

      <!-- create help button -->
      <xsl:call-template name="help" />

      <!-- create menu buttons -->
      <xsl:call-template name="menubar" />

      <div class="body">

        <h1><xsl:value-of select="$title"/></h1>

        <div class="outer">

          <!-- This is the OUTER/PARENT table -->
          <table>
            <xsl:for-each select="//*[name()=$outer][1]">
              <!-- display all the fields in the current row -->
              <xsl:call-template name="display_vertical">
                <xsl:with-param name="zone"   select="'outer'"/>
                <xsl:with-param name="noedit" select="'y'"/>
              </xsl:call-template>
            </xsl:for-each>
          </table>

          <!-- insert the scrolling links for the OUTER/PARENT table -->
          <xsl:call-template name="scrolling" >
            <xsl:with-param name="object" select="$outer"/>
          </xsl:call-template>
        </div>

        <!-- create navigation buttons -->
        <xsl:call-template name="navbar">
          <xsl:with-param name="noshow"   select="//params/noshow"/>
          <xsl:with-param name="noselect" select="//params/noselect"/>
        </xsl:call-template>

        <div class="link">

          <!-- this is the INNER/LINK table -->
          <table>

            <!-- set up column widths -->
            <xsl:call-template name="column_group">
              <xsl:with-param name="table" select="'link'"/>
            </xsl:call-template>

            <thead>
              <!-- set up column headings -->
              <xsl:call-template name="column_headings">
                <xsl:with-param name="table" select="'link'"/>
              </xsl:call-template>
            </thead>

            <tbody>
              <!-- process each non-empty row in the INNER/CHILD table of the XML file -->
              <xsl:for-each select="//*[name()=$link][count(*)&gt;0]">

                <!-- display all the fields in the current row -->
                <xsl:call-template name="display_horizontal">
                  <xsl:with-param name="zone"     select="'link'"/>
                  <xsl:with-param name="multiple" select="'y'"/>
                </xsl:call-template>

              </xsl:for-each>
            </tbody>

          </table>
        </div>

        <!-- look for optional messages -->
        <xsl:call-template name="message"/>

        <!-- insert the page navigation links -->
        <xsl:call-template name="pagination" >
          <xsl:with-param name="object" select="'link'"/>
        </xsl:call-template>

        <!-- create standard action buttons -->
        <xsl:call-template name="actbar"/>

      </div>

    </div>

  </form>

  <xsl:if test="//footer">
    <xsl:value-of select="//footer" disable-output-escaping="yes"/>
  </xsl:if>

  </body>
  </html>

</xsl:template>

</xsl:stylesheet>
