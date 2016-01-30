<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
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

<!-- get the name of the OUTER, MIDDLE and INNER tables -->
<xsl:variable name="outer" select="/root/structure/outer/@id"/>
<xsl:variable name="middle" select="/root/structure/middle/@id"/>
<xsl:variable name="inner" select="/root/structure/inner/@id"/>
<xsl:variable name="numrows" select="/root/pagination/page[@id='inner']/@numrows"/>
<xsl:variable name="middle_count" select="/root/*[name()=$outer][1]/*[name()=$middle]"/>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

    <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>
    
    <xsl:call-template name="body-head" />

    <form id="{/root/params/script_short}" method="post" action="{$script}">
  
      <div class="universe">
  
        <!-- create help button -->
        <xsl:call-template name="help" />
  
        <!-- create menu buttons -->
        <xsl:call-template name="menubar" />
  
        <div class="body">
  
          <div class="title">
            <h1 class="title"><xsl:value-of select="$title"/></h1>
          </div>
  
          <div class="outer">
  
            <!-- This is the OUTER table -->
            <table>
              <xsl:for-each select="/root/*[name()=$outer][1]">
                <!-- display all the fields in the current row -->
                <xsl:call-template name="display_vertical">
                  <xsl:with-param name="zone"   select="'outer'"/>
                  <xsl:with-param name="noedit" select="string(/root/params/outer_noedit)"/>
                </xsl:call-template>
              </xsl:for-each>
            </table>
  
            <!-- insert the scrolling links for OUTER table -->
            <xsl:call-template name="scrolling" >
              <xsl:with-param name="object" select="$outer"/>
            </xsl:call-template>
  
          </div>
  
          <div class="middle">
  
            <!-- This is the MIDDLE table -->
            <!-- which can display either one row (the default) or multiple rows at a time -->
            <table>
              <xsl:choose>
                <xsl:when test="/root/params/middle_multiple = 'y'">
                  <!-- allow this area to show multiple rows -->
                  
                  <!-- set up column widths -->
                  <xsl:call-template name="column_group">
                    <xsl:with-param name="zone" select="'middle'"/>
                  </xsl:call-template>
                  
                  <thead>
                    <!-- set up column headings -->
                    <xsl:call-template name="column_headings">
                      <xsl:with-param name="zone"   select="'middle'"/>
                      <xsl:with-param name="nosort" select="string(/root/params/middle_nosort)"/>
                    </xsl:call-template>
                  </thead>
                  
                  <tbody>
                    <!-- process each non-empty row in the MIDDLE table of the XML file -->
                    <xsl:for-each select="/root/*[name()=$outer][1]/*[name()=$middle][count(*)&gt;0]">
                      
                      <!-- display all the fields in the current row -->
                      <xsl:call-template name="display_horizontal">
                        <xsl:with-param name="zone"     select="'middle'"/>
                        <xsl:with-param name="currocc"  select="." />
                        <xsl:with-param name="multiple" select="'y'"/>
                        <xsl:with-param name="noedit"   select="string(/root/params/middle_noedit)"/>
                      </xsl:call-template>
                      
                    </xsl:for-each>
                  </tbody>
                </xsl:when>
                
                <xsl:otherwise>
                  <!-- display a single row only -->
                  
                  <xsl:for-each select="/root/*[name()=$outer][1]/*[name()=$middle][1]">
                    <!-- display all the fields in the current row -->
                    <xsl:call-template name="display_vertical">
                      <xsl:with-param name="zone"   select="'middle'"/>
                      <xsl:with-param name="noedit" select="string(/root/params/middle_noedit)"/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </table>
            
            <!-- insert the scrolling links for middle table -->
            <xsl:call-template name="scrolling" >
              <xsl:with-param name="object" select="$middle"/>
            </xsl:call-template>
          </div>
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar">
            <xsl:with-param name="noshow"   select="/root/params/noshow"/>
            <xsl:with-param name="noselect" select="/root/params/noselect"/>
          </xsl:call-template>
  
          <div class="inner">
  
            <!-- this is the INNER table -->
            <table>
              <xsl:choose>
                <xsl:when test="/root/params/inner_vertical = 'y'">
                  <!-- display a single row only -->
                  
                  <xsl:for-each select="/root/*[name()=$outer][1]/*[name()=$middle][1]/*[name()=$inner][1]">
                    <!-- display all the fields in the current row -->
                    <xsl:call-template name="display_vertical">
                      <xsl:with-param name="zone"   select="'inner'"/>
                      <xsl:with-param name="noedit" select="string(/root/params/inner_noedit)"/>
                    </xsl:call-template>
                  </xsl:for-each>
                </xsl:when>
                
                <xsl:otherwise> <!-- default is horzontal display -->
                  <!-- set up column widths -->
                  <xsl:call-template name="column_group">
                    <xsl:with-param name="zone" select="'inner'"/>
                  </xsl:call-template>
      
                  <thead>
                    <!-- set up column headings -->
                    <xsl:call-template name="column_headings">
                      <xsl:with-param name="zone"   select="'inner'"/>
                      <xsl:with-param name="nosort" select="string(/root/params/nosort)"/>
                    </xsl:call-template>
                  </thead>
      
                  <tbody>
                    <!-- process each non-empty row in the INNER table of the XML file -->
                    <xsl:for-each select="/root/*[name()=$outer][1]/*[name()=$middle][$middle_count]/*[name()=$inner][count(*)&gt;0]">
      
                      <!-- display all the fields in the current row -->
                      <xsl:call-template name="display_horizontal">
                        <xsl:with-param name="zone"     select="'inner'"/>
                        <xsl:with-param name="currocc"  select="." />
                        <xsl:with-param name="multiple" select="'y'"/>
                        <xsl:with-param name="noedit"   select="string(/root/params/inner_noedit)"/>
                      </xsl:call-template>
      
                    </xsl:for-each>
                  </tbody>
                </xsl:otherwise>
              </xsl:choose>
              
            </table>
          </div>
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- insert the page navigation links -->
          <xsl:call-template name="pagination" >
            <xsl:with-param name="object" select="'inner'"/>
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
