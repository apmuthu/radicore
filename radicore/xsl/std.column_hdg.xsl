<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:variable name="orderby" select="/root/params/orderby"/>
<xsl:variable name="order" select="/root/params/order"/>

<!-- create <colgroup> entries -->
<xsl:template name="column_group">
  <xsl:param name="table"/>
  <xsl:param name="count"/>

  <colgroup>

  <xsl:for-each select="//structure/*[name()=$table]/columns/column">
    <col>
      <xsl:if test="@width">
        <xsl:attribute name="width" ><xsl:value-of select="@width" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@class">
        <xsl:attribute name="class" ><xsl:value-of select="@class" /></xsl:attribute>
      </xsl:if>
    </col>
  </xsl:for-each>

  <xsl:if test="$count &gt; 1">
    <!-- repeat until $count is reduced to 1 -->
    <xsl:call-template name="column_group">
      <xsl:with-param name="table" select="$table"/>
      <xsl:with-param name="count" select="$count -1"/>
    </xsl:call-template>
  </xsl:if>

  </colgroup>

</xsl:template> <!-- COLUMN_GROUP -->


<!-- set up the column headings using fieldlist in XML file -->
<xsl:template name="column_headings">
  <xsl:param name="table"/>
  <xsl:param name="count"/>

  <tr>
    <xsl:call-template name="column_heading">
      <xsl:with-param name="table" select="$table"/>
      <xsl:with-param name="count" select="$count"/>
    </xsl:call-template>
  </tr>

</xsl:template> <!-- COLUMN_HEADINGS -->

<xsl:template name="column_heading">
  <xsl:param name="table"/>
  <xsl:param name="count"/>

  <xsl:for-each select="//structure/*[name()=$table]/item/cell[@label]">
    <th>
      <xsl:if test="string-length(@label)">

        <xsl:call-template name="column_hdg">
          <!-- get fieldname from the FIELD attribute of the following sibling -->
          <xsl:with-param name="fieldname" select="string(following-sibling::*[@field]/@field)" />
          <xsl:with-param name="label" select="@label"/>
          <xsl:with-param name="nosort" select="@nosort"/>
        </xsl:call-template>
      </xsl:if>
    </th>
  </xsl:for-each>

  <xsl:if test="$count &gt; 1">
    <!-- repeat until $count is reduced to 1 -->
    <xsl:call-template name="column_heading">
      <xsl:with-param name="table" select="$table"/>
      <xsl:with-param name="count" select="$count -1"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- COLUMN_HEADING -->

<!-- create a single column heading -->
<xsl:template name="column_hdg">
  <xsl:param name="fieldname"/>
  <xsl:param name="label"/>
  <xsl:param name="nosort"/>
  <xsl:param name="count"/>

  <xsl:choose>

    <xsl:when test="$fieldname='selectbox'">
      <!-- text only, no hyperlink -->
      <xsl:value-of select="$label"/>
    </xsl:when>

    <xsl:when test="$numrows > 0 and not($nosort)">
      <!-- $numrows is one of the XSL parameters -->
      <!-- note that if 'nosort' is set there are no hyperlinks for sorting -->

      <!-- create hyperlink to sort on this field -->
      <a href="{$script}?{$session}&amp;orderby={$fieldname}">
        <!-- this is the visible text for the hyperlink -->
        <xsl:value-of select="$label"/>
      </a>
      <!-- if sorted by this field insert ascending or descending image -->
      <xsl:if test="$orderby=$fieldname">
        <img src="images/order_{$order}.gif" height="16" width="16" alt="order_{$order}.gif" />
      </xsl:if>

    </xsl:when>

    <xsl:otherwise>
      <!-- no sorting allowed, so don't bother with the hyperlink -->
      <xsl:value-of select="$label"/>
    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- COLUMN_HDG -->

</xsl:stylesheet>