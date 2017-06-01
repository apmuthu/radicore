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
            omit-xml-declaration="yes"
            doctype-system="about:legacy-compat"
            encoding="UTF-8"
/>

<!-- include common templates -->
<xsl:include href="std.buttons.xsl"/>
<xsl:include href="std.column_hdg.xsl"/>
<xsl:include href="std.data_field.xsl"/>
<xsl:include href="std.head.xsl"/>

<xsl:variable name="numrows">1</xsl:variable>

<xsl:variable name="max_file_size" select="/root/fileupload/maxfilesize"/>

<xsl:template match="/">

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>
    
    <xsl:call-template name="body-head" />

    <form enctype="multipart/form-data" method="post" action="{$script}">
  
      <div class="universe">
  
        <!-- create help button -->
        <xsl:call-template name="help" />
  
        <!-- create menu buttons -->
        <xsl:call-template name="menubar" />
  
        <div class="body">
  
          <div class="title">
            <h1 class="title"><xsl:value-of select="$title"/></h1>
          </div>
  
          <!-- create navigation buttons -->
          <xsl:call-template name="navbar_detail" />
  
          <div class="main">
            <div class="uploadbg">
              <div class="upload">
                <!-- create standard action buttons -->
                <!--<p><input name ="MAX_FILE_SIZE" type="hidden" value="{$max_file_size}" /></p>-->
  
                <p><xsl:value-of select="/root/fileupload/msg1" /> <input name="userfile" type="file" size="40" /></p>
                <p><xsl:value-of select="/root/fileupload/msg2" /></p>
                <p><xsl:value-of select="/root/fileupload/msg3" /></p>
                <p><xsl:value-of select="/root/fileupload/msg4" /></p>
  
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

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>

</xsl:stylesheet>
