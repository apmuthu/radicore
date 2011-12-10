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
  
<xsl:variable name="script"       select="/root/params/script"/>
<xsl:variable name="mode"         select="/root/params/mode"/>
<xsl:variable name="session_name" select="/root/params/session_name"/>
<xsl:variable name="script_time"  select="/root/params/script_time"/>
<xsl:variable name="doc_root"     select="/root/params/doc_root"/>
<xsl:variable name="help_root"    select="/root/params/help_root"/>
<xsl:variable name="taskid"       select="/root/params/taskid"/>
  
<xsl:variable name="session"      select="concat('session_name=',$session_name)" />

<xsl:variable name="show"         select="/root/params/text/show"/>
<xsl:variable name="page-created" select="/root/params/text/page-created"/>
<xsl:variable name="seconds"      select="/root/params/text/seconds"/>

<xsl:variable name="select-all"     select="/root/params/text/select-all"/>
<xsl:variable name="unselect-all"   select="/root/params/text/unselect-all"/>
<xsl:variable name="selection-lock" select="/root/params/text/selection-lock"/>

<xsl:variable name="client-side"   select="/root/params/client-side"/>
<xsl:variable name="print-preview" select="/root/params/print-preview"/>

<!--
//*****************************************************************************
// ACTBAR - create buttons in the action bar
//*****************************************************************************
-->
<xsl:template name="actbar">

  <xsl:if test="not($print-preview)">

    <div class="actionbar">

      <div class="left">
        <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->
        <xsl:for-each select="/root/actbar/button[starts-with(@id,'submit') or starts-with(@id,'choose')]">
          <!-- create a button for each element within actionbar -->
          <input class="submit" type="submit" name="{@id}" value="{node()}" />
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </div>

      <div class="right">
        <xsl:text> </xsl:text>  <!-- insert a space to prevent an empty element -->
        <xsl:for-each select="/root/actbar/button[not(starts-with(@id,'submit')) and not(starts-with(@id,'choose'))]">
          <!-- create a button for each element within actionbar -->
          <input class="submit" type="submit" name="{@id}" value="{node()}" />
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </div>

    </div>

  </xsl:if>

  <!-- create a hidden field for session_name -->
  <xsl:if test="$session_name">
    <input type="hidden" name="session_name" value="{$session_name}" />
  </xsl:if>

  <xsl:if test="not($print-preview) and string-length($script_time) > 0">

    <xsl:choose>
      <xsl:when test="$mode='logon'">
        <p class="scripttime"><xsl:value-of select="$page-created"/>&#160;<xsl:value-of select="$script_time"/>&#160;<xsl:value-of select="$seconds"/></p>
        <xsl:if test="not($client-side)">
          <p class="scripttime">(XSLT= $xsl$ <xsl:value-of select="$seconds"/>)</p>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <p class="scripttime">
          <xsl:value-of select="$page-created"/>&#160;<xsl:value-of select="$script_time"/>&#160;<xsl:value-of select="$seconds"/>
          <xsl:if test="not($client-side)">
            (XSLT= $xsl$ <xsl:value-of select="$seconds"/>)
          </xsl:if>
        </p>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:if>

</xsl:template> <!-- ACTBAR -->



<!--
//*****************************************************************************
// HELP - create hyperlinks for HELP, LOGOUT, NEW SESSION and PRINT
//*****************************************************************************
-->
<xsl:template name="help">

  <!-- show logon identity -->
  <xsl:if test="/root/params/text/logged-in-as">
    <!-- do not include this in the sample application -->
    <xsl:if test="not(/root/params/application='sample')">
      <!-- do not include this in the logon screen -->
      <xsl:if test="not($mode='logon') and not ($mode='recover')">
        <div class="loggedinas">
          <xsl:choose>
            <xsl:when test="/root/params/icon/logged-in-as">
              <!-- create image -->
              <img class="bottom" height="{/root/params/icon/size}">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/logged-in-as)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/logged-in-as"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="/root/params/text/logged-in-as"/>
                </xsl:attribute>
              </img>
            </xsl:when>
            <xsl:otherwise>
              <!-- create text -->
              <xsl:value-of select="/root/params/text/logged-in-as"/>
            </xsl:otherwise>
          </xsl:choose>

          <!-- display user name -->
          <xsl:text> </xsl:text>
          <xsl:value-of select="/root/params/logged-in-as"/>
        </div>
      </xsl:if>
    </xsl:if>
  </xsl:if>

  <div class="help">
    <p>
      <xsl:if test="not($mode='logon') and not ($mode='recover')">

        <!-- create a link to add current ask to favourites -->
        <xsl:choose>
          <xsl:when test="/root/params/icon/add-to-favourites">
            <!-- create image link -->
            <a href="{$script}?action=add-to-favourites&amp;{$session}" class="no-underline">
              <img border="0" class="bottom" height="{/root/params/icon/size}">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/add-to-favourites)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/add-to-favourites"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="/root/params/text/add-to-favourites"/>
                </xsl:attribute>
              </img>
            </a>
            <xsl:text> | </xsl:text>
          </xsl:when>
          <xsl:when test="/root/params/text/add-to-favourites">
            <!-- create text link -->
            <a href="{$script}?action=add-to-favourites&amp;{$session}" ><xsl:value-of select="/root/params/text/add-to-favourites"/></a>
            <xsl:text> | </xsl:text>
          </xsl:when>
        </xsl:choose>
        
        <!-- create a logout link to close current session -->
        <xsl:choose>
          <xsl:when test="/root/params/icon/logout">
            <!-- create image link -->
            <a href="{$script}?action=logout&amp;{$session}" class="no-underline">
              <img border="0" class="bottom" height="{/root/params/icon/size}">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/logout)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/logout"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="/root/params/text/logout"/>
                </xsl:attribute>
              </img>
            </a>
            <xsl:text> | </xsl:text>
          </xsl:when>
          <xsl:when test="/root/params/text/logout">
            <!-- create text link -->
            <a href="{$script}?action=logout&amp;{$session}" ><xsl:value-of select="/root/params/text/logout"/></a>
            <xsl:text> | </xsl:text>
          </xsl:when>
        </xsl:choose>

        <!-- create a logout (all) link to close ALL sessions on this client -->
        <xsl:if test="/root/params/text/logout-all">
          <xsl:choose>
            <xsl:when test="/root/params/icon/logout-all">
              <!-- create image link -->
              <a href="{$script}?action=logout_all&amp;{$session}" class="no-underline">
                <img border="0" class="bottom" height="{/root/params/icon/size}">
                  <xsl:attribute name="src">
                    <xsl:value-of select="concat($doc_root,/root/params/icon/logout-all)"/>
                  </xsl:attribute>
                  <xsl:attribute name="alt">
                    <xsl:value-of select="/root/params/text/logout-all"/>
                  </xsl:attribute>
                  <xsl:attribute name="title">
                    <xsl:value-of select="/root/params/text/logout-all"/>
                  </xsl:attribute>
                </img>
              </a>
              <xsl:text> | </xsl:text>
            </xsl:when>
            <xsl:when test="/root/params/text/logout-all">
              <!-- create text link -->
              <a href="{$script}?action=logout_all&amp;{$session}" ><xsl:value-of select="/root/params/text/logout-all"/></a>
              <xsl:text> | </xsl:text>
            </xsl:when>
          </xsl:choose>

          <!-- include optional icon -->

        </xsl:if>

        <!-- create a link to start a new session with a new name and session id) -->
        <xsl:choose>
          <xsl:when test="/root/params/icon/new-session">
            <!-- create image link -->
            <a href="{$script}?action=newsession&amp;{$session}" class="no-underline">
              <img border="0" class="bottom" height="{/root/params/icon/size}">
                <xsl:attribute name="src">
                  <xsl:value-of select="concat($doc_root,/root/params/icon/new-session)"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                  <xsl:value-of select="/root/params/text/new-session"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                  <xsl:value-of select="/root/params/text/new-session"/>
                </xsl:attribute>
              </img>
            </a>
            <xsl:text> | </xsl:text>
          </xsl:when>
          <xsl:when test="/root/params/text/new-session">
            <!-- create text link -->
            <a href="{$script}?action=newsession&amp;{$session}" ><xsl:value-of select="/root/params/text/new-session"/></a>
            <xsl:text> | </xsl:text>
          </xsl:when>
        </xsl:choose>

        <!-- print/noprint options -->
        <xsl:choose>
          <xsl:when test="$print-preview">
            <xsl:choose>
              <xsl:when test="/root/params/icon/noprint">
                <!-- display image link -->
                <a href="{$script}?action=noprint&amp;{$session}" class="no-underline">
                  <img border="0" class="bottom" height="{/root/params/icon/size}">
                    <xsl:attribute name="src">
                      <xsl:value-of select="concat($doc_root,/root/params/icon/noprint)"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                      <xsl:value-of select="/root/params/text/noprint"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:value-of select="/root/params/text/noprint"/>
                    </xsl:attribute>
                  </img>
                </a>
                <xsl:text> | </xsl:text>
              </xsl:when>
              <xsl:when test="/root/params/text/noprint">
                <!-- display text link-->
                <a href="{$script}?action=noprint&amp;{$session}" ><xsl:value-of select="/root/params/text/noprint"/></a>
                <xsl:text> | </xsl:text>
              </xsl:when>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>

            <!-- create a link to redisplay the page in print mode -->
            <xsl:choose>
              <xsl:when test="/root/params/icon/print">
                <!-- display image link -->
                <a href="{$script}?action=print&amp;{$session}" class="no-underline">
                  <img border="0" class="bottom" height="{/root/params/icon/size}">
                    <xsl:attribute name="src">
                      <xsl:value-of select="concat($doc_root,/root/params/icon/print)"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                      <xsl:value-of select="/root/params/text/print"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:value-of select="/root/params/text/print"/>
                    </xsl:attribute>
                  </img>
                </a>
                <xsl:text> | </xsl:text>
              </xsl:when>
              <xsl:when test="/root/params/text/print">
                <!-- display text link -->
                <a href="{$script}?action=print&amp;{$session}" ><xsl:value-of select="/root/params/text/print"/></a>
                <xsl:text> | </xsl:text>
              </xsl:when>
            </xsl:choose>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

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
          <a href="{$help_root}/help.php?{$session}&amp;taskid={$taskid}" class="no-underline">
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
          <a href="{$help_root}/help.php?{$session}&amp;taskid={$taskid}"><xsl:value-of select="/root/params/text/help"/></a>
        </xsl:when>
      </xsl:choose>
      <xsl:text> </xsl:text>
    </p>
  </div>

</xsl:template> <!-- HELP -->




<!--
//*****************************************************************************
// MENUBAR - create hyperlinks for each option on the current menu
//*****************************************************************************
-->
<xsl:template name="menubar">

  <xsl:if test="not($print-preview)">

    <div id="menubar">
      <!-- produce a list of menu items, with the one which is active being highlighted -->
      <ul>
        <xsl:for-each select="/root/menubar/button">
          <li>
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="@active">active</xsl:when>
                <xsl:otherwise>inactive</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>

            <!-- create a link for each element within menubar -->
            <xsl:choose>
              <xsl:when test="/root/params/application='sample'">
                <!-- this is for the sample application -->
                <a href="{$help_root}/{@id}?{$session}"><xsl:value-of select="node()"/></a>
              </xsl:when>
              <xsl:otherwise>
                <!-- this is for the full application -->
                <a href="{$script}?selection={@id}&amp;{$session}"><xsl:value-of select="node()"/></a>
              </xsl:otherwise>
            </xsl:choose>

          </li>
        </xsl:for-each>
      </ul>
    </div>

    <div id="menustack-outer">
      <div id="menustack">

        <!-- this area is the same colour as the active item in the previous line -->
        <!-- it also contains entries for each page in the current hierarchy (aka 'breadcrumbs') -->
        <ul>

          <xsl:for-each select="/root/menubar/stack">
           <li>
              <xsl:choose>
                <xsl:when test="position()=last() or @active">
                  <!-- last/active entry is not a hyperlink, just plain text -->
                  <xsl:value-of select="node()"/>
                </xsl:when>
                <xsl:otherwise>
                  <!-- insert hyperlink -->
                  <a href="{$script}?selection={@id}&amp;{$session}">
                    <xsl:value-of select="node()"/>
                  </a>
                </xsl:otherwise>
              </xsl:choose>

              <xsl:if test="not(position()=last())">
                <!-- not last entry, so insert a '>>' separator before the next one -->
                <xsl:text>&#187;</xsl:text>
              </xsl:if>
            </li>
          </xsl:for-each>

        </ul>

        <!-- insert a blank paragraph to get round a bug in the Firefox browser -->
        <p>&#160;</p>

      </div>
    </div>

  </xsl:if>

</xsl:template> <!-- MENUBAR -->



<!--
//*****************************************************************************
// NAVBAR - create buttons in the navigation bar
//*****************************************************************************
-->
<xsl:template name="navbar"> <!-- this version is for LIST screens -->
  <xsl:param name="noshow"/>    <!-- if this is set do not include options to change page size -->
  <xsl:param name="noselect"/>  <!-- if this is set do not include options to select/unselect all -->

  <div class="navbar">

    <xsl:if test="/root/navbar/*[@context_preselect='N']">
      <!-- pick out the entries that do not require a selection to be made -->
      <p class="withoutselection">
        <xsl:for-each select="/root/navbar/*[@context_preselect='N']">
            <!-- create a button for each element within navbar -->
            <input class="submit" type="submit" name="{@id}" value="{node()}" />
            <xsl:text> </xsl:text>
        </xsl:for-each>
      </p>
    </xsl:if>

    <xsl:if test="not($noshow)">
      <!-- these links will allow the user to change the number of rows in the page -->
      <p class="show" >
        <xsl:choose>
          <xsl:when test="$numrows > 10">
            <a href="{$script}?{$session}&amp;pagesize=10"><xsl:value-of select="$show"/> 10</a>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="$show"/> 10</xsl:otherwise>
        </xsl:choose>
        <xsl:text> | </xsl:text>

        <xsl:choose>
          <xsl:when test="$numrows > 10">
            <a href="{$script}?{$session}&amp;pagesize=25"><xsl:value-of select="$show"/> 25</a>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="$show"/> 25</xsl:otherwise>
        </xsl:choose>
        <xsl:text> | </xsl:text>

        <xsl:choose>
          <xsl:when test="$numrows > 25">
            <a href="{$script}?{$session}&amp;pagesize=50"><xsl:value-of select="$show"/> 50</a>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="$show"/> 50</xsl:otherwise>
        </xsl:choose>
        <xsl:text> | </xsl:text>

        <xsl:choose>
          <xsl:when test="$numrows > 50">
            <a href="{$script}?{$session}&amp;pagesize=100"><xsl:value-of select="$show"/> 100</a>
          </xsl:when>
          <xsl:otherwise><xsl:value-of select="$show"/> 100</xsl:otherwise>
        </xsl:choose>

        <!-- insert "(of nnn)" -->
        <xsl:text>&#160;(</xsl:text>
        <xsl:value-of select="/root/params/text/of"/>
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="$numrows"/>
        <xsl:text>)&#160;</xsl:text>
      </p>
    </xsl:if>

    <xsl:if test="not($noselect)">
      <xsl:choose>
        <xsl:when test="not($select_one)">
          <!-- only display if the $select_one parameter is not set -->
          <p class="selection">
            <!-- these links will allow the user to toggle all select boxes either ON or OFF -->
            <!-- do this only if there is a field called 'selectbox' -->
            <xsl:if test="/root/structure/*/row/cell[@field='selectbox']">
              <xsl:text>Selections:&#160;</xsl:text>
              <a href="{$script}?{$session}&amp;action=selectall"><xsl:value-of select="$select-all"/></a>
              <xsl:text> | </xsl:text>
              <a href="{$script}?{$session}&amp;action=unselectall"><xsl:value-of select="$unselect-all"/></a>
              
              <xsl:if test="$selection-lock">  <!-- optional -->
                <xsl:text> | </xsl:text>
                <!-- allow the selection to be locked so that the same records are marked as 'selected' 
                     when returning to this screen -->
                <label for="rdc_selection_lock"><xsl:value-of select="$selection-lock"/></label>
                <input type="hidden"   name="rdc_selection_lock" value="0" />              <!-- default is OFF -->
                <input type="checkbox" name="rdc_selection_lock" id="rdc_selection_lock">  <!-- may be changed to ON -->
                  <xsl:if test="/root/params/selection_lock">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                </input>
              </xsl:if>
              
            </xsl:if>
            <!-- insert a non-breaking space -->
            <xsl:text>&#160;</xsl:text>
          </p>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="not($noshow)">
            <!-- if 'show' paragraph has been created there must be an empty 'selection' paragraph -->
            <p class="selection">&#160;</p>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    <xsl:if test="/root/navbar/*[@context_preselect='Y']">
      <!-- pick out the entries that require a selection to be made before the button is pressed -->
      <p class="withselection">
        <xsl:for-each select="/root/navbar/*[@context_preselect='Y']">
            <!-- create a button for each element within navbar -->
            <input class="submit" type="submit" name="{@id}" value="{node()}" />
            <xsl:text> </xsl:text>
        </xsl:for-each>
      </p>
    </xsl:if>

  </div>

</xsl:template>


<!-- this version is for DETAIL screens -->
<xsl:template name="navbar_detail">

  <xsl:if test="count(/root/navbar/*)&gt;0">

    <div class="navbar">
      <!-- no preselection is required as everything works off the current record -->
      <p class="withoutselection">
        <xsl:for-each select="/root/navbar/*">
            <!-- create a button for each element within navbar -->
            <input class="submit" type="submit" name="{@id}" value="{node()}" />
            <xsl:text> </xsl:text>
        </xsl:for-each>
      </p>
    </div>

  </xsl:if>

</xsl:template> <!-- NAVBAR -->

</xsl:stylesheet>
