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

<xsl:variable name="page"  select="/root/params/text/page"/>
<xsl:variable name="item"  select="/root/params/text/item"/>
<xsl:variable name="of"    select="/root/params/text/of"/>
<xsl:variable name="first" select="/root/params/text/first"/>
<xsl:variable name="last"  select="/root/params/text/last"/>
<xsl:variable name="prev"  select="/root/params/text/prev"/>
<xsl:variable name="next"  select="/root/params/text/next"/>

<!--
//*****************************************************************************
// PAGINATION - create links to jump to first/prev/next/last page of current set
//*****************************************************************************
-->
<xsl:template name="pagination">
  <xsl:param name="object" />

  <xsl:if test="not($print-preview)">

    <div class="pagination">

      <!-- look for the entry with the specified value in the id attribute -->
      <xsl:for-each select="//pagination/page[@id=$object]">

        <xsl:choose>
          <xsl:when test="@curpage&lt;=1">
            <!-- we are on page 1, so there is no navigation backwards -->
            <xsl:text>&#171;</xsl:text><xsl:value-of select="$first"/>
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:text>&#8249;</xsl:text><xsl:value-of select="$prev"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- insert links for first/previous page -->
            <a href="{$script}?{$session}&amp;pagination={$object}&amp;page=1"><b>&#171;<xsl:value-of select="$first"/></b></a>
            <xsl:text>&#160;&#160;</xsl:text>
            <a href="{$script}?{$session}&amp;pagination={$object}&amp;page={@curpage -1}"><b>&#8249;<xsl:value-of select="$prev"/></b></a>
          </xsl:otherwise>
        </xsl:choose>

        <!-- insert "page x of y" -->
        <xsl:text>&#160;&#160;(</xsl:text><xsl:value-of select="$page"/><xsl:text> </xsl:text>
        <xsl:value-of select="@curpage"/>
        <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
        <xsl:value-of select="@lastpage"/>
        <xsl:text>)&#160;&#160;</xsl:text>

        <xsl:choose>
          <xsl:when test="@curpage=@lastpage">
            <!-- we are on the last page, so there is no navigation forwards -->
            <xsl:value-of select="$next"/><xsl:text>&#8250;</xsl:text>
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:value-of select="$last"/><xsl:text>&#187;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <!-- insert links for last/next item -->
            <a href="{$script}?{$session}&amp;pagination={$object}&amp;page={@curpage +1}"><b><xsl:value-of select="$next"/>&#8250;</b></a>
            <xsl:text>&#160;&#160;</xsl:text>
            <a href="{$script}?{$session}&amp;pagination={$object}&amp;page={@lastpage}"><b><xsl:value-of select="$last"/>&#187;</b></a>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

    </div>

  </xsl:if>

</xsl:template> <!-- PAGINATION -->

<!--
//*****************************************************************************
// SCROLLING - create links to jump to first/prev/next/last item of current set
//*****************************************************************************
-->
<xsl:template name="scrolling">
  <xsl:param name="object" />

  <xsl:if test="not($print-preview)">

    <div class="scrolling">

      <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->

      <!-- look for the entry with the specified value in the id attribute -->
      <xsl:for-each select="//scrolling/scroll[@id=$object]">

        <!-- include only if there is more than 1 item -->
        <xsl:if test="@lastitem&gt;1">

          <xsl:choose>
            <xsl:when test="@curitem&lt;=1">
              <!-- we are on item 1, so there is no navigation backwards -->
              <xsl:text>&#171;</xsl:text><xsl:value-of select="$first"/>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:text>&#8249;</xsl:text><xsl:value-of select="$prev"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert links for first/previous item -->
              <a href="{$script}?{$session}&amp;scrolling={$object}&amp;item=1"><b>&#171;<xsl:value-of select="$first"/></b></a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="{$script}?{$session}&amp;scrolling={$object}&amp;item={@curitem -1}"><b>&#8249;<xsl:value-of select="$prev"/></b></a>
            </xsl:otherwise>
          </xsl:choose>

          <!-- insert "item x of y" -->
          <xsl:text>&#160;&#160;(</xsl:text><xsl:value-of select="$item"/><xsl:text> </xsl:text>
          <xsl:value-of select="@curitem"/>
          <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
          <xsl:value-of select="@lastitem"/>
          <xsl:text>)&#160;&#160;</xsl:text>

          <xsl:choose>
            <xsl:when test="@curitem=@lastitem">
              <!-- we are on the last item, so there is no navigation forwards -->
              <xsl:value-of select="$next"/><xsl:text>&#8250;</xsl:text>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:value-of select="$last"/><xsl:text>&#187;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert links for last/next item -->
              <a href="{$script}?{$session}&amp;scrolling={$object}&amp;item={@curitem +1}"><b><xsl:value-of select="$next"/>&#8250;</b></a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="{$script}?{$session}&amp;scrolling={$object}&amp;item={@lastitem}"><b><xsl:value-of select="$last"/>&#187;</b></a>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:if>

      </xsl:for-each>

    </div>

  </xsl:if>

</xsl:template> <!-- SCROLLING -->

</xsl:stylesheet>
