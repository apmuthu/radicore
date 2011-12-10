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
<xsl:variable name="numrows" select="/root/pagination/page[@id='main']/@numrows"/>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>
    
    <xsl:call-template name="body-head" />

    <div class="universe">

      <!-- create help button -->
      <xsl:call-template name="help" />

      <!-- create menu buttons -->
      <xsl:call-template name="menubar" />

      <div class="body">
          
        <div class="title">
          <xsl:choose>
            <!-- identify whether this is with or without the 'quicksearch' option -->
            <xsl:when test="/root/lookup/quicksearch_field">
              <xsl:attribute name="class">title with_quicksearch</xsl:attribute>
              <!-- create an area for the QuickSearch option -->
              <div class="quicksearch">
                <form method="post" action="{$script}">
                  <!-- add a dropdown list for the selectable field names -->
                  <select class="dropdown" name="quicksearch_field">
                    <xsl:for-each select="/root/lookup/quicksearch_field/option">
                      <option value="{@id}" >
                        <xsl:if test="@id=/root/params/quicksearch_default">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="node()"/>
                      </option>
                    </xsl:for-each>
                  </select>
                  <!-- add a text box and a submit button to fire the search-->
                  <input name="quicksearch_value" type="text" value="" size="20" />
                  <input class="submit" type="submit" name="quicksearch" value="Search" />
                  <!-- create a hidden field for session_name -->
                  <xsl:if test="$session_name">
                    <input type="hidden" name="session_name" value="{$session_name}" />
                  </xsl:if>
                </form>
              </div> <!-- quicksearch -->
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="class">title without_quicksearch</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          
          <h1 class="title"><xsl:value-of select="$title"/></h1>
        </div> <!-- title -->

        <form method="post" action="{$script}">
            
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar">
            <xsl:with-param name="noshow"   select="/root/params/noshow"/>
            <xsl:with-param name="noselect" select="/root/params/noselect"/>
          </xsl:call-template>
  
          <div class="main">
  
            <!-- this is the actual data -->
            <table>
  
              <!-- set up column widths -->
              <xsl:call-template name="column_group">
                <xsl:with-param name="zone" select="'main'"/>
              </xsl:call-template>
  
              <thead>
                <!-- set up column headings -->
                <xsl:call-template name="column_headings">
                  <xsl:with-param name="zone"   select="'main'"/>
                  <xsl:with-param name="nosort" select="/root/params/nosort"/>
                </xsl:call-template>
              </thead>
  
              <tbody>
                <!-- process each non-empty row in the MAIN table of the XML file -->
                <xsl:for-each select="/root/*[name()=$main][count(*)&gt;0]">
  
                  <!-- display all the fields in the current row -->
                  <xsl:call-template name="display_horizontal">
                    <xsl:with-param name="zone"    select="'main'"/>
                    <xsl:with-param name="currocc" select="." />
                  </xsl:call-template>
  
                </xsl:for-each>
              </tbody>
  
            </table>
          </div> <!-- main -->
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- insert the page navigation links -->
          <xsl:call-template name="pagination" >
            <xsl:with-param name="object" select="'main'"/>
          </xsl:call-template>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar"/>
          
        </form>
  
      </div> <!-- body -->

    </div> <!-- universe -->

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>

</xsl:stylesheet>
