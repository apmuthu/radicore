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

<!-- get the name of the MAIN table -->
<xsl:variable name="main" select="/root/structure/main/@id"/>
<xsl:variable name="numrows" select="count(/root/*[name()=$main])"/>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:for-each select="/root/javascript/body[@*]">
      <!-- add javascript events to the <body> tag -->
      <xsl:copy-of select="@*" />
    </xsl:for-each>

  <xsl:if test="/root/header">
    <div class="header">
      <xsl:value-of select="/root/header" disable-output-escaping="yes"/>
    </div>
  </xsl:if>

  <form method="post" action="{$script}">

    <div class="universe">

      <!-- create help button -->
      <xsl:call-template name="help" />

      <!-- create menu buttons -->
      <xsl:call-template name="menubar" />

      <div class="body">

        <h1><xsl:value-of select="$title"/></h1>

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
              <xsl:with-param name="count" select="'2'"/>
            </xsl:call-template>

            <thead>
              <!-- set up column headings -->
              <xsl:call-template name="column_headings">
                <xsl:with-param name="zone"   select="'main'"/>
                <xsl:with-param name="count"  select="'2'"/>
                <xsl:with-param name="nosort" select="/root/params/nosort"/>
              </xsl:call-template>
            </thead>

            <tbody>
              <!-- process each odd-numbered row in the MAIN table of the XML file -->
              <!-- (even-numbered entries are automatically appended) -->
              <xsl:for-each select="/root/*[name()=$main][position()mod 2=1]">

                <!-- display all the fields in the current row -->
                <xsl:call-template name="display_file">
                  <xsl:with-param name="zone" select="'main'"/>
                </xsl:call-template>

              </xsl:for-each>
            </tbody>

          </table>
        </div>

        <!-- look for optional messages -->
        <xsl:call-template name="message"/>

        <!-- insert the page navigation links -->
        <xsl:call-template name="pagination" >
          <xsl:with-param name="object" select="'main'"/>
        </xsl:call-template>

        <!-- create standard action buttons -->
        <xsl:call-template name="actbar" />

      </div>

    </div>

  </form>

  <xsl:if test="/root/params/version">
    <div class="version">
      <xsl:value-of select="/root/params/version" />
    </div>
  </xsl:if>

  <xsl:if test="/root/footer">
    <div class="footer">
      <xsl:value-of select="/root/footer" disable-output-escaping="yes"/>
    </div>
  </xsl:if>

  </body>
  </html>

</xsl:template>



<xsl:template name="display_file">
  <xsl:param name="item"/>

  <!-- set the row class to 'odd' or 'even' to determine the colour -->
  <tr>
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <!-- these table cells contain the data for 'odd' numbered entries -->
    <td>
      <a href="{$script}?{$session}&amp;select={node()}"><b><xsl:value-of select="node()" /></b></a>
    </td>
    <td>
      <xsl:call-template name="icon">
        <xsl:with-param name="icon" select="node()" />
        <xsl:with-param name="height" select="/root/structure/main/row/cell/@imageheight" />
        <xsl:with-param name="width" select="/root/structure/main/row/cell/@imagewidth" />
      </xsl:call-template>
    </td>

    <!-- these table cells contain the data for 'even' numbered entries -->
    <xsl:choose>

      <!-- look for a sibling with same name as current node -->
      <xsl:when test="count(following-sibling::*[name()=name(current())])">
        <td>
          <a href="{$script}?{$session}&amp;select={following-sibling::*}"><b><xsl:value-of select="following-sibling::*" /></b></a>
        </td>
        <td>
          <xsl:call-template name="icon">
            <xsl:with-param name="icon" select="following-sibling::*" />
            <xsl:with-param name="height" select="/root/structure/main/row/cell/@imageheight" />
            <xsl:with-param name="width" select="/root/structure/main/row/cell/@imagewidth" />
          </xsl:call-template>
        </td>
      </xsl:when>

      <!-- there is nothing to follow, so create empty cells -->
      <xsl:otherwise>
        <td></td>
        <td></td>
      </xsl:otherwise>

    </xsl:choose>

  </tr>

</xsl:template>

</xsl:stylesheet>
