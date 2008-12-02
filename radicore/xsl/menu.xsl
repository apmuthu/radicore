<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml">

<!--
//*****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
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

<xsl:variable name="todo-user" select="/root/params/text/todo-user"/>
<xsl:variable name="workitems-for-role" select="/root/params/text/workitems-for-role"/>
<xsl:variable name="workitems-for-user" select="/root/params/text/workitems-for-user"/>
<xsl:variable name="numrows">1</xsl:variable>

<xsl:template match="/"> <!-- standard match to include all child elements -->

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">
    <xsl:call-template name="head" />
  <body>
    <xsl:call-template name="body-head" />

    <form method="post" action="{$script}">
  
      <div class="universe">
  
        <!-- create help button -->
        <xsl:call-template name="help" />
  
        <!-- create menu buttons -->
        <xsl:call-template name="menubar" />
  
        <div class="body">
  
          <h1>
            <!-- include optional icon -->
            <xsl:if test="/root/params/icon/home">
              <img class="middle" height="20">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/home)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/home"/>
                </xsl:attribute>
              </img>
              <xsl:text> </xsl:text>
            </xsl:if>
            <!-- end icon -->
            <xsl:value-of select="$title"/>
          </h1>
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar_detail" />
  
          <div class="todo_user">
            <!-- include todo items for the current user -->
            <xsl:call-template name="todo_user"/>
          </div>
  
          <div class="workitem_role">
            <!-- include workitems for the current role -->
            <xsl:call-template name="workitem_role"/>
          </div>
  
          <div class="workitem_user">
            <!-- include workitems for the current user -->
            <xsl:call-template name="workitem_user"/>
          </div>
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar"/>
  
        </div>
  
      </div>
  
    </form>

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>

<xsl:template name="todo_user">

  <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->

  <xsl:if test="/root/mnu_todo/user_id">

    <h2><xsl:value-of select="$todo-user"/>: <xsl:value-of select="//mnu_todo/user_id"/></h2>

    <xsl:for-each select="/root/mnu_todo" >
      <p>
        <xsl:if test="due_date/@css_class">
           <xsl:attribute name="class"><xsl:value-of select="due_date/@css_class" /></xsl:attribute>
        </xsl:if>

        <xsl:value-of select="due_date" />
        <xsl:text> - </xsl:text>
        <xsl:value-of select="item_desc" />
      </p>
    </xsl:for-each>

    <!-- insert the pagination links for WORKITEM_ROLE -->
    <xsl:call-template name="pagination" >
      <xsl:with-param name="object" select="'mnu_todo'"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template>

<xsl:template name="workitem_role">

  <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->

  <xsl:if test="/root/wf_workitem_role/role_id">

    <h2><xsl:value-of select="$workitems-for-role"/>: <xsl:value-of select="/root/wf_workitem_role/role_id"/></h2>

    <xsl:for-each select="/root/wf_workitem_role" >
      <xsl:call-template name="workitem"/>
    </xsl:for-each>

    <!-- insert the pagination links for WORKITEM_ROLE -->
    <xsl:call-template name="pagination" >
      <xsl:with-param name="object" select="'workitem_role'"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template>

<xsl:template name="workitem_user">

  <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->

  <xsl:if test="/root/wf_workitem_user/user_id">

    <h2><xsl:value-of select="$workitems-for-user"/>: <xsl:value-of select="/root/wf_workitem_user/user_id"/></h2>

    <xsl:for-each select="/root/wf_workitem_user" >
      <xsl:call-template name="workitem"/>
    </xsl:for-each>

    <!-- insert the pagination links for WORKITEM_USER -->
    <xsl:call-template name="pagination" >
      <xsl:with-param name="object" select="'workitem_user'"/>
    </xsl:call-template>

  </xsl:if>

</xsl:template>

<xsl:template name="workitem">

  <p>
    <a href="{$script}?{$session}&amp;case_id={case_id}&amp;workitem_id={workitem_id}">
      <xsl:value-of select="task_desc" />
      <xsl:text> where </xsl:text>
      <xsl:value-of select="context" />
    </a>
  </p>

</xsl:template>

</xsl:stylesheet>
