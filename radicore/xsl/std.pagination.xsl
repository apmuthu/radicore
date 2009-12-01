<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
//*****************************************************************************
-->

<xsl:variable name="page"  select="/root/params/text/page"/>
<xsl:variable name="item"  select="/root/params/text/item"/>
<xsl:variable name="of"    select="/root/params/text/of"/>
<xsl:variable name="first" select="/root/params/text/first"/>
<xsl:variable name="last"  select="/root/params/text/last"/>
<xsl:variable name="prev"  select="/root/params/text/prev"/>
<xsl:variable name="next"  select="/root/params/text/next"/>

<xsl:variable name="pagination_width"  select="/root/params/pagination_width"/>
<xsl:variable name="scrolling_width"  select="/root/params/scrolling_width"/>

<!--
//*****************************************************************************
// PAGINATION - create links to jump to first/prev/next/last page of current set
//*****************************************************************************
-->
<xsl:template name="pagination">
  <xsl:param name="object" />

  <xsl:variable name="paging_href" select='concat($script, "?", $session, "&amp;pagination=", $object, "&amp;page=")' />

  <xsl:if test="not($print-preview)">

    <div class="pagination">

      <!-- look for the entry with the specified value in the id attribute -->
      <xsl:for-each select="/root/pagination/page[@id=$object]">

        <xsl:choose>
          <xsl:when test="@curpage &lt;= 1">
            <!-- we are on the first page, so there is no navigation backwards -->
            <xsl:text>&#171;</xsl:text><xsl:value-of select="$first"/>
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:text>&#8249;</xsl:text><xsl:value-of select="$prev"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- insert links for first/previous page -->
            <a href="{$paging_href}1"><b>&#171;<xsl:value-of select="$first"/></b></a>
            <xsl:text>&#160;&#160;</xsl:text>
            <a href="{$paging_href}{@curpage -1}"><b>&#8249;<xsl:value-of select="$prev"/></b></a>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="$pagination_width > 0">
            <!-- insert "(page (x-2) (x-1) x (x+1) (x+2) of y)" -->
            <xsl:text>&#160;&#160;(</xsl:text><xsl:value-of select="$page"/><xsl:text> </xsl:text>
            <xsl:call-template name="googlestyle">
              <xsl:with-param name="href" select="$paging_href" />
              <xsl:with-param name="first" select="1" />
              <xsl:with-param name="last" select="@lastpage" />
              <xsl:with-param name="current" select="@curpage" />
              <xsl:with-param name="swing" select="$pagination_width" />
            </xsl:call-template>
            <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
            <xsl:value-of select="@lastpage"/><xsl:text>)&#160;&#160;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <!-- insert "page x of y" -->
            <xsl:text>&#160;&#160;</xsl:text><xsl:value-of select="$page"/><xsl:text> </xsl:text>
            <xsl:value-of select="@curpage"/>
            <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
            <xsl:value-of select="@lastpage"/><xsl:text>&#160;&#160;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:choose>
          <xsl:when test="@curpage = @lastpage">
            <!-- we are on the last page, so there is no navigation forwards -->
            <xsl:value-of select="$next"/><xsl:text>&#8250;</xsl:text>
            <xsl:text>&#160;&#160;</xsl:text>
            <xsl:value-of select="$last"/><xsl:text>&#187;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <!-- insert links for last/next item -->
            <a href="{$paging_href}{@curpage +1}"><b><xsl:value-of select="$next"/>&#8250;</b></a>
            <xsl:text>&#160;&#160;</xsl:text>
            <a href="{$paging_href}{@lastpage}"><b><xsl:value-of select="$last"/>&#187;</b></a>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

    </div>

  </xsl:if>

</xsl:template> <!-- PAGINATION -->

<!--
//*****************************************************************************
// GOOGLE-STYLE - create links to jump to "3 4 5 X 7 8 9"  page of current set
//*****************************************************************************
-->
<xsl:template name="googlestyle">
  <xsl:param name="href" />
  <xsl:param name="first" />
  <xsl:param name="last" />
  <xsl:param name="current" />
  <xsl:param name="swing" />  <!-- how many jump pages are displayed on either side -->

  <xsl:variable name="low">
    <xsl:choose>
      <xsl:when test="$current = 0"><xsl:value-of select="'0'" /></xsl:when>
      <xsl:when test="$first &gt; ($current - $swing)"><xsl:value-of select="$first" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="$current - $swing" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="high">
    <xsl:choose>
      <xsl:when test="$last &lt; ($current + $swing)"><xsl:value-of select="$last" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="$current + $swing" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:call-template name="googlestyle_helper">
    <xsl:with-param name="href"    select="$href" />
    <xsl:with-param name="low"     select="$low" />
    <xsl:with-param name="high"    select="$high" />
    <xsl:with-param name="current" select="$current" />
    <xsl:with-param name="pointer" select="$low" />
  </xsl:call-template>

</xsl:template>

<!--
//*****************************************************************************
// GOOGLE-STYLE helper function
//*****************************************************************************
-->
<xsl:template name="googlestyle_helper">
  <xsl:param name="href" />
  <xsl:param name="low" />
  <xsl:param name="high" />
  <xsl:param name="current" />
  <xsl:param name="pointer" />

  <xsl:if test="$pointer &lt;= $high">
    <xsl:choose>
      <xsl:when test="$pointer = $current">
        <!-- current pointer is made bold -->
        <b><xsl:value-of select="$pointer" /></b>
      </xsl:when>
      <xsl:otherwise>
        <a href="{$href}{$pointer}"><xsl:value-of select="$pointer" /></a>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:text> </xsl:text>

    <xsl:call-template name="googlestyle_helper">
      <xsl:with-param name="href"    select="$href" />
      <xsl:with-param name="low"     select="$low" />
      <xsl:with-param name="high"    select="$high" />
      <xsl:with-param name="current" select="$current" />
      <xsl:with-param name="pointer" select="$pointer + 1" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<!--
//*****************************************************************************
// SCROLLING - create links to jump to first/prev/next/last item of current set
//*****************************************************************************
-->
<xsl:template name="scrolling">
  <xsl:param name="object" />

  <xsl:variable name="paging_href" select='concat($script, "?", $session, "&amp;scrolling=", $object, "&amp;item=")' />

  <xsl:if test="not($print-preview)">

    <div class="scrolling">

      <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->

      <!-- look for the entry with the specified value in the id attribute -->
      <xsl:for-each select="/root/scrolling/scroll[@id=$object]">

        <!-- include only if there is more than 1 item -->
        <xsl:if test="@lastitem &gt; 1">

          <xsl:choose>
            <xsl:when test="@curitem &lt;= 1">
              <!-- we are on item 1, so there is no navigation backwards -->
              <xsl:text>&#171;</xsl:text><xsl:value-of select="$first"/>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:text>&#8249;</xsl:text><xsl:value-of select="$prev"/>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert links for first/previous item -->
              <a href="{$paging_href}1"><b>&#171;<xsl:value-of select="$first"/></b></a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="{$paging_href}{@curitem -1}"><b>&#8249;<xsl:value-of select="$prev"/></b></a>
            </xsl:otherwise>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="$scrolling_width > 0">
              <!-- insert "(page (x-2) (x-1) x (x+1) (x+2) of y)" -->
              <xsl:text>&#160;&#160;(</xsl:text><xsl:value-of select="$item"/><xsl:text> </xsl:text>
              <xsl:call-template name="googlestyle">
                <xsl:with-param name="href" select="$paging_href" />
                <xsl:with-param name="first" select="1" />
                <xsl:with-param name="last" select="@lastitem" />
                <xsl:with-param name="current" select="@curitem" />
                <xsl:with-param name="swing" select="$scrolling_width" />
              </xsl:call-template>
              <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
              <xsl:value-of select="@lastitem"/><xsl:text>)&#160;&#160;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert "item x of y" -->
              <xsl:text>&#160;&#160;</xsl:text><xsl:value-of select="$item"/><xsl:text> </xsl:text>
              <xsl:value-of select="@curitem"/>
              <xsl:text> </xsl:text><xsl:value-of select="$of"/><xsl:text> </xsl:text>
              <xsl:value-of select="@lastitem"/><xsl:text>&#160;&#160;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="@curitem = @lastitem">
              <!-- we are on the last item, so there is no navigation forwards -->
              <xsl:value-of select="$next"/><xsl:text>&#8250;</xsl:text>
              <xsl:text>&#160;&#160;</xsl:text>
              <xsl:value-of select="$last"/><xsl:text>&#187;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <!-- insert links for last/next item -->
              <a href="{$paging_href}{@curitem +1}"><b><xsl:value-of select="$next"/>&#8250;</b></a>
              <xsl:text>&#160;&#160;</xsl:text>
              <a href="{$paging_href}{@lastitem}"><b><xsl:value-of select="$last"/>&#187;</b></a>
            </xsl:otherwise>
          </xsl:choose>

        </xsl:if>

      </xsl:for-each>

    </div>

  </xsl:if>

</xsl:template> <!-- SCROLLING -->

</xsl:stylesheet>
