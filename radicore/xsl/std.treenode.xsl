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

<xsl:output method="xml" 
            indent="yes"
            encoding="UTF-8"
/>
  
<!-- display details for a tree node (horizontally) -->
<xsl:template name="display_tree_node">
  <xsl:param name="zone"/>   <!-- could be 'main', 'inner', 'outer', etc -->

  <xsl:variable name="table" select="name()"/>          <!-- current table name -->
  <xsl:variable name="position" select="position()"/>   <!-- current row within table -->

  <!-- obtain the names used for each of the node components -->
  <xsl:variable name="id" select="/root/structure/*[name()=$zone]/node_data_names/@id"/>
  <xsl:variable name="desc" select="/root/structure/*[name()=$zone]/node_data_names/@desc"/>
  <xsl:variable name="depth" select="/root/structure/*[name()=$zone]/node_data_names/@depth"/>
  <xsl:variable name="child_count" select="/root/structure/*[name()=$zone]/node_data_names/@child_count"/>
  <xsl:variable name="expanded" select="/root/structure/*[name()=$zone]/node_data_names/@expanded"/>
  <xsl:variable name="icon" select="/root/structure/*[name()=$zone]/node_data_names/@icon"/>

  <tr>
    <!-- set the row class to 'odd' or 'even' to determine the colour -->
    <xsl:attribute name="class">
      <xsl:choose>
        <xsl:when test="position()mod 2">odd</xsl:when>
        <xsl:otherwise>even</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <td>
      <!-- this cell contains the checkbox to make selections -->
      <xsl:call-template name="selectbox"/>
    </td>

    <!-- these table cells contain the actual data -->
    <td>
      <xsl:call-template name="tree_node">
        <!-- use the data names obtained previously -->
        <xsl:with-param name="id" select="//*[name()=$table][position()=$position]/*[name()=$id]"/>
        <xsl:with-param name="desc" select="//*[name()=$table][position()=$position]/*[name()=$desc]"/>
        <xsl:with-param name="depth" select="//*[name()=$table][position()=$position]/*[name()=$depth]"/>
        <xsl:with-param name="child_count" select="//*[name()=$table][position()=$position]/*[name()=$child_count]"/>
        <xsl:with-param name="expanded" select="//*[name()=$table][position()=$position]/*[name()=$expanded]"/>
        <xsl:with-param name="icon" select="//*[name()=$table][position()=$position]/*[name()=$icon]"/>
        <xsl:with-param name="f-s-depth" select="//*[name()=$table][position()=$position+1]/*[name()=$depth]"/>
      </xsl:call-template>
    </td>

  </tr>

</xsl:template> <!-- display_tree_node -->



<!--
****************************************************************************************
* TREENODE - display a node from a tree structure
****************************************************************************************
-->
<xsl:template name="tree_node">
  <xsl:param name="id"/>
  <xsl:param name="desc"/>
  <xsl:param name="depth"/>
  <xsl:param name="child_count"/>
  <xsl:param name="expanded"/>
  <xsl:param name="icon"/>
  <xsl:param name="f-s-depth"/> <!-- following sibling depth -->

  <!-- insert a bookmark -->
  <a name="{$id}"></a>

  <xsl:variable name="has-sibling">
    <xsl:choose>
      <xsl:when test="$f-s-depth = $depth">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:call-template name="indent">
    <xsl:with-param name="depth" select="$depth"/>
    <xsl:with-param name="has-sibling" select="$has-sibling"/>
  </xsl:call-template>

  <xsl:choose>
    <xsl:when test="$child_count > 0">

      <!-- insert button for 'expand' or 'collapse', as appropriate -->
      <xsl:choose>
        <xsl:when test="$expanded">
          <!-- item is expanded, so insert 'collapse' button -->
          <a href="{$script}?{$session}&amp;collapse={$id}#{$id}">
            <img src="{$imagedir}minus.gif" height="21" width="16" alt="Collapse Thread" />
          </a>
        </xsl:when>
        <xsl:otherwise>
          <!-- item is collapsed, so insert 'expand' button -->
          <a href="{$script}?{$session}&amp;expand={$id}#{$id}">
            <img src="{$imagedir}plus.gif" height="21" width="16" alt="Expand Thread" />
          </a>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:when>
    <xsl:otherwise>
      <!-- no children, so insert blank spacer -->
      <img src="{$imagedir}dash.gif" height="21" width="9" />
    </xsl:otherwise>
  </xsl:choose>

  <xsl:if test="$icon"> <!-- insert icon if image name supplied -->
    <span class="icon">
      <img src="{$icon}" height="16" width="16" alt="{$icon}"/>
      <xsl:text> </xsl:text>
    </span>
  </xsl:if>

  <span>
    <xsl:choose>
      <!-- default class is 'text' -->
      <xsl:when test="$desc/@css_class">
        <!-- include additional CSS class name(s) -->
        <xsl:attribute name="class"><xsl:value-of select="concat('text ',$desc/@css_class)"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="class">text</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
    <!-- now include the description's text -->
    <xsl:value-of select="$desc" />
    <!-- check if field has error attribute set -->
    <xsl:if test="$desc/@error">
      <br/><span class="error"><xsl:value-of select="$desc/@error"/></span>
    </xsl:if>
  </span>

</xsl:template> <!-- tree_node -->



<xsl:template name="indent">
  <xsl:param name="depth"/>
  <xsl:param name="has-sibling"/>

  <!-- for each of $depth > 1 insert a spacer -->
  <xsl:if test="$depth > 1">

    <xsl:choose>
      <xsl:when test="$depth=2">
        <xsl:choose>
          <xsl:when test="$has-sibling='yes'">
            <!-- insert tee symbol to link with following sibling -->
            <img src="{$imagedir}tee.gif" height="21" width="16" alt='tee.gif' />
          </xsl:when>
          <xsl:otherwise>
            <!-- no following sibling, so insert angle symbol -->
            <img src="{$imagedir}angle.gif" height="21" width="16" alt='angle.gif' />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- insert spacer -->
        <img src="{$imagedir}spacer.gif" height="21" width="16" />
      </xsl:otherwise>
    </xsl:choose>

    <!-- recursive call with $depth decremented -->
    <xsl:call-template name="indent">
      <xsl:with-param name="depth" select="$depth -1"/>
      <xsl:with-param name="has-sibling" select="$has-sibling"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template> <!-- indent -->

</xsl:stylesheet>
