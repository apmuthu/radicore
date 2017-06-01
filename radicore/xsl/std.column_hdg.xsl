<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:output method='html'
            indent="yes"
            encoding="UTF-8"
/>
  
<xsl:variable name="orderby" select="/root/params/orderby"/>
<xsl:variable name="order" select="/root/params/order"/>

<!-- create <colgroup> entries -->
<xsl:template name="column_group">
  <xsl:param name="zone"/>   <!-- name of this zone (outer/middle/inner) -->
  <xsl:param name="count"/>  <!-- repeat count for filepickser -->

  <colgroup> <!-- these are all within a singe <colgroup> tag -->
    <xsl:call-template name="col_group">
      <xsl:with-param name="zone" select="$zone"/>
      <xsl:with-param name="count" select="$count"/>
    </xsl:call-template>
  </colgroup>

</xsl:template> <!-- COLUMN_GROUP -->

<xsl:template name="col_group">
  <xsl:param name="zone"/>    <!-- name of this zone (outer/middle/inner) -->
  <xsl:param name="count"/>   <!-- repeat count -->

  <xsl:for-each select="/root/structure/*[name()=$zone]/columns/column">
    <!-- copy all column attributes and values to output document -->
    <col>
      <!-- <xsl:copy-of select="@*" /> -->

      <xsl:if test="@width">
        <xsl:attribute name="width" ><xsl:value-of select="@width" /></xsl:attribute>
      </xsl:if>
      <!-- the 'class' attribute will now be added to all the cells within this column
      <xsl:if test="@class">
        <xsl:attribute name="class" ><xsl:value-of select="@class" /></xsl:attribute>
      </xsl:if>
      -->
      <xsl:if test="@align">
        <xsl:attribute name="align" ><xsl:value-of select="@align" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@valign">
        <xsl:attribute name="valign" ><xsl:value-of select="@valign" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@char">
        <xsl:attribute name="char" ><xsl:value-of select="@char" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@style">
        <xsl:attribute name="style" ><xsl:value-of select="@style" /></xsl:attribute>
      </xsl:if>
    </col>
  </xsl:for-each>

  <xsl:if test="$count &gt; 1">
    <!-- repeat all <col> entries until $count is reduced to 1 -->
    <xsl:call-template name="col_group">
      <xsl:with-param name="zone" select="$zone"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- COL_GROUP -->
  
  
  
<!-- create <colgroup> entries for a selected row among multiple rows -->
<xsl:template name="column_group_multirow">
  <xsl:param name="zone"/>
  <xsl:param name="position"/>
    
  <xsl:for-each select="/root/structure/*[name()=$zone]/table[position()=$position]/columns/column">
    <!-- copy all column attributes and values to output document -->
    <col>
      <!-- <xsl:copy-of select="@*" /> -->
      
      <xsl:if test="@width">
        <xsl:attribute name="width" ><xsl:value-of select="@width" /></xsl:attribute>
      </xsl:if>
      <!-- the 'class' attribute will now be added to all the cells within this column
    <xsl:if test="@class">
      <xsl:attribute name="class" ><xsl:value-of select="@class" /></xsl:attribute>
    </xsl:if>
    -->
      <xsl:if test="@align">
        <xsl:attribute name="align" ><xsl:value-of select="@align" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@valign">
        <xsl:attribute name="valign" ><xsl:value-of select="@valign" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@char">
        <xsl:attribute name="char" ><xsl:value-of select="@char" /></xsl:attribute>
      </xsl:if>
      <xsl:if test="@style">
        <xsl:attribute name="style" ><xsl:value-of select="@style" /></xsl:attribute>
      </xsl:if>
    </col>
  </xsl:for-each>
    
</xsl:template> <!-- COLUMN_GROUP_MULTIROW -->
  
  
  
  
  
  


<!-- set up the column headings using fieldlist in XML file -->
<xsl:template name="column_headings">
  <xsl:param name="zone"/>
  <xsl:param name="count"/>   <!-- how many times the headings are to be repeated -->
  <xsl:param name="nosort"/>  <!-- do not make any heading into a hyperlink for sorting -->

  <tr> <!-- these are all within a single row -->
    <xsl:call-template name="column_heading">
      <xsl:with-param name="zone" select="$zone"/>
      <xsl:with-param name="count" select="$count"/>
      <xsl:with-param name="nosort_all" select="$nosort"/>
    </xsl:call-template>
  </tr>

</xsl:template> <!-- COLUMN_HEADINGS -->

<xsl:template name="column_heading">
  <xsl:param name="zone"/>
  <xsl:param name="count"/>
  <xsl:param name="nosort_all"/>

  <xsl:for-each select="/root/structure/*[name()=$zone]/row/cell[@label]">
    <th>
      <xsl:if test="@colspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@colspan"/>
        </xsl:attribute>
      </xsl:if>

      <xsl:if test="string-length(@label)">

        <xsl:call-template name="column_hdg">
          <!-- get fieldname from the FIELD attribute of the following sibling -->
          <xsl:with-param name="fieldname" select="string(following-sibling::*[@field]/@field)" />
          <xsl:with-param name="label" select="@label"/>
          <xsl:with-param name="zone" select="$zone"/>
          <xsl:with-param name="position" select="position()"/>
          <xsl:with-param name="nosort_all" select="$nosort_all"/>
          <xsl:with-param name="nosort_column" select="@nosort"/>
        </xsl:call-template>
      </xsl:if>
    </th>
  </xsl:for-each>

  <xsl:if test="$count &gt; 1">
    <!-- repeat all headings until $count is reduced to 1 -->
    <xsl:call-template name="column_heading">
      <xsl:with-param name="zone" select="$zone"/>
      <xsl:with-param name="nosort_all" select="$nosort_all"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- COLUMN_HEADING -->

<!-- create a single column heading -->
<xsl:template name="column_hdg">
  <xsl:param name="fieldname"/>
  <xsl:param name="label"/>
  <xsl:param name="zone"/>
  <xsl:param name="position"/>
  <xsl:param name="nosort_all"/>
  <xsl:param name="nosort_column"/>  <!-- from the 'structure/$zone/row' specifications -->

  <!-- look for 2nd 'nosort' option supplied in the column structure specifications -->
  <xsl:variable name="nosort_column2" select="/root/structure/*[name()=$zone]/columns/column[position()=$position]/@nosort" />

  <xsl:choose>

    <xsl:when test="$fieldname='selectbox'">
      <!-- text only, no hyperlink -->
      <xsl:value-of select="$label"/>
    </xsl:when>
    
    <xsl:when test="$numrows > 0 and not($nosort_all) and not($nosort_column) and not($nosort_column2)">
      <!-- $numrows is one of the XSL parameters -->
      <!-- note that if 'nosort' is set there are no hyperlinks for sorting -->

      <!-- create hyperlink to sort on this field -->
      <a href="{$script}?{$session}&amp;orderby={$fieldname}">
        <!-- this is the visible text for the hyperlink -->
        <!--<xsl:value-of select="$label"/>-->
        <xsl:call-template name="replace">
          <xsl:with-param name="text" select="$label"/>
          <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
          <xsl:with-param name="by" select="'&#160;'"/>
        </xsl:call-template>
      </a>
      <!-- if sorted by this field insert ascending or descending image -->
      <xsl:if test="$orderby=$fieldname">
        <img src="{$imagedir}order_{$order}.gif" height="16" width="16" alt="order_{$order}.gif" />
      </xsl:if>

    </xsl:when>

    <xsl:otherwise>
      <!-- no sorting allowed, so don't bother with the hyperlink -->
      <!--<xsl:value-of select="$label"/>-->
      <xsl:call-template name="replace">
        <xsl:with-param name="text" select="$label"/>
        <xsl:with-param name="replace" select="'&amp;nbsp;'"/>
        <xsl:with-param name="by" select="'&#160;'"/>
      </xsl:call-template>
      
    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- COLUMN_HDG -->

</xsl:stylesheet>
