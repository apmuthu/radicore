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

<!-- get the name of the MAIN table -->
<xsl:variable name="main" select="/root/structure/main/@id"/>

<xsl:template match="/">

  <html xml:lang="{/root/params/language}" lang="{/root/params/language}">

  <xsl:call-template name="head" />

  <body>
    <xsl:attribute name="class">
      <xsl:value-of select="/root/params/script_short" />
    </xsl:attribute>

    <xsl:call-template name="body-head" />

    <form id="{/root/params/script_short}" method="post" action="{$script}">
  
      <div>
        <xsl:attribute name="class">
          <xsl:choose>
            <xsl:when test="$mode='recover'">recover</xsl:when>
            <xsl:otherwise>logon</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
  
        <!-- create help button -->
        <xsl:call-template name="logon_help" />
  
        <div class="body">
  
          <div class="title">
            <h1 class="title"><xsl:value-of select="$title"/></h1>
          </div>
  
          <div class="main">
  
            <!-- insert dummy table for use by optional javascript functions -->
            <xsl:if test="/root/javascript/tbody">
              <table>
                <tbody>
                  <xsl:for-each select="/root/javascript/tbody[@*]">
                    <!-- add javascript events to the <tbody> tag -->
                    <xsl:copy-of select="@*" />
                  </xsl:for-each>
                </tbody>
              </table>
            </xsl:if>
  
            <!-- table contains a row for each database field -->
            <table>
  
              <!-- process the first row in the MAIN table of the XML file -->
              <xsl:for-each select="/root/*[name()=$main][1]">
  
                <!-- display all the fields in the current record -->
                <xsl:call-template name="display_vertical">
                  <xsl:with-param name="zone"   select="'main'"/>
                  <xsl:with-param name="data"   select="."/>
                  <xsl:with-param name="noedit" select="string(/root/params/main_noedit)"/>
                </xsl:call-template>
  
              </xsl:for-each>
  
            </table>
          </div> <!-- main -->
  
          <!-- look for optional messages -->
          <xsl:call-template name="message"/>
  
          <!-- create standard action buttons -->
          <xsl:call-template name="actbar"/>
  
        </div> <!-- body -->
  
      </div>
  
    </form>

    <xsl:call-template name="body-foot" />

  </body>
  </html>

</xsl:template>
  
  <!--
//*****************************************************************************
// LOGON_HELP - create hyperlinks for HELP and RECOVER PASSWORD
//*****************************************************************************
-->
  <xsl:template name="logon_help">
       
    <div class="help">
      <p>
                
        <xsl:if test="$mode='logon'">
          <!-- create a password recovery link (if text is present) -->
          <xsl:if test="/root/params/text/recover-pswd">
            <xsl:choose>
              <xsl:when test="/root/params/icon/recover-pswd">
                <!-- display image link -->
                <a href="{$script}?action=recoverpswd&amp;{$session}" class="no-underline">
                  <img border="0" class="bottom" height="{/root/params/icon/size}">
                    <xsl:attribute name="src">
                      <xsl:value-of select="concat($doc_root,/root/params/icon/recover-pswd)"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                      <xsl:value-of select="/root/params/text/recover-pswd"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:value-of select="/root/params/text/recover-pswd"/>
                    </xsl:attribute>
                  </img>
                </a>
                <xsl:text> | </xsl:text>
              </xsl:when>
              <xsl:when test="/root/params/text/recover-pswd">
                <!-- display text link -->
                <a href="{$script}?action=recoverpswd&amp;{$session}"><xsl:value-of select="/root/params/text/recover-pswd"/></a>
                <xsl:text> | </xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:if>
        </xsl:if>
        
        <!-- create a HELP link -->
        <xsl:choose>
          <xsl:when test="/root/params/icon/help">
            <!-- display image link -->
            <a href="{$help_root}/help.php?{$session}&amp;taskid={$taskid}" class="no-underline" onclick="window.open(this.href);return false;">
              <img border="0" class="bottom" height="{/root/params/icon/size}">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/help)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/help"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="/root/params/text/help"/>
                </xsl:attribute>
              </img>
            </a>
          </xsl:when>
          <xsl:when test="/root/params/text/help">
            <!-- display text link -->
            <a href="{$help_root}/help.php?{$session}&amp;taskid={$taskid}" onclick="window.open(this.href);return false;">
              <xsl:value-of select="/root/params/text/help"/>
            </a>
          </xsl:when>
        </xsl:choose>
        <xsl:text> </xsl:text>
      </p>
    </div>
    
  </xsl:template> <!-- HELP -->

</xsl:stylesheet>
