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

<xsl:variable name="numrows">1</xsl:variable>

<xsl:variable name="max_file_size" select="/root/file/maxfilesize"/>

<xsl:template match="/">

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

  <form enctype="multipart/form-data" method="post" action="{$script}">

    <div class="universe">

      <!-- create help button -->
      <xsl:call-template name="help" />

      <!-- create menu buttons -->
      <xsl:call-template name="menubar" />

      <div class="body">

        <h1><xsl:value-of select="$title"/></h1>

        <!-- create navigation buttons -->
        <xsl:call-template name="navbar_detail" />

        <div class="main">
          <div class="uploadbg">
            <div class="upload">
              <!-- create standard action buttons -->
              <p><input name ="MAX_FILE_SIZE" type="hidden" value="{$max_file_size}" /></p>

              <p><xsl:value-of select="/root/file/msg1" /> <input name="userfile" type="file" /></p>
              <p><xsl:value-of select="/root/file/msg2" /></p>
              <p><xsl:value-of select="/root/file/msg3" /></p>

            </div>
          </div>
        </div>

        <!-- look for optional messages -->
        <xsl:call-template name="message"/>

        <!-- create standard action buttons -->
        <xsl:call-template name="actbar"/>

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

</xsl:stylesheet>